#!/bin/zsh
#
# zsh_launch_daemon_setup.sh
#
# This script sets up a LaunchDaemon on macOS that ensures proper zsh configuration
# at system startup by checking and potentially modifying /etc/zshrc
#
# Purpose: This helps macOS adhere to XDG Base Directory Specification standards
# by redirecting zsh configuration to $HOME/.config/zsh directory, which is the
# standard XDG location for application configurations.
#
# CAUTION: Please read this script thoroughly before running!
# Setting up LaunchDaemons affects system startup processes and requires root privileges.
# Each section is documented to help you understand exactly what it does.
#
# Usage:
#   ./zsh_launch_daemon_setup.sh         # Install the LaunchDaemon
#   ./zsh_launch_daemon_setup.sh --dry   # Dry run mode (shows what would happen without making changes)
#   ./zsh_launch_daemon_setup.sh --remove  # Uninstall the LaunchDaemon

# Define constants
SCRIPT_DIR=$(dirname "$0")
PROCESS_SCRIPT="$SCRIPT_DIR/zsh_config_check.sh"
PLIST_NAME="com.zheil.campsite.zshconfig.plist"
PLIST_PATH="/Library/LaunchDaemons/$PLIST_NAME"
PROCESS_SCRIPT_DIR="/Library/Application Support/campsite"
PROCESS_SCRIPT_DESTINATION="$PROCESS_SCRIPT_DIR/zsh_config_check.sh"

# Process script content
PROCESS_SCRIPT_CONTENT='#!/bin/zsh
# zsh_config_check.sh
#
# This script checks whether the ZDOTDIR environment variable is properly set in /etc/zshrc
# It runs at system startup via LaunchDaemon and makes the necessary changes if required
# 
# Purpose: Ensures that zsh configuration follows XDG Base Directory Specification standards
# by redirecting zsh configuration to $HOME/.config/zsh directory, which is the standard
# XDG location for application configurations.

# Write to stdout - launchd will redirect to the log file
log_message() {
  echo "$(date '"'"'+%Y-%m-%d %H:%M:%S'"'"') - $1"
}

log_message "Starting zsh configuration check process"

# Check if /etc/zshrc exists
if [ ! -f /etc/zshrc ]; then
  log_message "Error: /etc/zshrc file not found"
  exit 1
fi

# Get the required line with current date
REQUIRED_LINE="export ZDOTDIR=\"\$HOME/.config/zsh\" # last manual append by campsite on $(date '"'"'+%Y-%m-%d %H:%M:%S'"'"')"

# Check if the last line starts with the export ZDOTDIR statement
LAST_LINE=$(tail -n 1 /etc/zshrc)
if [[ "$LAST_LINE" == export\ ZDOTDIR=* ]]; then
  log_message "ZDOTDIR export already exists as the last line in /etc/zshrc. No action needed."
else
  log_message "Adding ZDOTDIR export to /etc/zshrc"
  echo "$REQUIRED_LINE" >> /etc/zshrc
  log_message "Successfully added ZDOTDIR configuration to /etc/zshrc"
fi

log_message "zsh configuration check completed successfully"
exit 0'

# LaunchDaemon plist content
PLIST_CONTENT='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.zheil.campsite.zshconfig</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Library/Application Support/campsite/zsh_config_check.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>/var/log/zsh_config_check.err</string>
    <key>StandardOutPath</key>
    <string>/var/log/zsh_config_check.log</string>
</dict>
</plist>'

# Set defaults
DRY_RUN=false
REMOVE=false

# Process command line arguments
for arg in "$@"; do
  case $arg in
    --dry)
      DRY_RUN=true
      echo "Running in dry mode - no changes will be made"
      ;;
    --remove)
      REMOVE=true
      echo "Remove mode activated - will uninstall the LaunchDaemon"
      ;;
    *)
      echo "WARNING: Unknown option: $arg"
      echo "Usage: $0 [--dry] [--remove]"
      exit 1
      ;;
  esac
done

# Function to check if we're running as root
check_root() {
  if [[ $DRY_RUN == true ]]; then
    echo "[DRY RUN] Note: A real run would require root privileges"
    return 0
  fi

  if [[ $EUID -ne 0 ]]; then
    echo "ERROR: This script must be run as root (with sudo)"
    echo "Please run: sudo $0 $@"
    exit 1
  fi
}

# Function to log actions
log_action() {
  local action=$1
  local dry_prefix=""
  
  if [[ $DRY_RUN == true ]]; then
    dry_prefix="[DRY RUN] Would "
  fi
  
  echo "${dry_prefix}${action}"
}

