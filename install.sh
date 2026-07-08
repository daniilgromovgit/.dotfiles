#!/bin/bash

set -e

DOTFILES="$HOME/.dotfiles"

echo "Installing packages..."
sudo pacman -S --needed $(grep -v '^#' "$DOTFILES/packages.txt")

echo "Setting zsh..."
chsh -s "$(which zsh)"

echo "Deploying configs..."
cd "$DOTFILES"

stow zsh
stow config

echo "Finished!"
echo "Restart your session."
