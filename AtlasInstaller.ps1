#You can Edit this part and change where Atlas is installed:
$AtlasDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$appID = "1006030"
#Nothing to edit past here

#Creating Atlas Folder
Write-Host "Creating Atlas Folder"
New-Item $AtlasDir -type Directory -ErrorAction SilentlyContinue

#Creating Steam Folder and downloading SteamCMD
Write-Host "Downloading SteamCMD"
$url = "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"
New-Item "$AtlasDir\SteamCMD" -type Directory -ErrorAction SilentlyContinue
$output = "$AtlasDir\SteamCMD\steamcmd.zip"
$start_time = Get-Date
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

#Expanding SteamCMD.zip (Open the zip file and extract)
$SteamZip = "$AtlasDir\SteamCMD\steamcmd.zip" #the file name to extract
$SteamDestination = "$AtlasDir\SteamCMD" #the path to extract the file to
Remove-Item $AtlasDir\SteamCMD\steamcmd.exe -ErrorAction SilentlyContinue #Just in case this was alredy run once, I don't want to flood the user with text
Add-Type -assembly "system.io.compression.filesystem" #Required class to unzip the file
[io.compression.zipfile]::ExtractToDirectory($SteamZip, $SteamDestination) #unzip the file

#Installing Atlas Server
Write-Host "Installing Atlas. This will take a WHILE..." -ForegroundColor Yellow
powershell.exe "$AtlasDir\SteamCMD\steamcmd.exe" +login anonymous +force_install_dir $AtlasDir +app_update $appID validate +exit

#Open the Atlas Server Directory.
explorer $AtlasDir