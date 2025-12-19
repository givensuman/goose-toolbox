#!/bin/bash

# Determine the configuration file location
if [ -f "$HOME/.config/dune-toolbox/toolbox.ini" ]; then
  INI_FILE="$HOME/.config/dune-toolbox/toolbox.ini"
elif [ -f /etc/dune-os/toolbox.ini ]; then
  INI_FILE="/etc/dune-toolbox/toolbox.ini"
else
  echo "Configuration file not found at /etc/dune-toolbox/toolbox.ini or ~/.config/dune-toolbox/toolbox.ini"
  exit 1
fi

# Get the first valid (non-commented) section from the .ini file
SECTION=$(grep -E '^\[[^\]]+\]' "$INI_FILE" | head -1 | sed 's/\[//' | sed 's/\]//')

if [ -z "$SECTION" ]; then
  echo "No configuration found in $INI_FILE"
  exit 1
fi

# Parse the subcommand
case "$1" in
create)
  distrobox assemble --file "$INI_FILE" "$SECTION"
  ;;
enter)
  shift
  distrobox enter "$SECTION" "$@"
  ;;
*)
  echo "Usage: $0 <command>"
  echo ""
  echo "Commands:"
  printf "\t create - create toolbox"
  printf "\t enter  - enter toolbox"
  echo ""
  echo "Configuration locations:"
  printf "\t/etc/dune-toolbox/toolbox.ini"
  printf "\t\$HOME/.config/dune-toolbox/toolbox.ini"
  exit 1
  ;;
esac
