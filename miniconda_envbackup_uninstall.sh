#!/bin/bash


export_folder="$HOME/miniconda_envs_backup"
mkdir -p "$export_folder"

# Export envs to a folder
for env in $(conda env list | awk '{print $1}' | grep -v "#")
do
    echo "Exporting environment: $env"
    conda env export -n "$env" > "$export_folder/$env.yml"
done

# Deactivate any active conda environment
conda deactivate

# Delete all conda environments
echo "Deleting all conda environments..."
for env in $(conda env list | awk '{print $1}' | grep -v "#" | grep -v "base")
do
    echo "Deleting environment: $env"
    conda env remove -n "$env"
done

# Uninstall Miniconda
miniconda_dir=$(conda info --base)
rm -rf "$miniconda_dir"

# Remove conda command from PATH
sed -i '/conda/d' ~/.bashrc
sed -i '/condabin/d' ~/.bashrc

# Remove any remaining conda-related files
rm -rf ~/.conda
rm -rf ~/.condarc
rm -rf ~/.continuum

# Apply the changes to PATH
source ~/.bashrc
