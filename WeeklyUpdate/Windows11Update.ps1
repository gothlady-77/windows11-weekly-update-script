# script checks for Windows updates and installs them automatically.

Import-Module PSWindowsUpdate

Write-Host "Checking for updates..."
# installs available updates, reboots the system  if needed.
Get-WindowsUpdate -AcceptAll -Install -AutoReboot