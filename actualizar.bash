#!/data/data/com.termux/files/usr/bin/bash

# Ir a la carpeta de shortcuts
cd "$HOME/.shortcuts" || exit 1

echo "[INFO] Actualizando desde GitHub..."

# Traer cambios remotos
git fetch origin

# Sobrescribir todo local con lo remoto
git reset --hard origin/main

echo "[INFO] Actualización completada."
