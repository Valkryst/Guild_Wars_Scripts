#requires -Version 5.0
# Download uMod
$file_sha = 'uMod.sha256'
$file_zip = 'uMod.zip'

Invoke-WebRequest -Uri 'https://github.com/Valkryst/Guild_Wars_Scripts/raw/main/files/uMod.sha256' -OutFile $file_sha
Invoke-WebRequest -Uri 'https://github.com/Valkryst/Guild_Wars_Scripts/raw/main/files/uMod.zip' -OutFile $file_zip

$hash_computed = (Get-FileHash -Algorithm SHA256 -Path $file_zip).Hash
$hash_existing = Get-Content -Path $file_sha

if ($hash_computed -ne $hash_existing) {
  Remove-Item -Path $file_sha
  Remove-Item -Path $file_zip

  Write-Error -Message 'The checksum of the downloaded uMod.zip is incorrect. The file may be corrupt.'
  Write-Error -Message 'This might be resolved by re-running this script.'
  $host.EnterNestedPrompt()
  return
}


# Extract uMod Archive
Expand-Archive -Path $file_zip -DestinationPath $PSScriptRoot
Remove-Item -Path $file_sha
Remove-Item -Path $file_zip



# Generate uMod_DI_Games
$path = Join-Path -Path $PSScriptRoot -ChildPath 'uMod/uMod_DI_Games.txt'
Join-Path -Path $PSScriptRoot -ChildPath 'Gw.exe' | Out-File -FilePath $path



# Generate uMod_Settings
$path = Join-Path -Path $PSScriptRoot -ChildPath 'uMod/uMod_Settings.txt'
'Lang:English' | Out-File -FilePath $path
'x_size:512' | Out-File -Append -FilePath $path
'y_size:512' | Out-File -Append -FilePath $path
'x_pos:512' | Out-File -Append -FilePath $path
'y_pos:512' | Out-File -Append -FilePath $path
'UseHook:1' | Out-File -Append -FilePath $path



# Update Default Template
$path = Join-Path -Path $PSScriptRoot -ChildPath 'uMod/templates/uMod.txt'
(Get-Content $path).Replace('D:/Games/Guild Wars', $PSScriptRoot) | Set-Content $path