@echo off
title Centre de controle PC 
color 0b

:menu 
cls
echo ===============================
echo         Cestre de controle
echo ===============================
echo.
echo 1 - NEttoyage disque
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

