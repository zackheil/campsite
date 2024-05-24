#!/usr/bin/env zsh

branch="dev"
zip_file="$branch.zip"

temp_dir=$(mktemp -d)

# Ensure the temporary directory was created
if [ ! -d "$temp_dir" ]; then
  echo "Failed to create temporary directory."
  exit 1
fi

echo "Temporary directory created at $temp_dir"

# Change to the temporary directory
cd "$temp_dir" || exit

# Download the GitHub repository as a zip file
curl -L -O https://github.com/zackheil/campsite/archive/$branch.zip

ls -la

# Check if the download was successful
if [ ! -f $zip_file ]; then
  echo "Failed to download the repository."
  exit 1
fi

echo "Repository downloaded as $zip_file"

# Unzip the contents
unzip $zip_file

# Check if the unzip was successful
if [ ! -d "$branch" ]; then
  echo "Failed to unzip the repository."
  exit 1
fi

echo "Repository unzipped"

# Remove any existing .installer directory
rm -rf "$HOME/.installer"

# Move the unzipped contents to the home directory as .installer
mv $branch "$HOME/.installer"

# Check if the move was successful
if [ ! -d "$HOME/.installer" ]; then
  echo "Failed to move the repository to ~/.installer."
  exit 1
fi

echo "Repository moved to ~/.installer"
echo "Temporary directory cleaned up"
echo "Setup complete. The repository is now located at ~/.installer"
