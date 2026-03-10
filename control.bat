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
echo 10 - Quitter
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

if "%choix%"=="10" goto Quitter
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

:Quitter
echo Merci d'avoir utiliser le Miku controle.
pause exit