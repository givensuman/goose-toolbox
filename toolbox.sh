#!/bin/bash

function get_config_file {
  # Determine the configuration file location
  if [ -f "$HOME/.config/dune-toolbox/toolbox.ini" ]; then
    config_file="$HOME/.config/dune-toolbox/toolbox.ini"

  elif [ -f "/etc/dune-toolbox/toolbox.ini" ]; then
    config_file="/etc/dune-toolbox/toolbox.ini"

  else
    echo "Configuration file not found"
    print_usage
    exit 1
  fi

  echo $config_file
}

function get_default_config {
  config_file=$1

  # Get the first valid (non-commented) section from the .ini file
  default_config=$(grep -E '^\[[^\]]+\]' "${config_file}" | head -1 | sed 's/\[//' | sed 's/\]//')

  if [[ -z $default_config ]]; then
    echo "No configuration found in ${config_file}"
    print_usage
    exit 1
  fi
}

function print_usage {
  echo "Usage: toolbox <command> [args]"
  echo ""
  echo "Commands:"
  printf "\t create         create toolbox\n"
  printf "\t enter [args]   enter toolbox, running [args] as command\n"
  printf "\t replace        reinstall toolbox\n"
  echo ""
  echo "Configuration locations:"
  printf "\t/etc/dune-toolbox/toolbox.ini\n"
  printf "\t\$HOME/.config/dune-toolbox/toolbox.ini\n"
  echo ""
  echo "Configuration example:"
  printf "\t[dune-toolbox]\n"
  printf "\timage=\"ghcr.io/givensuman/dune-toolbox:stable\"\n"
  printf "\tvolume=\"/home/linuxbrew:/home/linuxbrew:rslave\"\n"
  printf "\tvolume=\"/usr/bin/:/usr/local/bin\"\n"
  printf "\tentry=false\n"
}

# Parse the subcommand
case "$1" in
create | c)
  config_file=$(get_config_file)
  distrobox assemble --file "${config_file}"
  ;;
enter | e)
  shift
  config_file=$(get_config_file)
  default_config=$(get_default_config "${config_file}")
  distrobox enter "${default_config}" -e "$@"
  ;;
replace | r)
  config_file=$(get_config_file)
  distrobox assemble --replace --file "${config_file}"
  ;;
help | "--help" | "-h")
  print_usage
  exit 0
  ;;
*)
  print_usage
  exit 1
  ;;
esac
