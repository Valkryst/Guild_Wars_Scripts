Start-Process "uMod/uMod.exe" -NoNewWindow -WorkingDirectory "uMod"
Start-Process "Gw.exe" -NoNewWindow -Wait -ArgumentList ("-bmp", "-dsound")