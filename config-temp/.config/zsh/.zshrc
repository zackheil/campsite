# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="$TMPDIR/$USER-runtime" && mkdir -p $XDG_RUNTIME_DIR && chmod 700 $XDG_RUNTIME_DIR

# not a part of standard, but maybe someday?
export XDG_BIN_DIR="$HOME/.local/bin"
[[ ":$PATH:" != *":$XDG_BIN_DIR:"* ]] && export PATH="$PATH:$XDG_BIN_DIR"

# colors
black=0;    sh_black=$(tput setaf $black)
red=1;      sh_red=$(tput setaf $red)
green=2;    sh_green=$(tput setaf $green)
yellow=3;   sh_yellow=$(tput setaf $yellow)
blue=4;     sh_blue=$(tput setaf $blue)
magenta=5;  sh_magenta=$(tput setaf $magenta)
cyan=6;     sh_cyan=$(tput setaf $cyan)
white=7;    sh_white=$(tput setaf $white)
orange=166; sh_orange=$(tput setaf $orange)
sh_normal=$(tput sgr0)

# some logging during the init of the shell env here
source "$(dirname "${(%):-%N}")/utils/logger"

if [ "$2" = '--debug' ]; then
    clear
    SCRIPT_DEBUG="1"	
    zlog_debug "xdg-zshrc" "Debug logging enabled"
fi

# homebrew adds things to the path and needs to be prioritized over source files
eval `/opt/homebrew/bin/brew shellenv`

# Check if the 'source' directory exists in $XDG_CONFIG_HOME/zsh
if [[ -d "$XDG_CONFIG_HOME/zsh/source" ]]; then
  for file in "$XDG_CONFIG_HOME/zsh/source/"*; do
    # Ensure only regular files are sourced (skip directories and special files)
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
fi

# hot reload mechanism
if [ "$1" = '1' ]; then
    [[ -z $SCRIPT_DEBUG ]] && clear
    zlog_success "zsh config, source files, and aliases have been reloaded!"
fi

# catch sneaky setup processes that might try and append/add to shell rc files 
KNOWN_RC_SHA="16d78f1d750238e345e335d037019ed38f20197e"
TEST_SHA=$(grep -v '^KNOWN_RC_SHA=' "$XDG_CONFIG_HOME/zsh/.zshrc" | sha1sum | awk '{print $1}')
if [[ $TEST_SHA != $KNOWN_RC_SHA ]]; then zlog_error "xdg-zshrc" "Anomaly - SHA mismatch!"; fi
if [ -f ~/.zshrc ]; then zlog_error "~/.zshrc" "Anomaly - file exists!"; fi 
if [ -f ~/.zprofile ]; then zlog_error "~/.zprofile" "Anomaly - file exists!"; fi 

# clean up that debug logger inport
zlog_destroy

unset SCRIPT_DEBUG
unset KNOWN_RC_SHA
unset TEST_SHA
