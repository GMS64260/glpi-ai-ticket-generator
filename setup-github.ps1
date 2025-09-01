# Script PowerShell pour configurer et publier le projet sur GitHub
# Assurez-vous d'avoir Git installé et d'être authentifié avec GitHub

Write-Host "=== Configuration du projet GLPI AI Ticket Generator ===" -ForegroundColor Green

# Vérifier si on est dans le bon dossier
$currentPath = Get-Location
if ($currentPath.Path -ne "C:\glpi-ai-ticket-generator") {
    Set-Location -Path "C:\glpi-ai-ticket-generator"
}

# Initialiser Git si nécessaire
if (!(Test-Path ".git")) {
    git init
    Write-Host "✓ Repository Git initialisé" -ForegroundColor Green
}

# Configuration Git (remplacer par vos informations)
Write-Host "`nConfiguration de Git..." -ForegroundColor Yellow
$userName = Read-Host "Entrez votre nom GitHub (GMS64260)"
$userEmail = Read-Host "Entrez votre email GitHub"

git config user.name $userName
git config user.email $userEmail

# Ajouter tous les fichiers
Write-Host "`nAjout des fichiers..." -ForegroundColor Yellow
git add .
git commit -m "Initial commit: GLPI AI Ticket Generator workflow"
Write-Host "✓ Fichiers ajoutés et commit créé" -ForegroundColor Green

# Créer le repository sur GitHub via GitHub CLI (si installé)
$hasGhCli = Get-Command gh -ErrorAction SilentlyContinue
if ($hasGhCli) {
    Write-Host "`nCréation du repository sur GitHub..." -ForegroundColor Yellow
    gh repo create glpi-ai-ticket-generator --public --description "AI-powered GLPI ticket generation workflow for n8n" --source=. --push
    Write-Host "✓ Repository créé et code poussé sur GitHub!" -ForegroundColor Green
} else {
    Write-Host "`nGitHub CLI non détecté. Instructions manuelles:" -ForegroundColor Yellow
    Write-Host "1. Créez un nouveau repository sur https://github.com/new" -ForegroundColor White
    Write-Host "   - Nom: glpi-ai-ticket-generator" -ForegroundColor White
    Write-Host "   - Visibilité: Public" -ForegroundColor White
    Write-Host "   - Ne PAS initialiser avec README" -ForegroundColor White
    Write-Host "`n2. Puis exécutez ces commandes:" -ForegroundColor White
    Write-Host "   git remote add origin https://github.com/$userName/glpi-ai-ticket-generator.git" -ForegroundColor Cyan
    Write-Host "   git branch -M main" -ForegroundColor Cyan
    Write-Host "   git push -u origin main" -ForegroundColor Cyan
}

# Ajouter un tag de version
Write-Host "`nAjout du tag de version..." -ForegroundColor Yellow
git tag -a v1.0.0 -m "First public release - AI-powered GLPI ticket generator"
Write-Host "✓ Tag v1.0.0 créé" -ForegroundColor Green

Write-Host "`n=== Configuration terminée ===" -ForegroundColor Green
Write-Host "Votre projet est prêt à être publié sur GitHub!" -ForegroundColor Green
Write-Host "URL du projet: https://github.com/$userName/glpi-ai-ticket-generator" -ForegroundColor Cyan