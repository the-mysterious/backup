@echo off
title Centre de controle PC 
color 0b

:menu 
cls
echo ===============================
echo         Cestre de controle
echo ===============================
echo.
echo 1 - Nettoyage disque
echo 2 - Verification system
echo 3 - Infos PC
echo 4 - Outils Windows
echo 5 - Quitter
echo.

set /p choix=choix :
if %choix%==1 goto CLEAN
if %choix%==2 goto CHECK
if %choix%==3 goto INFO
if %choix%==4 goto TOOLS
if %choix%==5 goto EXIT
echo Choix invalide. appuier sur une touche pour recommencer.
pause >nul
goto menu

:nettoyage 
cls
echo Lancement du nettoyage de disque......
cleanmrg
pausegoto menu
:verification 
cls 
escho Verification dy system en cours.......
sfc /scannow
pause
goto menu

:Infos
cls
echo Informations sur le PC : 
systeminfo
pause
goto menu

:Outils
clsecho Outils Windows disponnible:
echo 1 - gestionnaire des taches
echo 2 - Invite de commande
echo 3 - Explorateur de fichiers
set /p tool="choisissez un outil : "
if %tools%=="1" start taskmgr
if %tools%=="2" start comd
if %tools%=="3" start explorer
pause
goto menu

:Quitter
echo Merci d'avoir utiliser le Miku controle.
pause exit