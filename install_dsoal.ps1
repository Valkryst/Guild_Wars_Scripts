# Download DSOAL
$file_sha = "dsoal.sha256"
$file_zip = "dsoal.zip"

#Invoke-WebRequest "https://github.com/Valkryst/Guild_Wars_Scripts/raw/main/files/dsoal.sha256" -OutFile $file_sha
#Invoke-WebRequest "https://github.com/Valkryst/Guild_Wars_Scripts/raw/main/files/dsoal.zip" -OutFile $file_zip
Invoke-WebRequest "https://public.valkryst.com/dsoal.sha256" -OutFile $file_sha
Invoke-WebRequest "https://public.valkryst.com/dsoal.zip" -OutFile $file_zip

$hash_computed = (Get-FileHash -Algorithm SHA256 -Path $file_zip).Hash
$hash_existing = Get-Content -Path $file_sha

if ($hash_computed -ne $hash_existing) {
    Remove-Item -Path $file_sha
	Remove-Item -Path $file_zip

	Write-Error "The checksum of the downloaded dsoal.zip is incorrect. The file may be corrupt."
	Write-Error "This might be resolved by re-running this script."
	$host.EnterNestedPrompt()
	return
}


# Extract DSOAL Archive
Expand-Archive -Path $file_zip -DestinationPath (Join-Path $PSScriptRoot "dsoal")
Remove-Item -Path $file_sha
Remove-Item -Path $file_zip



# Extract HRTF Archive
Expand-Archive -Path (Join-Path $PSScriptRoot "dsoal/HRTF_OAL_1.19.0.zip") -DestinationPath (Join-Path $PSScriptRoot "dsoal")



# Move Files into Guild Wars Folder
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path $PSScriptRoot "dsoal/alsoft.ini") -Destination $PSScriptRoot
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path $PSScriptRoot "dsoal/dsoal-aldrv.dll") -Destination $PSScriptRoot
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path $PSScriptRoot "dsoal/dsound.dll") -Destination $PSScriptRoot



# Move Files into OpenAL Roaming Folder
$directory = Join-Path $env:APPDATA "openal"
if (-not (Test-Path $directory -IsValid)) {
    New-Item $directory -ItemType Directory
}

Move-Item -ErrorAction SilentlyContinue -Path (Join-Path $PSScriptRoot "dsoal/presets") -Destination $directory
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path $PSScriptRoot "dsoal/hrtf_defs") -Destination $directory

Rename-Item -Path (Join-Path $PSScriptRoot "dsoal/HRTF") -NewName "hrtf_tmp"
Rename-Item -Path (Join-Path $PSScriptRoot "dsoal/hrtf_tmp") -NewName "hrtf"
Move-Item -ErrorAction SilentlyContinue -Path (Join-Path $PSScriptRoot "dsoal/hrtf") -Destination $directory



# Update Registry
Start-Process reg -NoNewWindow -Wait -ArgumentList ("import", (Join-Path $PSScriptRoot "dsoal/dsoal.reg"))



# Delete Leftover Files
Remove-Item -Path (Join-Path $PSScriptRoot "dsoal") -Recurse