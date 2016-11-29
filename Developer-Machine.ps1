# Boxstarter options
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

# Basic setup
Update-ExecutionPolicy Unrestricted
Set-ExplorerOptions -showHidenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
Enable-RemoteDesktop
Disable-InternetExplorerESC
#Disable-UAC
#Set-TaskbarSmall
 
# disable defrag because I have an SSD 
Get-ScheduledTask -TaskName *defrag* | Disable-ScheduledTask 

# Install Visual Studio 2015
cinst visualstudio2015enterprise
if (Test-PendingReboot) { Invoke-Reboot }

#Other dev tools
cinst visualstudiocode -y
cinst nodejs.install -y
#choco install unity -y

#Browsers
cinst googlechrome -y
cinst firefox -y

#Other tools
cinst notepadplusplus -y
cinst 7zip.install -y
cinst adobereader -y
cinst skype -y
#cinst dropbox -y
cinst virtualbox -y
choco install jdk8 -y
cinst putty.install -y
#cinst spotify -y
cinst vlc -y
choco install git.install

# VS extensions -- These do not seem to work
#Install-ChocolateyVsixPackage ProPowerTools https://visualstudiogallery.msdn.microsoft.com/d0d33361-18e2-46c0-8ff2-4adea1e34fef/file/29666/12/ProPowerTools.vsix
#Install-ChocolateyVsixPackage vstu2015 https://visualstudiogallery.msdn.microsoft.com/8d26236e-4a64-4d64-8486-7df95156aba9/file/142077/10/vstu2015.msi

# Node modules (Global)
npm install --global --production windows-build-tools
npm install -g node-gyp
npm install -g gulp
npm install -g bower
npm install -g typings
npm install -g hexo-cli
npm install -g angular-cli
npm install -g typescript
npm install -g npm-check-updates

# Misc
choco install windows-sdk-8.1

if (Test-PendingReboot) { Invoke-Reboot }

#cinst Microsoft-Hyper-V-All -source windowsFeatures
cinst IIS-WebServerRole -source windowsfeatures
cinst IIS-HttpCompressionDynamic -source windowsfeatures
cinst IIS-ManagementScriptingTools -source windowsfeatures
cinst IIS-WindowsAuthentication -source windowsfeatures

Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Google\Chrome\Application\chrome.exe"
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"

# Update Windows and reboot if necessary
Install-WindowsUpdate -AcceptEula -GetUpdatesFromMS
if (Test-PendingReboot) { Invoke-Reboot }
