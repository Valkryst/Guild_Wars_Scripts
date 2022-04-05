#requires -Version 3.0
# Temporarily enable ALSOFT logging.
$logfile_path_alsoft = Join-Path -Path $PSScriptRoot -ChildPath 'log_alsoft.txt'
[Environment]::SetEnvironmentVariable('ALSOFT_LOGLEVEL', 3, 'User')
Write-Host -Object "Added ALSOFT_LOGLEVEL = '3', to this user's environment variables."

[Environment]::SetEnvironmentVariable('ALSOFT_LOGFILE', $logfile_path_alsoft, 'User')
Write-Host -Object "Added ALSOFT_LOGFILE = '$logfile_path_alsoft', to this user's environment variables."



# Temporarily enable DSOAL logging.
$logfile_path_dsoal = Join-Path -Path $PSScriptRoot -ChildPath 'log_dsoal.txt'

[Environment]::SetEnvironmentVariable('DSOAL_LOGLEVEL', 2, 'User')
Write-Host -Object "Added DSOAL_LOGLEVEL = '2', to this user's environment variables."

[Environment]::SetEnvironmentVariable('DSOAL_LOGFILE', $logfile_path_dsoal, 'User')
Write-Host -Object "Added DSOAL_LOGFILE = '$logfile_path_dsoal', to this user's environment variables."



# Delete existing logfiles.
if (Test-Path $logfile_path_alsoft) {
  Remove-Item $logfile_path_alsoft
  Write-Host -Object "Deleted $logfile_path_alsoft"
}

if (Test-Path $logfile_path_dsoal) {
  Remove-Item $logfile_path_dsoal
  Write-Host -Object "Deleted $logfile_path_dsoal"
}



# Run Guild Wars
Write-Host -Object 'Launching Guild Wars'
Start-Process -FilePath 'Gw.exe' -NoNewWindow -Wait -ArgumentList ('-bmp', '-dsound', '-perf')



# Disable ALSOFT logging.
[Environment]::SetEnvironmentVariable('ALSOFT_LOGLEVEL', '', 'User')
Write-Host -Object "Removed ALSOFT_LOGLEVEL from this user's environment variables."

[Environment]::SetEnvironmentVariable('ALSOFT_LOGFILE', '', 'User')
Write-Host -Object "Removed ALSOFT_LOGFILE from this user's environment variables."



# Disable DSOAL logging.
[Environment]::SetEnvironmentVariable('DSOAL_LOGLEVEL', '', 'User')
Write-Host -Object "Removed DSOAL_LOGLEVEL from this user's environment variables."

[Environment]::SetEnvironmentVariable('DSOAL_LOGFILE', '', 'User')
Write-Host -Object "Removed DSOAL_LOGFILE from this user's environment variables."