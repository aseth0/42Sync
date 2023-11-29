#!/bin/bash

# Pregunta por las variables Repositorio y Workspace
read -p "Ingrese el nombre del Repositorio: " repositorio
read -p "Ingrese el nombre del Workspace: " workspace

# Verifica si el directorio ~/.42Config/ existe, si no, lo crea
config_dir="$HOME/.42Config"
if [ ! -d "$config_dir" ]; then
    mkdir "$config_dir"
fi

# Guarda las variables y sus valores en un fichero env42 dentro del directorio
env_file="$config_dir/env42"
echo "REPOSITORIO=$repositorio" > "$env_file"
echo "WORKSPACE=$workspace" >> "$env_file"

# Descarga el script 'sync42repo.sh' de GitHub con curl
# Reemplaza 'url_del_sync42repo' con la URL del script de GitHub que deseas descargar
script_url="url_del_sync42repo"
curl -o "$config_dir/sync42repo.sh" "$script_url"

# Hace el script ejecutable
chmod +x "$config_dir/sync42repo.sh"

# Muestra la información del creador del script hasta que el usuario presione 'q'
echo "Información del creador del script y sugerencia para crear un alias:"
cat "$config_dir/sync42repo.sh" | less

