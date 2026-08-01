# run one time as admin to create a scheduled task to run the Windows 11 update script weekly on Sunday at 3am

$taskName= "Win 11 Update"

# PSSCriptRoot is the directory where this script is located. No need for path editing.
$updatePath = Join-Path $PSScriptRoot "Windows11Update.ps1"

# ensures the Windows11Update.ps1 script is in the same folder as this script
if (-not (Test-Path $updatePath)) {
    Write-Host "Could not find Windows11Update.ps1 script. Ensure both files are in the same folder." -ForegroundColor DarkRed
    exit 1
}

# checks if the scheduled task already exists. If it does, it unregisters the existing task before creating a new one.
if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
    Write-Host "Scheduled task '$taskName' already exists. Skipping task creation."
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$updatePath`""
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 3am
$settings = New-ScheduledTaskSettingsSet -WakeToRun -StartWhenAvailable
# SYSTEM runs regardless of whether a user is logged in or not, and has the highest privileges.
$principal = New-ScheduledTaskPrincipal -UserIf "SYSTEM" -RunLevel Highest -LogonType ServiceAccount

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -RunLevel Highest -Settings $settings -Principal $principal
Write-Host "Scheduled task '$taskName' created successfully." -ForegroundColor Green

# installs PSWindowsUpdate machine-wide if not already installed
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Install-Module -Name PSWindowsUpdate -Force -AllowClobber -Scope AllUsers
    Write-Host "PSWindowsUpdate module installed for all userssuccessfully." -ForegroundColor Green
}