#requires -Version 5.0
# Download DSOAL
$file_sha = 'dsoal.sha256'
$file_zip = 'dsoal.zip'

Invoke-WebRequest -Uri 'https://github.com/Valkryst/Guild_Wars_Scripts/raw/main/files/dsoal.sha256' -OutFile $file_sha
Invoke-WebRequest -Uri 'https://github.com/Valkryst/Guild_Wars_Scripts/raw/main/files/dsoal.zip' -OutFile $file_zip

$hash_computed = (Get-FileHash -Algorithm SHA256 -Path $file_zip).Hash
$hash_existing = Get-Content -Path $file_sha

if ($hash_computed -ne $hash_existing) {
  Remove-Item -Path $file_sha
  Remove-Item -Path $file_zip

  Write-Error -Message 'The checksum of the downloaded dsoal.zip is incorrect. The file may be corrupt.'
  Write-Error -Message 'This might be resolved by re-running this script.'
  $host.EnterNestedPrompt()
  return
}


# Extract DSOAL Archive
Expand-Archive -Path $file_zip -DestinationPath (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal')
Remove-Item -Path $file_sha
Remove-Item -Path $file_zip



# Extract HRTF Archive
Expand-Archive -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/HRTF_OAL_1.19.0.zip') -DestinationPath (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal')



# Move Files into Guild Wars Folder
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/alsoft.ini') -Destination $PSScriptRoot
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/dsoal-aldrv.dll') -Destination $PSScriptRoot
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/dsound.dll') -Destination $PSScriptRoot



# Move Files into OpenAL Roaming Folder
$directory = Join-Path -Path $env:APPDATA -ChildPath 'openal'
if (-not (Test-Path $directory -IsValid)) {New-Item $directory -ItemType Directory}
Pause

Move-Item -ErrorAction SilentlyContinue -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/presets') -Destination $directory
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/hrtf_defs') -Destination $directory

Rename-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/HRTF') -NewName 'hrtf_tmp'
Rename-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/hrtf_tmp') -NewName 'hrtf'
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/hrtf') -Destination $directory



# Update Registry
Start-Process -FilePath reg -NoNewWindow -Wait -ArgumentList ('import', (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal/dsoal.reg'))



# Delete Leftover Files
Remove-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath 'dsoal') -Recurse