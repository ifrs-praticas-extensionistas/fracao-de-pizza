// Singleton
if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit;
}

persistent = true;

global.master_volume = 1;
global.music_volume = 1;
global.sfx_volume = 1;

scr_audio_load();
scr_audio_apply();