# Function to execute or simulate a command
execute_cmd() {
  local cmd=$1
  log_action "$cmd"
  
  if [[ $DRY_RUN == false ]]; then
    eval "$cmd"
    return $?
  fi
  
  return 0
}

# Remove the LaunchDaemon
remove_launch_daemon() {
  if [[ -f "$PLIST_PATH" ]]; then
    log_action "Unloading LaunchDaemon"
    if [[ $DRY_RUN == false ]]; then
      launchctl unload "$PLIST_PATH"
    fi
    
    log_action "Removing LaunchDaemon plist file: $PLIST_PATH"
    execute_cmd "rm -f \"$PLIST_PATH\""
    
    log_action "Removing process script: $PROCESS_SCRIPT_DESTINATION"
    execute_cmd "rm -f \"$PROCESS_SCRIPT_DESTINATION\""
    
    # Also try to remove the directory if it's empty
    log_action "Removing directory if empty: $PROCESS_SCRIPT_DIR"
    execute_cmd "rmdir \"$PROCESS_SCRIPT_DIR\" 2>/dev/null || true"
    
    echo "LaunchDaemon has been successfully removed"
  else
    echo "LaunchDaemon not found - nothing to remove"
  fi
}

# Create the LaunchDaemon
create_launch_daemon() {
  # First check if it already exists
  if [[ -f "$PLIST_PATH" ]]; then
    echo "LaunchDaemon already exists at $PLIST_PATH"
    echo "No action needed (setup is idempotent)"
    return 0
  fi

  # Create the directory for the process script if it doesn't exist
  log_action "Creating directory for process script: $PROCESS_SCRIPT_DIR"
  execute_cmd "mkdir -p \"$PROCESS_SCRIPT_DIR\""
  
  # Copy the process script to its destination
  log_action "Writing process script to $PROCESS_SCRIPT_DESTINATION"
  if [[ $DRY_RUN == false ]]; then
    echo "$PROCESS_SCRIPT_CONTENT" > "$PROCESS_SCRIPT_DESTINATION"
  else
    echo "[DRY RUN] Would write process script content to $PROCESS_SCRIPT_DESTINATION"
  fi
  
  # Set appropriate permissions for the script
  log_action "Setting permissions on process script (700)"
  execute_cmd "chmod 700 \"$PROCESS_SCRIPT_DESTINATION\""
  execute_cmd "chown root:wheel \"$PROCESS_SCRIPT_DESTINATION\""
  
  # Create the plist file
  log_action "Creating LaunchDaemon plist at $PLIST_PATH"
  
  if [[ $DRY_RUN == false ]]; then
    # First create the XML plist in a temporary file
    TEMP_PLIST_FILE=$(mktemp)
    echo "$PLIST_CONTENT" > "$TEMP_PLIST_FILE"
    
    # Convert to binary plist format using plutil
    log_action "Converting plist to binary format using plutil"
    execute_cmd "plutil -convert binary1 \"$TEMP_PLIST_FILE\" -o \"$PLIST_PATH\""
    
    # Clean up temporary file
    rm -f "$TEMP_PLIST_FILE"
  else
    echo "[DRY RUN] Would create plist file with the following content (converted to binary format):"
    echo "$PLIST_CONTENT"
    echo "[DRY RUN] Would convert the XML plist to binary format using: plutil -convert binary1"
  fi
  
  # Set proper permissions for the plist file
  log_action "Setting permissions on LaunchDaemon plist"
  execute_cmd "chmod 644 \"$PLIST_PATH\""
  execute_cmd "chown root:wheel \"$PLIST_PATH\""
  
  # Load the LaunchDaemon
  log_action "Loading LaunchDaemon"
  if [[ $DRY_RUN == false ]]; then
    launchctl load "$PLIST_PATH"
    echo "LaunchDaemon has been successfully installed and loaded"
  fi
}

# Main script execution
echo "======================================================"
echo "ZSH LaunchDaemon Setup Script"
echo "======================================================"
echo "WARNING: This script sets up a system LaunchDaemon"
echo "    that will run at startup with root privileges."
echo "    Please ensure you've reviewed this script before"
echo "    continuing, as it affects system configuration."
echo "======================================================"

# Check if we have the process script
if [[ ! -f "$PROCESS_SCRIPT" ]]; then
  echo "ERROR: Process script not found at $PROCESS_SCRIPT"
  exit 1
fi

# Check root permissions
check_root

# Execute the requested action
if [[ $REMOVE == true ]]; then
  remove_launch_daemon
else
  create_launch_daemon
fi

echo "Done!"
exit 0
