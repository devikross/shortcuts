#!/data/data/com.termux/files/usr/bin/bash

# Ir a la carpeta de shortcuts
cd "$HOME/.shortcuts" || exit 1

# Aviso de inicio
termux-tts-speak -e com.google.android.tts "Iniciando actualización"

# Traer cambios remotos y sobrescribir todo local
git fetch origin
git reset --hard origin/main

# Aviso de fin
termux-tts-speak -e com.google.android.tts "Actualización completa"
