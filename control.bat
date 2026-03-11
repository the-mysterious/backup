@echo off
echo Execution en tant que administrateur...

:: Vérifier s'il s'agit d'une élévation avec privilèges déjà enregistrés
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: Si l'erreur de cacls est 0 (pas d'erreur), alors nous avons déjà les privilèges administratifs.
if '%errorlevel%' == '0' goto :continue

:: Sinon, exécuter en tant qu'administrateur
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B

:continue
echo Execution en tant que administrateur reussie.

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
echo 11 - Recherche de dossier
echo 12 - Quitter
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
if "%choix%"=="11" goto RechercheDossier
if "%choix%"=="12" goto Quitter
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
echo 8 - Retour
set /p monitoring="choisissez un outil de monitoring : "
if "%monitoring%"=="1" goto MonitorCPURAM
if "%monitoring%"=="2" goto MonitorRAM
if "%monitoring%"=="3" goto MonitorProcessus
if "%monitoring%"=="4" goto MonitorReseau
if "%monitoring%"=="5" goto MonitorDisque
if "%monitoring%"=="6" goto MonitorTemperature
if "%monitoring%"=="7" goto MonitorComplet
if "%monitoring%"=="8" goto Retour

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
systeminfo | find "Memoire"
pause
goto monitoring

:MonitorProcessus
cls
echo ========PROCESSUS UTILISANT LE PLUS DE RAM========
tasklist /FI "STATUSeq running" /FO 
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
echo Note : La temperature est affiche en dixieme de degres Kelvin. Pour convertir en degres Celsius, utilisez la formule suivante : (Température en dixieme de degres Kelvin - 2731) / 10
echo Exemple : Si la temperature affichee est 3000, cela correspond a (3000 - 2731) / 10 = 26.9°C
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

:menu
cls
echo Exit du Monitoring
echo Merci d'avoir utiliser le Miku controle.
exit

:RechercheDossier
cls 
title Recherche de dossier
color 0A
:menu 
cls
echo ===============================
echo         Recherche de dossier
echo ===============================
echo 1 - Rechercher un dossier par nom
echo 2 - Rechercher un dossier 
echo 3 - Recherche par extension
echo 4 - Recherche les plus gros fichiers
echo 5 - quitter
echo 
 =============================== ===============================
 set /p choixD="choixD :"
if "%choixD%"=="1" goto Fichier
if "%choixD%"=="2" goto Dossier
if "%choixD%"=="3" goto Extension
if "%choixD%"=="4" goto Gros
if "%choixD%"=="5" goto exit
goto menu


:fichier
cls
echo ========== Recherche de fichier ==========
set /p nom=Nom du fichier :
echo.
echo recherche de dossier en cours....
for /r C:\ %%a in (*%nom%*) do echo %%a
echo.
pause
goto menu

:dossier
cls
echo ========== Recherche de dossier ==========
set /p nom=Nom du doissier :
echo.
echo recherche de dossier en cours....
dir C:\*%nom%* /add /s /b 2>nul
echo.
pause
goto menu

:extension
cls
echo ========== Recherche par extension ==========
set /p ext=Extension du fichier (ex: .txt, .pdf etc...) :
echo.
echo recherche de dossier en cours....
dir C:\*.%ext% /add /s /b 2>nul
echo.
pause
goto menu

:Gros
cls
echo ========== Recherche des plus gros fichiers ==========
set /p tailler=Afficher les fichier de plus de (en Mo) : 
echo.
echo recherche de dossier en cours....
powershell -NoProfile -Command "Get-ChildItem C:\ -Rescure -ErrorAcction SilentlyContinue | Where-Object { -not $_.PSIsContainer -and $_.Length -gt (%taille%MB) } | Select-Object FullName,@{Name='Size(Mb)'; Expression={[math]::Round($_.Length / 1MB, 2)}} | Format-Table -AutoSize"
echo.
pause
goto menu


:Quitter
echo Merci d'avoir utiliser le Miku controle.
