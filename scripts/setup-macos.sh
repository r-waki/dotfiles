#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
REPO_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
HOME_DIR=${HOME:?}
BACKUP_SUFFIX=$(date +%Y%m%d%H%M%S)

link_path() {
  source_path=$1
  target_path=$2

  mkdir -p "$(dirname "$target_path")"

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    printf 'Already linked: %s\n' "$target_path"
    return
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    backup_path="${target_path}.backup-${BACKUP_SUFFIX}"
    mv "$target_path" "$backup_path"
    printf 'Moved existing item to %s\n' "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'Linked %s -> %s\n' "$target_path" "$source_path"
}

for name in .bashrc .zshrc .gitconfig .gitignore_global .vimrc .tmux.conf Brewfile; do
  link_path "$REPO_ROOT/$name" "$HOME_DIR/$name"
done

link_path "$REPO_ROOT/.copilot" "$HOME_DIR/.copilot"

mkdir -p "$HOME_DIR/.config"

for name in nvim wezterm exercism yarn aerospace; do
  link_path "$REPO_ROOT/.config/$name" "$HOME_DIR/.config/$name"
done

link_path \
  "$REPO_ROOT/.config/powershell/user_profile.ps1" \
  "$HOME_DIR/.config/powershell/Microsoft.PowerShell_profile.ps1"
