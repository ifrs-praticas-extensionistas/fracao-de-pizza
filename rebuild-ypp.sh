#!/usr/bin/env bash
# =============================================================================
# rebuild_yyp.sh
# Rebuilds the dynamic sections of a GameMaker .yyp file from disk.
#
# Sections rebuilt:
#   - resources[]       — scanned from all *.yy files on disk
#   - IncludedFiles[]   — scanned from the datafiles/ folder
#   - RoomOrderNodes[]  — scanned from rooms/ folder, order preserved if possible
#
# Sections left untouched:
#   - TextureGroups, AudioGroups, Options, tags, name, resourceVersion, etc.
#
# Usage:
#   bash rebuild_yyp.sh
#   bash rebuild_yyp.sh /path/to/project
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------

log()  { echo "[rebuild_yyp] $*"; }
err()  { echo "[rebuild_yyp] ERROR: $*" >&2; exit 1; }
warn() { echo "[rebuild_yyp] WARNING: $*" >&2; }

# -----------------------------------------------------------------------------
# Locate project root
# -----------------------------------------------------------------------------

if [ -n "${1:-}" ]; then
  PROJECT_ROOT="$1"
else
  # If inside a git repo, use its root. Otherwise use current directory.
  if git rev-parse --show-toplevel &>/dev/null 2>&1; then
    PROJECT_ROOT="$(git rev-parse --show-toplevel)"
  else
    PROJECT_ROOT="$(pwd)"
  fi
fi

cd "$PROJECT_ROOT" || err "Cannot cd into '$PROJECT_ROOT'"

# -----------------------------------------------------------------------------
# Find the .yyp file
# -----------------------------------------------------------------------------

YYP_FILE=""
while IFS= read -r -d '' f; do
  if [ -n "$YYP_FILE" ]; then
    err "Multiple .yyp files found in '$PROJECT_ROOT'. Please specify which project to use."
  fi
  YYP_FILE="$f"
done < <(find "$PROJECT_ROOT" -maxdepth 1 -name "*.yyp" -print0)

[ -z "$YYP_FILE" ] && err "No .yyp file found in '$PROJECT_ROOT'."
[ -f "$YYP_FILE" ] || err "Found .yyp path '$YYP_FILE' but it is not a regular file."

YYP_NAME="$(basename "$YYP_FILE")"
log "Found project file: $YYP_NAME"

# Keep a backup in case something goes wrong
BACKUP_FILE="${YYP_FILE}.bak"
cp "$YYP_FILE" "$BACKUP_FILE"

# -----------------------------------------------------------------------------
# Helper: extract a field value from a .yy file using grep + sed
# Works on the GameMaker JSON-like format (may have trailing commas)
# Usage: extract_field <file> <fieldname>
# -----------------------------------------------------------------------------

extract_field() {
  local file="$1"
  local field="$2"
  # Matches: "fieldname": "value"  (with optional trailing comma)
  grep -m1 "\"${field}\"" "$file" \
    | sed 's/.*"'"$field"'" *: *"\([^"]*\)".*/\1/'
}

# -----------------------------------------------------------------------------
# Build resources[] — all *.yy files except the ones we handle separately
# -----------------------------------------------------------------------------

log "Scanning for .yy resources..."

RESOURCES_JSON=""
RESOURCE_COUNT=0

# Collect all .yy files, sorted for deterministic output
mapfile -d '' YY_FILES < <(
  find "$PROJECT_ROOT" \
    -name "*.yy" \
    -not -path "*/.git/*" \
    -not -path "*/datafiles/*" \
    -print0 \
  | sort -z
)

for yy_file in "${YY_FILES[@]}"; do
  # Get relative path from project root (forward slashes, no leading ./)
  rel_path="${yy_file#"$PROJECT_ROOT"/}"

  # Extract the name field from the .yy file
  name="$(extract_field "$yy_file" "name")"

  if [ -z "$name" ]; then
    warn "Could not extract 'name' from '$rel_path' — skipping."
    continue
  fi

  # Build the resource entry (GameMaker format with trailing commas)
  entry="{\"id\":{\"name\":\"${name}\",\"path\":\"${rel_path}\",},}"

  if [ -n "$RESOURCES_JSON" ]; then
    RESOURCES_JSON="${RESOURCES_JSON}
${entry}"
  else
    RESOURCES_JSON="${entry}"
  fi

  RESOURCE_COUNT=$((RESOURCE_COUNT + 1))
done

[ "$RESOURCE_COUNT" -eq 0 ] && err "No .yy files found — refusing to write an empty resources[]."
log "Found $RESOURCE_COUNT resources."

# -----------------------------------------------------------------------------
# Build IncludedFiles[] — files inside datafiles/
# -----------------------------------------------------------------------------

log "Scanning for included files..."

INCLUDEDFILES_JSON=""
INCLUDEDFILE_COUNT=0
DATAFILES_DIR="$PROJECT_ROOT/datafiles"

