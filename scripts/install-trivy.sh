#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Installation de Trivy (Ubuntu/Debian) ..."

if [[ "$(uname -s)" != "Linux" ]]; then
  echo "[ERREUR] Ce script est prévu pour Linux (Codespaces / WSL / VM)."
  echo "Sur Windows/macOS : installe Trivy via ton gestionnaire de paquets (brew/choco) ou via Docker."
  exit 1
fi

sudo apt-get update -y
sudo apt-get install -y wget gnupg lsb-release apt-transport-https ca-certificates

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list >/dev/null

sudo apt-get update -y
sudo apt-get install -y trivy

trivy --version
