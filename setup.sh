#!/usr/bin/env bash

set -e

HOOKS_SOURCE_DIR="./git-hooks"
HOOKS_TARGET_DIR="$(git rev-parse --git-dir)/hooks"

echo "Configurando os git hooks..."

# Garante que a pasta de hooks existe
if [ ! -d "$HOOKS_SOURCE_DIR" ]; then
  echo "Erro: $HOOKS_SOURCE_DIR não existe"
  exit 1
fi

# Cria a pasta de hooks
mkdir -p "$HOOKS_TARGET_DIR"

# Copia os hooks
for hook in "$HOOKS_SOURCE_DIR"/*; do
  hook_name="$(basename "$hook")"

  echo "Configurando hook: $hook_name"

  cp "$hook" "$HOOKS_TARGET_DIR/$hook_name"
  chmod +x "$HOOKS_TARGET_DIR/$hook_name"
done

echo "Hooks configurados com sucesso."