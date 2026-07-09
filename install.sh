#!/bin/bash
set -e
DOTFILES="$HOME/.dotfiles"

echo "Installing packages..."
sudo pacman -S --needed $(grep -v '^#' "$DOTFILES/packages.txt")

echo "Setting zsh..."
chsh -s "$(which zsh)"

echo ""
echo "Existing configs (.zshrc, niri, starship.toml, DankMaterialShell) will be replaced."
echo "  1) Delete existing configs   [default]"
echo "  2) Backup existing configs"
read -rp "Choose an option [1/2]: " CHOICE
CHOICE="${CHOICE:-1}"

if [ "$CHOICE" = "2" ]; then
    ACTION="backup"
    BACKUP="$HOME/.config-backup"
    mkdir -p "$BACKUP"
    echo "Backing up existing configs to $BACKUP..."
else
    ACTION="delete"
    echo "Deleting existing configs..."
fi

mkdir -p "$HOME/.config"

handle_existing() {
    local target="$1"
    [ -e "$target" ] || return 0
    if [ "$ACTION" = "backup" ]; then
        mv "$target" "$BACKUP/"
    else
        rm -rf "$target"
    fi
}

handle_existing "$HOME/.zshrc"
handle_existing "$HOME/.config/niri"
handle_existing "$HOME/.config/starship.toml"
handle_existing "$HOME/.config/DankMaterialShell"

echo "Deploying dotfiles..."
cd "$DOTFILES"
stow zsh
stow config

echo "Done!"
if [ "$ACTION" = "backup" ]; then
    echo "Backup saved in $BACKUP"
fi
echo "Restart your session."
