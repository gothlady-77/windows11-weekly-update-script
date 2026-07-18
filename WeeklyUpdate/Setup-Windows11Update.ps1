# run one time as admin to create a scheduled task to run the Windows 11 update script weekly on Sunday at 3am

$taskName= "Win 11 Update"

if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
    Write-Host "Scheduled task '$taskName' already exists. Skipping task creation."
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File C:\Users\lunal\Downloads\Scripts\WeeklyUpdate\Windows11Update.ps1"
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 3am
$settings = New-ScheduledTaskSettingsSet -WakeToRun -StartWhenAvailable

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -RunLevel Highest -Settings $settings
Write-Host "Scheduled task '$taskName' created successfully."
