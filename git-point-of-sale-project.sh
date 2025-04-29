#!/bin/bash

# Define the root directory where all repositories will be cloned
ROOT_DIR="point-of-sale"

# Create the root directory if it doesn't exist
mkdir -p "$ROOT_DIR"
cd "$ROOT_DIR"

repos=(
    "https://github.com/chanthorn24/point-of-sale-parent.git "
    "https://github.com/chanthorn24/lib-common-configuration.git lib-commons"
    "https://github.com/chanthorn24/lib-common-share.git lib-commons"
    "https://github.com/chanthorn24/lib-common-util.git lib-commons"
    "https://github.com/chanthorn24/point-of-sale-notification.git techno-services"
    "https://github.com/chanthorn24/point-of-sale-profile.git techno-services"
    "https://github.com/chanthorn24/point-of-sale-control.git techno-services"
    "https://github.com/chanthorn24/point-of-sale-oauthcipher.git techno-services"
)

for entry in "${repos[@]}"; do

  repo=$(echo "$entry" | cut -d ' ' -f 1)
  folder=$(echo "$entry" | cut -d ' ' -f 2-)

  echo "Repo: $repo"
  echo "Folder: $folder"

  # Check if folder is specified
  if [ -z "$folder" ]; then
    # If no folder specified, clone directly into the root directory
    echo "Cloning $repo into the root directory..."
    git clone "$repo"
  else
    echo "Cloning $repo into $folder..."
    mkdir -p "$folder"  # Create the folder if it doesn't exist
    cd "$folder"        # Navigate into the folder
    git clone "$repo"   # Clone the repository into the folder
    cd ..               # Go back to the previous directory
  fi
done

echo "Cloning completed!"

# Prevent the script from closing immediately
read -p "Press [Enter] to exit..."
