:: Install GRR on next boot.

::powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('%GRR_EXEURL%', 'C:\Windows\System32\grr_install.exe')"
powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('https://googledrive.com/host/0B1wsLqFoT7i2fjI5TjYtUGZuVTBCTVNYWGpsNjZnc0tQLWROWW91WHlaaWV2YVprN2NOSEE/GRR_3.0.0.7_amd64.exe', 'C:\Windows\System32\grr_install.exe')"

:: Add fastpoll settings.
REG ADD HKEY_LOCAL_MACHINE\Software\GRR /f /v Client.poll_max /t REG_SZ /d "5"
REG ADD HKEY_LOCAL_MACHINE\Software\GRR /f /v Client.foreman_check_frequency /t REG_SZ /d "20"

C:\Windows\System32\grr_install.exe

:: This is only necessary when building an image with packer. Replace the
:: install step above with this when packer can provision a GCE windows machine.
:: REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce /f /v grr_install /t REG_SZ /d "C:\Windows\System32\grr_install.exe"

:: Set up artifacts to use in the workshop

mkdir C:\Temp
copy /Y C:\Windows\System32\a*.dll C:\Temp\
echo malware >> C:\Temp\authz.dll

mkdir %HOMEPATH%\Downloads

REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /f /v nwiz_auth /t REG_SZ /d "rundll32.exe C:\Temp\authz.dll"

REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /f /v keepinitreal /t REG_SZ /d "echo most windows machines aren't this boring"

powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('https://googledrive.com/host/0B1wsLqFoT7i2fjI5TjYtUGZuVTBCTVNYWGpsNjZnc0tQLWROWW91WHlaaWV2YVprN2NOSEE/TA_Toolkit_Implementation_Plan_Template.doc', '%HOMEPATH%\Downloads\TA_Toolkit_Implementation_Plan_Template.doc')"
powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('https://googledrive.com/host/0B1wsLqFoT7i2fjI5TjYtUGZuVTBCTVNYWGpsNjZnc0tQLWROWW91WHlaaWV2YVprN2NOSEE/Multi_PIs_NSF.doc', '%HOMEPATH%\Downloads\Multi_PIs_NSF.doc')"
powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('https://googledrive.com/host/0B1wsLqFoT7i2fjI5TjYtUGZuVTBCTVNYWGpsNjZnc0tQLWROWW91WHlaaWV2YVprN2NOSEE/lpc_sapp.doc', '%HOMEPATH%\Downloads\lpc_sapp.doc')"
powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('https://googledrive.com/host/0B1wsLqFoT7i2fjI5TjYtUGZuVTBCTVNYWGpsNjZnc0tQLWROWW91WHlaaWV2YVprN2NOSEE/ctabrfbr.doc', '%HOMEPATH%\Downloads\ctabrfbr.doc')"

powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('https://download.sysinternals.com/files/PSTools.zip', '%TEMP%\admin.zip')"

net user msilenus poet81AA@@ /ADD
net user brawne detect81AA@@ /ADD
