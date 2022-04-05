#requires -Version 2.0
Start-Process -FilePath 'uMod/uMod.exe' -NoNewWindow -WorkingDirectory 'uMod'
Start-Process -FilePath 'Gw.exe' -NoNewWindow -Wait -ArgumentList ('-bmp', '-dsound')