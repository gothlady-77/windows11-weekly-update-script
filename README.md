# Windows 11 Weekly Update Script

An easy way to automate Windows updates on your Windows PC, laptop, or server.

## Purpose

This is my introduction to creating and using Powershell scripts.<br>
I personally dislike having to do routine update checks, so I thought having my computer do it for me would be cool. :)<br>
This repo contains two Powershell scripts. The first sets up the environment needed for the second script. The second script is called by the first and it actually runs the weekly updates.

## Use

First and foremost, clone this repository by running:<br>
**git clone <https://github.com/ladyluna-77/windows11-weekly-update-script.git>**

Secondly, open a Powershell terminal as administrator. You cannot run updates as a non-admin, so make sure you're running as an admin or else the script will not execute.

Next, navigate to the "WeeklyUpdate" directory within the cloned repo.

After you're inside WeeklyUpdate, run the Setup-Windows11Update.ps1 script. This can be done by running:<br>
**.\Setup-Windows11Update.ps1**

After the setup script is run, your Windows machine will now automatically install updates every Sunday morning at 3am!

*Disclaimer, the update script that runs weekly at 3am also restarts the system as needed. Make sure to save whatever documents are open before updates are ran.*

Once the setup script has been run, it cannot be run again before terminating the current weekly update task.

### Using the Windows11Update.ps1 script itself

Although not necessarily intended, users can use the Windows11Update.ps1 script itself to run a one-time update check.<br>
The usage is the same as running the setup script: open an admin Powershell terminal, navigate to the WeeklyUpdate directory, and run:<br>
**.\Windows11Update.ps1**
