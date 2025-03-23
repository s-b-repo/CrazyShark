@echo off
title Crazy Shark&mode 75,30&chcp 65001>nul&cd files

:menu
cls&echo(
echo [36m Crazy Shark [0m discord:https://discord.gg/tQs8Prxy7S
echo [31m┌───────────PUBLIC IP────────────┐  ┌──────────LOCAL IP───────────┐
echo [31m│[36m[1] Geolocate  [2] Trace DNS    [31m│  │[36m[5] Mac Address [7] ARP Spoof[31m│
echo [31m│[36m[3] Port Scan  [4] DDOS        [31m│  │[36m[6] Port Scan   [8] RPC Dump [31m│
echo [31m└────────────────────────────────┘  └───────────────────────────┘
set /p input= Choice: 

if "%input%"=="1" goto geolocate
if "%input%"=="2" goto tracedns
if "%input%"=="3" goto portscan
if "%input%"=="4" goto ddos
if "%input%"=="5" goto Macaddr
if "%input%"=="6" goto portscan
if "%input%"=="7" goto arpspoof
if "%input%"=="8" goto rpcdump

:rpcdump
set /p ip=IP: & rpcdump %ip%&pause&goto menu

:Macaddr
set /p ip=IP: & ping -n 1 %ip%>nul
for /f "tokens=2" %%a in ('arp -a ^| find "%ip%"') do set mac=%%a
powershell "echo %mac%">%temp%.\m&set /p m=<%temp%.\m&echo MAC: %m%&del %temp%.\m&pause&goto menu

:arpspoof
set /p ip=IP: &start cmd /c "mode 87,10&title Spoofing %ip%...&arpspoof.exe %ip%"&goto menu

:ddos
cls&echo 1) https://freestresser.so/&echo 2) https://hardstresser.com/
echo 3) https://stresser.net/&echo 4) https://str3ssed.co/
echo 5) https://projectdeltastress.com/&echo 6) Back
set /p ddosinput=&if not "%ddosinput%"=="6" start https://freestresser.so/&goto menu

:portscan
set /p ip=IP: &set /p ports=Ports: 
start cmd /c "mode 40,15&title Scanning...&PortScanner.exe %ip% %ports%>>ps.txt"
ping -n 5 0>nul&taskkill /im PortScanner.exe /f>nul&type ps.txt&del ps.txt&pause&goto menu

:tracedns
set /p ip=IP: &for /f "tokens=2" %%a in ('nslookup %ip% ^| find "Name"') do set dns=%%a
echo Domain: %dns%&pause&goto menu

:geolocate
set /p ip=IP: &powershell "curl http://ipinfo.io/%ip%/json -UseBasicParsing"|findstr /i "ip hostname org city region country postal loc timezone"
pause&goto menu
