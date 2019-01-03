
## Installing using PowerShell and SteamCMD
There's a PowerShell script that installs SteamCMD and the ATLAS Dedicated Server: https://github.com/dimitrydeclercq/atlas-server/blob/master/AtlasInstaller.ps1

Create a directory on your server (e.g. ATLAS Server) copy and run the script inside that directory

Script courtesy of @Deathfather on the Atlas Server Help Discord

## Creating a ServerGrid
This wiki focusses on running a server, not designing the world. See https://github.com/GrapeshotGames/ServerGridEditor/wiki

Some tips:
> You can CTRL left click to bring up the Edit Server dialog
> You can CTRL right click to bring up the another dialog allowing you to add buildings (and stuff?) to your island

However, some technical aspects must be configured in the ServerGrid.
Make sure to use the `export` function of the ServerGridEditor:
- Enable `Show Server Info` and verify that IP, Port, GamePort is as expected (the SeamlessDataPort doesn't show up, you'll need to manually CTRL left click each cell)
- Enable `Show Ship Paths` and verify that there are no ship paths outside of your map
- Enable `Export PNGS`
- Export -> Local Export (doesn't matter which directory you pick, it will always go to the `Export` directory)
- Export -> Cell Images -> select the ServerGrid directory inside the Export directory -> make sure to save it as `CellImg.jpg` else it will use png and your map will not show up. THIS CAN TAKE A WHILE TO COMPLETE

### Configuring ServerGrid.json
- IP for the servers should be your public IP
- Make sure to use different ports for each server if you use the same IP

### Ports
Use a sane port convention, e.g. start at 5760/57560/27000 and up the port by 1 for each server.

> ProTip: if you're not going beyond a 10x10 grid, consider using a port convention based on XY coordinated: 57XY/575XY/270XY, this makes it easier to remember which server has which ports.

Firewall:
- The `gamePort` (e.g. 5760) and `queryPort` (e.g. 57560) are UDP and should be opened to the world.
- The `seamlessDataPort` (e.g. 27000) is TCP and should be opened to the world.
- The port for Redis (`Port` in de` ServerGrid.ServerOnly.json` under `DatabaseConnections`, e.g. 6379) is TCP and  should only be opened internally between the REDIS server and ATLAS servers (so never to the world).

## Starting the server
Make sure to start the REDIS server first: `<ATLAS Server>\AtlasTools\RedisDatabase\redis-server_start.bat`

In `<ATLAS Server>/ShooterGame/Binaries/Win64` start the ATLAS Dedicated Server:
`ShooterGameServer.exe Ocean?ServerX=0?ServerY=0?AltSaveDirectoryName=A1?QueryPort=57560?Port=5760?SeamlessIP=x.x.x.x?MaxPlayers=20?ReservedPlayerSlots=5 -log -server -NoBattlEye`

Make sure to change `ServerX`, `ServerY`, `AltSaveDirectoryName`, `Port`, `QueryPort` and `SeamlessIP` to match your settings, this should also match whatever you configured in ServerGrid.json

> ProTip: If you followed the XY ports, you can script it: `ShooterGameServer.exe Ocean?ServerX=$X?ServerY=$Y?AltSaveDirectoryName=$X$Y?QueryPort=575$X$Y?Port=57$X$Y...

Disclaimer: I'm a linux guy, probably there's some typo's

# Resources
https://www.drac346.net/2018/12/atlas-dedicated-server-using-steamcmd.html
