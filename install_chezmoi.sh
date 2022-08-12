#!/bin/sh

##################################################################
# Install chezmoi (dotfiles management program) in the machine
# Argument :None
##################################################################

set -e

if [ ! "$(command -v chezmoi)" ]; then

  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"

  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"

  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"

  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1

  fi
else
  chezmoi=chezmoi
fi

# Get the Directory
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# Exec replace current process with chezmoi init 
exec "$chezmoi" init --apply "--source=$script_dir"
