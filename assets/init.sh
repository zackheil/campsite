#!/usr/bin/env zsh

branch="dev"
zip_file="$branch.zip"

# Fetch repository
temp_dir=$(mktemp -d)

if [ ! -d "$temp_dir" ]; then
    echo "Failed to create temporary directory."
    exit 1
fi

cd "$temp_dir"

curl -fsSLO https://github.com/zackheil/campsite/archive/$branch.zip

if [ ! -f "$zip_file" ]; then
    echo "Failed to download the repository."
    exit 1
fi

unzip $zip_file &>/dev/null

dir_name="campsite-$branch"
if [ ! -d "$dir_name" ]; then
    echo "Failed to unzip the repository."
    exit 1
fi

rm -rf "$HOME/.local/campsite"
mv $dir_name "$HOME/.local/campsite"

if [ ! -d "$HOME/.local/campsite" ]; then
    echo "Failed to move the repository to ~/.local/campsite"
    exit 1
fi

# Start main script
chmod +x "$HOME/.local/campsite/run"

clear
echo "
           (                 ,&&&.
            )                .,.&&
           (  (              \=__/
               )             ,'-'.
         (    (  ,,      _.__|/ /|
          ) /\ -((------((_|___/ |
        (  // | (`'      ((  `'--|
      _ -.;_/ \\--._      \\ \-._/.
     (_;-// | \ \-'.\    <_,\_\`--'|
     ( `.__ _  ___,')      <_,-'__,'
      `'(_ )_)(_)_)'
================================================

"

echo "The following actions will require sudo permissions and a terminal with full-disk access."
echo "Both conditions will need to be met for the machine setup to run successfully."
echo "If needed, CTRL+C now and go give the terminal full-disk access in the System Preferences."

sudo "$HOME/.local/campsite/run" "initial_run"
