@echo off
title Centre de controle PC 
color 

:menu 
cls
echo ===============================
echo         Centre de controle
echo ===============================
echo.
echo 1 - Nettoyage disque
echo 2 - Verification system
echo 3 - Infos PC
echo 4 - Outils Windows
echo 5 - Test de connnexion internet
echo 6 - Monitor de ressources
echo 7 - Test de vitesse du disque
echo 8 - Infos réseau
echo 9 - Scanner les ports ouvert
echo 10 - Monitoring
echo 11 - Quitter
echo.

set /p choix="choix :"
if "%choix%"=="1" goto nettoyage
if "%choix%"=="2" goto verification
if "%choix%"=="3" goto Infos
if "%choix%"=="4" goto Outils
if "%choix%"=="5" goto TestConnexion
if "%choix%"=="6" goto Monitor
if "%choix%"=="7" goto TestVitesse
if "%choix%"=="8" goto InfosReseau
if "%choix%"=="9" goto ScannerPorts
if "%choix%"=="10" goto Monitoring
if "%choix%"=="11" goto Quitter
echo Choix invalide. appuier sur une touche pour recommencer.
pause >nul
goto menu

:nettoyage 
cls
echo Lancement du nettoyage de disque......
cleanmgr
pause
goto menu

:verification 
cls 
echo Verification dy system en cours.......
sfc /scannow
pause
goto menu

:Infos
cls
echo Informations sur le PC : 
echo.
echo Récuperation des infos terminer !
systeminfo
pause
goto menu

:Outils
cls
echo Outils Windows disponnible:
echo 1 - gestionnaire des taches
echo 2 - Invite de commande
echo 3 - Explorateur de fichiers
set /p tools="choisissez un outil : "
if "%tools%"=="1" start taskmgr
if "%tools%"=="2" start cmd
if "%tools%"=="3" start explorer
pause
goto menu

:TestConnexion
cls
echo Test de connexion internet en cours.......
ping www.google.com -n 4
pause
goto menu

:Monitor
cls
echo Lancement du monitor de ressources.......
resmon
pause
goto menu

:TestVitesse
cls
echo Test de vitesse du disque en cours.......
winsat disk
pause
goto menu

:InfosReseau
cls
echo Informations réseau :
ipconfig /all
pause
goto menu

:ScannerPorts
cls
echo Scanner les ports ouverts en cours.......
netstat -an
pause
goto menu

:monitoring
cls
echo Outils de monitoring:
echo 1 - Monitor CPU and RAM
echo 2 - Monitor RAM détaillé
echo 3 - Monitor des processus lourds
echo 4 - Monitor réseau en direct
echo 5 - Monitor espace disque
echo 6 - Monitor température
echo 7 - Monitor complet
set /p monitoring="choisissez un outil de monitoring : "
if "%monitoring%"=="1" goto MonitorCPURAM
if "%monitoring%"=="2" goto MonitorRAM
if "%monitoring%"=="3" goto MonitorProcessus
if "%monitoring%"=="4" goto MonitorReseau
if "%monitoring%"=="5" goto MonitorDisque
if "%monitoring%"=="6" goto MonitorTemperature
if "%monitoring%"=="7" goto MonitorComplet
goto menu

:MonitorCPURAM
cls
echo ======== MONITORING SYSTEME ========
wmic cpu get loadpercentage
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
pause
goto monitoring

:MonitorRAM
cls
echo ======== ETAT MEMOIRE ========
systemifo || find "Mémoire"
pause
goto monitoring

:MonitorProcessus
cls
echo ========PROCESSUS UTILISANT LE PLUS DE RAM========
tasklist /FI "statuts eq running" /FO 
table
pause
goto monitoring

:monitorReseau
cls
echo ========MONITORING RESEAU EN DIRECT========
netsats -e
timeout /t 
pause exit 3 >nul
goto loop
goto monitoring

:MonitorDisque
cls
echo ========ETAT ESPACE DISQUE========
wmic logicaldisk get size,freespace,caption
pause
goto monitoring

:MonitorTemperature
cls
echo ========TEMPERATURE DU SYSTEME========
echo Note : La température est affiché en dixième de degrés Kelvin. Pour convertir en degrés Celsius, utilisez la formule suivante : (Température en dixième de degrés Kelvin - 2731) / 10
echo Exemple : Si la température affichée est 3000, cela correspond à (3000 - 2731) / 10 = 26.9°C
echo Il est possible que la température affichée soit incorrecte ou non disponible en fonction du matériel et des pilotes installés sur votre système.
echo.
wmic /namespace://root/wmi PATH MSAcpi_ThermalZoneTemperature get CurrentTemperature
pause
goto monitoring

:MonitorComplet
cls
echo ========MONITORING COMPLET DU SYSTEME========
echo.

echo ------- CPU -------
wmic cpu get loadpercentage
echo.

echo ------- RAM -------
wmic Os get FreePhysocalMemory
echo.

echo ------- Disque -------
wmic logicaldisk get caption, freespace
echo.

echo ------- Réseau -------
netstat -e
echo.

timeout /t 3 >nul
goto monitoring


:Quitter
echo Merci d'avoir utiliser le Miku controle.
