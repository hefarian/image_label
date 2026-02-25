# Auteur : Gregory CRESPIN
# Projet : Labellisez et appliquez des approches semi-supervisees en traitement d'images (BrainScanAI)
# Date : 08/02/2026
# Image Python avec PyTorch et Jupyter pour les notebooks
FROM python:3.11-slim

WORKDIR /app

# Dépendances système éventuelles (pour opencv, etc.)
# libgl1 remplace libgl1-mesa-glx sur Debian Bookworm+
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Fichiers minimaux (le reste est monté en volume via docker-compose)
COPY config.py .

# Jupyter écoute sur toutes les interfaces pour accès depuis l'hôte
ENV JUPYTER_ENABLE_LAB=yes
EXPOSE 8888

# Par défaut : Jupyter Lab (token dans les logs)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
