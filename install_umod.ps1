
$path_exe = Join-Path $PSScriptRoot "Gw.exe"

# Generate uMod_DI_Games
$path_exe | Out-File -FilePath Join-Path $PSScriptRoot "uMod/uMod_DI_Games.txt"

# Generate uMod_Settings
"Lang:English" | Out-File -FilePath Join-Path $PSScriptRoot "uMod/uMod_Settings.txt"
"x_size:512" | Out-File -FilePath -Append Join-Path $PSScriptRoot "uMod/uMod_Settings.txt"
"y_size:512" | Out-File -FilePath -Append Join-Path $PSScriptRoot "uMod/uMod_Settings.txt"
"x_pos:512" | Out-File -FilePath -Append Join-Path $PSScriptRoot "uMod/uMod_Settings.txt"
"y_pos:512" | Out-File -FilePath -Append Join-Path $PSScriptRoot "uMod/uMod_Settings.txt"
"UseHook:1" | Out-File -FilePath -Append Join-Path $PSScriptRoot "uMod/uMod_Settings.txt"
pause