if [ -d "$DATAFILES_DIR" ]; then
  mapfile -d '' DATA_FILES < <(
    find "$DATAFILES_DIR" \
      -type f \
      -not -path "*/.git/*" \
      -print0 \
    | sort -z
  )

  for data_file in "${DATA_FILES[@]}"; do
    file_name="$(basename "$data_file")"
    # filePath is the relative directory containing the file (not the file itself)
    rel_dir="$(dirname "${data_file#"$PROJECT_ROOT"/}")"

    entry="{\"CopyToMask\":-1,\"filePath\":\"${rel_dir}\",\"resourceVersion\":\"1.0\",\"name\":\"${file_name}\",\"resourceType\":\"GMIncludedFile\",}"

    if [ -n "$INCLUDEDFILES_JSON" ]; then
      INCLUDEDFILES_JSON="${INCLUDEDFILES_JSON}
${entry}"
    else
      INCLUDEDFILES_JSON="${entry}"
    fi

    INCLUDEDFILE_COUNT=$((INCLUDEDFILE_COUNT + 1))
  done
fi

log "Found $INCLUDEDFILE_COUNT included files."

# -----------------------------------------------------------------------------
# Build RoomOrderNodes[] — rooms in alphabetical order
# (Preserving custom order would require a separate source-of-truth file;
#  for now we sort alphabetically for determinism)
# -----------------------------------------------------------------------------

log "Scanning for rooms..."

ROOMORDER_JSON=""
ROOM_COUNT=0
ROOMS_DIR="$PROJECT_ROOT/rooms"

if [ -d "$ROOMS_DIR" ]; then
  mapfile -d '' ROOM_FILES < <(
    find "$ROOMS_DIR" \
      -name "*.yy" \
      -not -path "*/.git/*" \
      -print0 \
    | sort -z
  )

  for room_file in "${ROOM_FILES[@]}"; do
    rel_path="${room_file#"$PROJECT_ROOT"/}"
    name="$(extract_field "$room_file" "name")"

    if [ -z "$name" ]; then
      warn "Could not extract 'name' from room '$rel_path' — skipping."
      continue
    fi

    entry="{\"roomId\":{\"name\":\"${name}\",\"path\":\"${rel_path}\",},}"

    if [ -n "$ROOMORDER_JSON" ]; then
      ROOMORDER_JSON="${ROOMORDER_JSON}
${entry}"
    else
      ROOMORDER_JSON="${entry}"
    fi

    ROOM_COUNT=$((ROOM_COUNT + 1))
  done
fi

log "Found $ROOM_COUNT rooms."

# -----------------------------------------------------------------------------
# Splice the new sections into the .yyp file using awk
#
# Strategy: read the .yyp line by line. When we find the opening line of a
# section we manage, discard lines until we find the closing ], then inject
# our rebuilt content. All other lines are passed through unchanged.
# -----------------------------------------------------------------------------

log "Rebuilding $YYP_NAME..."

TEMP_FILE="${YYP_FILE}.tmp"

awk \
  -v resources_json="$RESOURCES_JSON" \
  -v includedfiles_json="$INCLUDEDFILES_JSON" \
  -v roomorder_json="$ROOMORDER_JSON" \
'
function inject(label, content,    lines, n, i) {
  # Print the opening line of the section (e.g. "resources": [)
  print $0
  # Print each entry line
  if (content != "") {
    n = split(content, lines, "\n")
    for (i = 1; i <= n; i++) {
      print lines[i]
    }
  }
  # Skip original lines until we find the closing ]
  while ((getline line) > 0) {
    if (line ~ /^[[:space:]]*\]/) {
      print line   # print the closing ]
      return
    }
    # discard original content inside the section
  }
}

{
  if ($0 ~ /"resources"[[:space:]]*:[[:space:]]*\[/) {
    inject("resources", resources_json)
  } else if ($0 ~ /"IncludedFiles"[[:space:]]*:[[:space:]]*\[/) {
    inject("IncludedFiles", includedfiles_json)
  } else if ($0 ~ /"RoomOrderNodes"[[:space:]]*:[[:space:]]*\[/) {
    inject("RoomOrderNodes", roomorder_json)
  } else {
    print $0
  }
}
' "$YYP_FILE" > "$TEMP_FILE"

# -----------------------------------------------------------------------------
# Validate: basic sanity check on the output before committing to it
# -----------------------------------------------------------------------------

if [ ! -s "$TEMP_FILE" ]; then
  rm -f "$TEMP_FILE"
  err "Output file is empty — something went wrong. Original .yyp is untouched."
fi

# Count braces to catch catastrophic mangling
OPEN_BRACES=$(grep -o '{' "$TEMP_FILE" | wc -l)
CLOSE_BRACES=$(grep -o '}' "$TEMP_FILE" | wc -l)

if [ "$OPEN_BRACES" -ne "$CLOSE_BRACES" ]; then
  rm -f "$TEMP_FILE"
  err "Brace mismatch in output ({: $OPEN_BRACES, }: $CLOSE_BRACES) — refusing to overwrite. Original .yyp is untouched."
fi

# -----------------------------------------------------------------------------
# Write output and clean up
# -----------------------------------------------------------------------------

mv "$TEMP_FILE" "$YYP_FILE"
rm -f "$BACKUP_FILE"

log "Done."
log "  Resources rebuilt : $RESOURCE_COUNT"
log "  Included files    : $INCLUDEDFILE_COUNT"
log "  Room order nodes  : $ROOM_COUNT"