#!/bin/bash

# Cargar variables de entorno desde el archivo 'env42'
source "$HOME/.42Config/env42"

echo $REPOSITORIO
echo $WORKSPACE
# Comprueba si el directorio fuente existe. Si no existe, lo crea.
if [ ! -d "$REPOSITORIO" ]; then
	echo "El directorio fuente $REPOSITORIO no existe. Creándolo..."
	mkdir -p "$REPOSITORIO"
fi

# Función para manejar la descarga
download() {
	echo "Realizando descarga..."
	# Navegar a la carpeta de destino
	cd "$REPOSITORIO"
	git pull
	rsync -av --exclude='.git' --delete "$REPOSITORIO" "$WORKSPACE"
}

# Función para manejar la subida (upload)
upload() {
    echo "Realizando subida..."
    rsync -av --exclude='.git'  --delete "$WORKSPACE" "$REPOSITORIO"
	cd $REPOSITORIO
	git add .
	read -p "Insert the  commit message: " commit_message
	git commit -m "$commit_message"
	git push
}

# Procesamiento de los argumentos del script
while getopts "du" opt; do
  case $opt in
    d)
      download
      ;;
    u)
      upload
      ;;
    \?)
      echo "Opción inválida: -$OPTARG" >&2
      ;;
  esac
done

# Comprobación de que se haya proporcionado al menos una opción
if [ $# -eq 0 ]; then
    echo "No se proporcionaron argumentos. Utilice -d para download o -u para upload."
    exit 1
fi