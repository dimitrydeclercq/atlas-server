FROM microsoft/windowsservercore

RUN mkdir ATLAS-SERVER
WORKDIR ATLAS-SERVER

COPY AtlasInstaller.ps1 AtlasInstaller.ps1
RUN powershell.exe AtlasInstaller.ps1

WORKDIR ShooterGame/Binaries/Win64
CMD [ "ShooterGameServer.exe Ocean?ServerX=0?ServerY=0?AltSaveDirectoryName=A1?MaxPlayers=35?ReservedPlayerSlots=10?QueryPort=57560?Port=5760?SeamlessIP=x.x.x.x -log -server -NoBattlEye -culture=en" ]
