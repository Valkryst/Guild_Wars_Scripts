## Requirements

To use this script, you must have Guild Wars and [PowerShell](https://github.com/PowerShell/PowerShell/releases) and  installed.

## Usage

[Download](https://www.wikihow.com/Download-a-File-from-GitHub) one of the the PowerShell scripts, place it in your Guild Wars directory alongside `Gw.exe`, and then run it either by double-clicking the file or by right-clicking and selecting "Run with PowerShell".

## Script Descriptions

### launch

Launches Guild Wars with the [-bmp](https://wiki.guildwars.com/wiki/Command_line_arguments#-bmp) and [-dsound](https://wiki.guildwars.com/wiki/Command_line_arguments#-dsound) command line arguments.

### launch_debug

Primarily for debugging ALSOFT and DSOAL, for users who have enabled [3D positional audio & EAX effects](https://old.reddit.com/r/GuildWars/comments/nj6b30/announcing_dsoalgw1_3d_positional_audio_and_eax/).

1. Adds temporary environment variables. They're required for ALSOFT & DSOAL to output debugging logfiles.
2. Deletes existing ALSOFT & DSOAL logfiles.
3. Launches Guild Wars with the [-bmp](https://wiki.guildwars.com/wiki/Command_line_arguments#-bmp), [-dsound](https://wiki.guildwars.com/wiki/Command_line_arguments#-dsound) and [-perf](https://wiki.guildwars.com/wiki/Command_line_arguments#-perf) command line arguments.
4. Deletes temporary environment variables.

Logfiles are saved in the Guild Wars directory.


### update

Launches Guild Wars with the [-image](https://wiki.guildwars.com/wiki/Command_line_arguments#-image) command line argument. This forces the game to download all known updates.