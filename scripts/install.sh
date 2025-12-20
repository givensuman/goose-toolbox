#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  exec sudo bash -s -- "$@"
fi

if [[ $(command -v toolbox) || -f /usr/bin/toolbox ]]; then
  bin=$(command -v toolbox || /usr/bin/toolbox)
  echo "toolbox is already installed at ${bin}"
  exit 1
fi

if [[ ! $(command -v distrobox) ]]; then
  echo "distrobox is required but not found"
  exit 1
fi

cp toolbox.sh /usr/bin/toolbox
chmod +x /usr/bin/toolbox

mkdir -p /etc/dune-toolbox
cat >> /etc/dune-toolbox/toolbox.ini << EOF
[dune-toolbox]
image="ghcr.io/givensuman/dune-toolbox:stable"
volume="/home/linuxbrew:/home/linuxbrew:rslave"
volume="/usr/bin/:/usr/local/bin"
entry=false
EOF

echo "toolbox installed successfully"
