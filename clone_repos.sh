#!/bin/bash

# Cargar variables del archivo .env
export $(grep -v '^#' .env | xargs)

# Archivo que contiene la lista de repositorios
REPO_LIST="./repos.txt"

# Función para clonar repositorios
clone_repo() {
    local repo_url=$1
    local repo_dir=$2
    local branch=${3:-$BRANCH_DEFAULT}

    # Verifica si el directorio ya existe
    if [ -d "$repo_dir" ]; then
        echo "El repositorio $repo_dir ya existe. Saltando..."
    else
        echo "Clonando $repo_url en $repo_dir (branch: $branch)..."
        git clone -b "$branch" --depth 1 "$repo_url" "$repo_dir"
    fi
}

# Itera sobre cada línea del archivo
while IFS=" " read -r url dir branch; do
    clone_repo "$url" "$dir" "$branch"
done < "$REPO_LIST"

echo "Clonación de repositorios completada."
