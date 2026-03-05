#!/usr/bin/env bash
# main.sh — dotfiles entry point
# Detects the OS and calls the appropriate installer script.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OS="$(uname -s)"

case "$OS" in
    Darwin)
        echo "macOS detected — running macos-setup.sh"
        bash "$DOTFILES_DIR/macos-setup.sh"
        ;;
    Linux)
        # Verify it's Ubuntu/Debian before proceeding
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            if [[ "$ID" == "ubuntu" || "$ID_LIKE" == *"ubuntu"* || "$ID_LIKE" == *"debian"* ]]; then
                echo "Ubuntu/Debian detected — running ubuntu-setup.sh"
                bash "$DOTFILES_DIR/ubuntu-setup.sh"
            else
                echo "Unsupported Linux distribution: $NAME"
                echo "Only Ubuntu/Debian is supported. Exiting."
                exit 1
            fi
        else
            echo "Cannot detect Linux distribution (/etc/os-release not found). Exiting."
            exit 1
        fi
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac