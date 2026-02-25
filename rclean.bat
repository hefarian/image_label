@echo off
REM Auteur : Gregory CRESPIN
REM Projet : Labellisez et appliquez des approches semi-supervisees en traitement d'images (BrainScanAI)
REM Date : 08/02/2026
REM Arrete Docker, vide les caches, puis relance

echo Arret des conteneurs...
docker compose down

echo.
echo Vidage du cache de build Docker...
docker builder prune -f

echo.
echo Relance avec reconstruction (sans cache)...
docker compose up --build

pause