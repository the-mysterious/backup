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
echo 5 - Quitter
echo 6 - Mise à jour
echo.

set /p choix="choix :"
if "%choix%"=="1" goto nettoyage
if "%choix%"=="2" goto verification
if "%choix%"=="3" goto Infos
if "%choix%"=="4" goto Outils
if "%choix%"=="5" goto Quitter
if "%choix%"=="6" goto MAJ
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

:MAJ
cls
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

winget upgrade --all
pause
goto menu

:Quitter
echo Merci d'avoir utiliser le Miku controle.
pause exit