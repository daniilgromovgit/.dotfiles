#!/bin/bash

set -e

DOTFILES="$HOME/.dotfiles"

echo "Installing packages..."
sudo pacman -S --needed $(grep -v '^#' "$DOTFILES/packages.txt")

echo "Setting zsh..."
chsh -s "$(which zsh)"

echo "Removing existing configs..."
rm -rf ~/.zshrc
rm -rf ~/.config/kitty
rm -rf ~/.config/niri
rm -f ~/.config/starship.toml

echo "Deploying dotfiles..."
cd "$DOTFILES"

stow zsh
stow config

echo "Done! Restart your session."
