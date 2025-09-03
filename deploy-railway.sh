#!/bin/bash

# Script de déploiement Railway pour BS Shop
# Usage: ./deploy-railway.sh

echo "🚀 Déploiement BS Shop sur Railway"
echo "=================================="

# Vérification des prérequis
echo "📋 Vérification des prérequis..."

# Vérifier si git est installé
if ! command -v git &> /dev/null; then
    echo "❌ Git n'est pas installé"
    exit 1
fi

# Vérifier si le repository est un repo git
if [ ! -d ".git" ]; then
    echo "❌ Ce n'est pas un repository Git"
    exit 1
fi

echo "✅ Prérequis vérifiés"

# Vérifier le statut git
echo "📊 Vérification du statut Git..."
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Des modifications non commitées détectées"
    read -p "Voulez-vous les commiter avant le déploiement ? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        read -p "Message de commit: " commit_message
        git commit -m "$commit_message"
    fi
fi

# Pousser vers GitHub
echo "📤 Poussée vers GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo "✅ Code poussé vers GitHub avec succès"
    echo ""
    echo "🎯 Prochaines étapes :"
    echo "1. Allez sur https://railway.app"
    echo "2. Créez un nouveau projet"
    echo "3. Connectez votre repository GitHub"
    echo "4. Ajoutez les services PostgreSQL et Redis"
    echo "5. Configurez les variables d'environnement"
    echo "6. Déployez !"
    echo ""
    echo "📖 Consultez le guide complet : GUIDE_DEPLOIEMENT_RAILWAY.md"
else
    echo "❌ Erreur lors de la poussée vers GitHub"
    exit 1
fi
