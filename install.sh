#!/bin/bash

set -e

DOTFILES="$HOME/.dotfiles"

echo "Installing packages..."
sudo pacman -S --needed $(grep -v '^#' "$DOTFILES/packages.txt")

echo "Setting zsh..."
chsh -s "$(which zsh)"

echo "Backing up existing configs..."

BACKUP="$HOME/.config-backup"
mkdir -p "$BACKUP"
mkdir -p "$HOME/.config"

[ -e "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$BACKUP/"
[ -d "$HOME/.config/niri" ] && mv "$HOME/.config/niri" "$BACKUP/"
[ -f "$HOME/.config/starship.toml" ] && mv "$HOME/.config/starship.toml" "$BACKUP/"
[ -d "$HOME/.config/DankMaterialShell" ] && mv "$HOME/.config/DankMaterialShell" "$BACKUP/"

echo "Deploying dotfiles..."

cd "$DOTFILES"

stow zsh
stow config

echo "Done!"
echo "Backup saved in $BACKUP"
echo "Restart your session."
