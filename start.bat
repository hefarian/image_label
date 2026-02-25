@echo off
REM Auteur : Gregory CRESPIN
REM Projet : Labellisez et appliquez des approches semi-supervisees en traitement d'images (BrainScanAI)
REM Date : 08/02/2026
REM Lancer l'environnement Docker (Jupyter Lab)

echo Verification de Docker...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERREUR: Docker n'est pas installe ou n'est pas dans le PATH.
    echo Veuillez installer Docker Desktop depuis https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

echo Verification que Docker Desktop est demarre...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERREUR: Docker Desktop n'est pas demarre!
    echo.
    echo Veuillez:
    echo 1. Ouvrir Docker Desktop
    echo 2. Attendre qu'il soit completement demarre (icone Docker dans la barre des taches)
    echo 3. Relancer ce script
    echo.
    pause
    exit /b 1
)

echo Docker est pret!
echo.
echo Construction et demarrage du conteneur...
docker compose up --build
pause
