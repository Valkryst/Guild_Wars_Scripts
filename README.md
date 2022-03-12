## Requirements

To use these scripts, you must have Guild Wars and [PowerShell](https://github.com/PowerShell/PowerShell/releases) and  installed.

## Usage

[Download](https://www.wikihow.com/Download-a-File-from-GitHub) one of the the PowerShell scripts, place it in your Guild Wars directory alongside `Gw.exe`, and then run it either by double-clicking the file or by right-clicking and selecting "Run with PowerShell".

## Script Descriptions

### install_dsoal

Downloads and partially configures [DSOAL](https://github.com/ChthonVII/dsoal-GW1), following [these steps](https://old.reddit.com/r/GuildWars/comments/nj6b30/announcing_dsoalgw1_3d_positional_audio_and_eax/).

After running the script, you will need to follow certain sections of [this guide](https://old.reddit.com/r/GuildWars/comments/nj6b30/announcing_dsoalgw1_3d_positional_audio_and_eax/) to configure and test the installation. You can use `launch_debug.ps1` for testing.

1. Follow the steps under "Make the following edits to alsoft.ini".
2. Follow the steps under either "Ambisonic Setup" or "HRTF Setup", depending on your situation.
3. Follow the steps under "Troubleshooting". If using `launch_debug.ps1`, you don't need to manually set the environment variables. Just run the script and read through the `log_alsoft.txt` and `log_dsoal.txt` files after launching Guild Wars and enabling EAX.

This _will_ overwrite your existing DSOAL setup, so make sure to back up any files you deem necessary. e.g. Files in `%APPDATA%/openal/presets` and `alsoft.ini` from your Guild Wars directory.

### install_umod

Downloads and configures [this copy](https://github.com/Valkryst/Guild_Wars_Scripts/blob/main/files/uMod.zip) of uMod from the _files_ directory in this repository. The following mods come pre-installed:

* [All the High Resolution Skills](https://wiki.guildwars.com/wiki/Player-made_Modifications/Skills_Index#All_the_High_Resolution_Skills)
* [All High Resolution Dervish Skills [2021]](https://wiki.guildwars.com/wiki/Player-made_Modifications/Skills_Index#All_High_Resolution_Dervish_Skills_.5B2021.5D)
* [All High Resolution PvE Skills [2021]](https://wiki.guildwars.com/wiki/Player-made_Modifications/Skills_Index#All_High_Resolution_PvE_Skills_.5B2021.5D)

To use uMod, you must launch the game with [launch_umod.ps1](https://github.com/Valkryst/Guild_Wars_Scripts/blob/main/launch_umod.ps1).

### launch

Launches Guild Wars with the [-bmp](https://wiki.guildwars.com/wiki/Command_line_arguments#-bmp) and [-dsound](https://wiki.guildwars.com/wiki/Command_line_arguments#-dsound) command line arguments.

### launch_debug

Primarily for debugging ALSOFT and DSOAL, for users who have enabled [3D positional audio & EAX effects](https://old.reddit.com/r/GuildWars/comments/nj6b30/announcing_dsoalgw1_3d_positional_audio_and_eax/).

1. Adds temporary environment variables. They're required for ALSOFT & DSOAL to output debugging logfiles.
2. Deletes existing ALSOFT & DSOAL logfiles.
3. Launches Guild Wars with the [-bmp](https://wiki.guildwars.com/wiki/Command_line_arguments#-bmp), [-dsound](https://wiki.guildwars.com/wiki/Command_line_arguments#-dsound) and [-perf](https://wiki.guildwars.com/wiki/Command_line_arguments#-perf) command line arguments.
4. Deletes temporary environment variables.

Logfiles are saved in the Guild Wars directory.

### launch_umod

Launches uMod and then launches Guild Wars with the [-bmp](https://wiki.guildwars.com/wiki/Command_line_arguments#-bmp) and [-dsound](https://wiki.guildwars.com/wiki/Command_line_arguments#-dsound) command line arguments.

This assumes that the uMod directory is located within the Guild Ward directory. e.g.

* Guild Wars
    * Gw.exe
    * uMod
        * uMod.exe

When you launch uMod with Guild Wars, for the first time, you may need to perform the following actions to ensure all mods are being loaded.

1. Click `Main` in uMod's toolbar.
2. Click `Load Template ...`.
3. Load the `uMod` template.
4. Close uMod and Guild Wars, then re-run `launch_umod.ps1`.

### update

Launches Guild Wars with the [-image](https://wiki.guildwars.com/wiki/Command_line_arguments#-image) command line argument. This forces the game to download all known updates.
