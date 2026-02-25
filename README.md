# Exploration et modélisation – Traitement d'images semi-supervisé

**Auteur :** Grégory CRESPIN  
**Projet :** Labellisez et appliquez des approches semi-supervisées en traitement d'images  
**Nom court :** BrainScanAI  
**Date :** 08/02/2026

Projet R&D de détection de tumeurs cérébrales à partir d'images IRM : exploration des données, extraction de features, clustering et apprentissage semi-supervisé.

## Structure du projet

```
PROJET07/
├── datapic/                    # Données (décompresser le zip ici)
│   ├── avec_labels/            # 100 images étiquetées (normal / cancer)
│   │   ├── normal/
│   │   └── cancer/
│   ├── sans_label/             # Images non étiquetées
│   └── Jeu de Données...txt    # Documentation
├── outputs/                    # Features, modèles (générés)
│   ├── features/               # Features extraites et labels générés
│   └── models/                 # Modèles sauvegardés
├── config.py                   # Configuration centralisée
├── requirements.txt
├── 01_exploration_et_extraction_features.ipynb
├── 01_exploration_et_extraction_features_convnext.ipynb
├── 02_clustering_analyse_non_supervisee.ipynb
├── 03_approche_semi_supervisee.ipynb
├── 03_approche_semi_supervisee_convnext.ipynb
├── support_presentation_recommandations.md
├── Dockerfile              # Configuration de l'image Docker
├── docker-compose.yml      # Configuration Docker Compose
├── start.bat               # Lance Docker (vérifie installation, construit et démarre)
├── stop.bat                # Arrête le conteneur Docker
├── restart.bat             # Redémarre le conteneur Docker
├── rclean.bat              # Arrête, nettoie les caches et relance Docker
└── README.md
```

## Installation

### Avec Docker (recommandé)

**Prérequis :** [Docker Desktop](https://www.docker.com/products/docker-desktop) installé et démarré.

#### Démarrage rapide

Sous Windows, utilisez les scripts batch fournis :

- **`start.bat`** : Lance l'environnement Docker (vérifie que Docker est installé et démarré, construit l'image si nécessaire, démarre Jupyter Lab)
- **`stop.bat`** : Arrête proprement le conteneur Docker
- **`restart.bat`** : Redémarre le conteneur (arrêt puis relance)
- **`rclean.bat`** : Arrête le conteneur, vide les caches Docker, puis relance avec reconstruction complète (utile en cas de problème)

#### Accès à Jupyter Lab

Après le lancement avec `start.bat`, un lien du type `http://127.0.0.1:8888/lab?token=...` s'affiche dans le terminal. Ouvrez-le dans votre navigateur pour accéder aux notebooks.

**Mot de passe Jupyter Lab :** `greg2026`

#### Structure Docker

- Le projet (notebooks, `datapic`, `outputs`, `config.py`) est monté dans le conteneur
- Les modifications sont conservées sur votre disque local
- Le port 8888 est exposé pour Jupyter Lab
- L'environnement Python est préconfiguré avec toutes les dépendances

#### Commandes manuelles

Si vous préférez utiliser Docker directement en ligne de commande :

```bash
# Démarrer (construction + lancement)
docker compose up --build

# Arrêter
docker compose down

# Redémarrer
docker compose down && docker compose up

# Nettoyer les caches et reconstruire
docker compose down
docker builder prune -f
docker compose up --build
```

### Avec venv (sans Docker)

```bash
python -m venv venv
venv\Scripts\activate   # Windows
pip install -r requirements.txt
```

## Livrables

### Notebooks principaux

| Livrable | Description |
|----------|-------------|
| **01_exploration_et_extraction_features.ipynb** | Exploration visuelle, préprocessing, extraction d'embeddings (ResNet50) |
| **01_exploration_et_extraction_features_convnext.ipynb** | Version alternative utilisant ConvNeXt pour l'extraction de features |
| **02_clustering_analyse_non_supervisee.ipynb** | Réduction de dimension (PCA/t-SNE/UMAP), clustering (K-Means, DBSCAN), ARI, labellisation faible |
| **03_approche_semi_supervisee.ipynb** | CNN ResNet50 : entraînement sur données faiblement labellisées puis sur données fortement labellisées ; comparaison supervisé vs semi-supervisé |
| **03_approche_semi_supervisee_convnext.ipynb** | Version alternative utilisant ConvNeXt Base pour l'apprentissage semi-supervisé |

### Fichiers générés (dans `outputs/`)

Les notebooks génèrent automatiquement les fichiers suivants dans les sous-dossiers de `outputs/` :

- **`outputs/features/`** :
  - `labels_labeled.csv` : Chemins et labels des images fortement labellisées
  - `paths_unlabeled.csv` : Chemins des images non labellisées
  - `weak_labels_from_clustering.csv` : Labels faibles générés par le clustering (utilisé par le notebook 03)
  - `features_labeled.npy` : Features extraites des images labellisées
  - `features_unlabeled.npy` : Features extraites des images non labellisées

- **`outputs/models/`** : Modèles sauvegardés (si implémenté dans les notebooks)

### Support de présentation

- **`support_presentation_recommandations.md`** : Synthèse des résultats, recommandations techniques et arguments pour le passage à l'échelle

## Definition of Done

- Features extraites et sauvegardées pour toutes les images.
- Clustering réalisé avec visualisation et score ARI sur les données fortement labellisées.
- Jeu faiblement labellisé **séparé** du jeu fortement labellisé (pas de mélange).
- Modèle semi-supervisé entraîné et évalué avec métriques définies (Accuracy, F1, Précision).
- Comparaison supervisé vs semi-supervisé documentée.
- Support de présentation avec recommandations techniques.

## Contraintes

- Python uniquement.
- Plusieurs algorithmes testés (clustering et classification).
- Métriques adaptées au coût d'erreur (F1 recommandé en cas de déséquilibre).
- Jeu de test jamais vu à l'entraînement pour chaque évaluation.
