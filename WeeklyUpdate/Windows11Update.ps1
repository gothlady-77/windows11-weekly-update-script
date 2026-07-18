# script checks for Windows updates and installs them automatically.

if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module -Name PSWindowsUpdate -Force -AllowClobber -Scope CurrentUser
}
Import-Module PSWindowsUpdate

Write-Host "Checking for updates..."
Get-WindowsUpdate -AcceptAll -Install -AutoReboot