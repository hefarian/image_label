@echo off
REM Auteur : Gregory CRESPIN
REM Projet : Labellisez et appliquez des approches semi-supervisees en traitement d'images (BrainScanAI)
REM Date : 08/02/2026
REM Redemarrer le conteneur Docker
echo Arret du conteneur...
docker compose down
echo Redémarrage...
docker compose up
pause
