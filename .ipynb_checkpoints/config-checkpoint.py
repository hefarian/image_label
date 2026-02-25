# -*- coding: utf-8 -*-
# Auteur : Gregory CRESPIN
# Projet : Labellisez et appliquez des approches semi-supervisees en traitement d'images (BrainScanAI)
# Date : 08/02/2026
"""Configuration centralisee du projet."""

from pathlib import Path

# Chemins
PROJECT_ROOT = Path(__file__).resolve().parent
DATA_ROOT = PROJECT_ROOT / "datapic"
LABELED_DIR = DATA_ROOT / "avec_labels"
UNLABELED_DIR = DATA_ROOT / "sans_label"
OUTPUTS_DIR = PROJECT_ROOT / "outputs"
FEATURES_DIR = OUTPUTS_DIR / "features"
MODELS_DIR = OUTPUTS_DIR / "models"

# Créer les dossiers de sortie si besoin
for d in (OUTPUTS_DIR, FEATURES_DIR, MODELS_DIR):
    d.mkdir(parents=True, exist_ok=True)

# Classes (aligné avec la structure des dossiers)
CLASSES = ["normal", "cancer"]
CLASS_TO_IDX = {"normal": 0, "cancer": 1}
IDX_TO_CLASS = {0: "normal", 1: "cancer"}

# Image
IMG_SIZE = 512
RESIZE_FOR_MODEL = 224  # entrée standard ResNet/ConvNeXt (ImageNet)

# ResNet / extraction de features
FEATURE_LAYER = "avgpool"  # ou "layer4" pour features plus riches
BACKBONE = "resnet50"
BATCH_SIZE_EXTRACT = 32

# Clustering
N_CLUSTERS = 2
RANDOM_STATE = 1492

# Entraînement
BATCH_SIZE_TRAIN = 16
EPOCHS_PRETRAIN_WEAK = 5
EPOCHS_FINETUNE_STRONG = 15
LR = 1e-4
TEST_SIZE = 0.2
VAL_SIZE = 0.15

# Validation croisée 5-fold
N_FOLDS = 5