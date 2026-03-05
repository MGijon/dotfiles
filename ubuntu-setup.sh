#!/usr/bin/env bash
# Ubuntu setup script
# Based on ubuntu-setup.md — run after a fresh install

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── helpers ──────────────────────────────────────────────────────────────────

info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
warn()    { echo "[WARN]  $*"; }

step() {
    echo ""
    echo "======================================================"
    echo "  $*"
    echo "======================================================"
}

confirm() {
    read -rp "$1 [y/N] " ans
    [[ "$ans" =~ ^[Yy]$ ]]
}

# ── 1. System update ─────────────────────────────────────────────────────────

step "1. System update"
sudo apt update && sudo apt upgrade -y
success "System updated"

# ── 2. Core packages ─────────────────────────────────────────────────────────

step "2. Core packages"
sudo apt install -y \
    git \
    curl \
    wget \
    ripgrep \
    tmux \
    neovim \
    nitrogen \
    compton \
    suckless-tools \
    pcmanfm \
    snapd
success "Core packages installed"

# ── 2b. C / C++ compilers ─────────────────────────────────────────────────────

step "2b. C / C++ compilers"
# build-essential includes gcc, g++, make and libc-dev headers
sudo apt install -y build-essential
# Install the latest GCC available in the Ubuntu repos and set it as default
LATEST_GCC=$(apt-cache search '^gcc-[0-9]+$' | awk '{print $1}' | sort -V | tail -1)
LATEST_GPP=$(echo "$LATEST_GCC" | sed 's/gcc/g++/')
sudo apt install -y "$LATEST_GCC" "$LATEST_GPP"
sudo update-alternatives --install /usr/bin/gcc gcc "/usr/bin/${LATEST_GCC#gcc-}" 100 \
    --slave /usr/bin/g++ g++ "/usr/bin/${LATEST_GPP#g++-}"
success "C/C++ compilers installed ($(gcc --version | head -1))"

# ── 3. AwesomeWM ─────────────────────────────────────────────────────────────

step "3. AwesomeWM"
sudo apt install -y awesome
AWESOME_CONFIG_DIR="$HOME/.config/awesome"
mkdir -p "$AWESOME_CONFIG_DIR"
if [ ! -f "$AWESOME_CONFIG_DIR/rc.lua" ]; then
    cp /etc/xdg/awesome/rc.lua "$AWESOME_CONFIG_DIR/rc.lua"
    info "Copied default rc.lua to $AWESOME_CONFIG_DIR"
else
    warn "rc.lua already exists, skipping copy"
fi
success "AwesomeWM installed"

# ── 4. Ghostty terminal ───────────────────────────────────────────────────────

step "4. Ghostty terminal"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
success "Ghostty installed"

if confirm "Set Ghostty as the default terminal emulator?"; then
    sudo update-alternatives --config x-terminal-emulator
fi

# Copy Ghostty config if it exists in dotfiles
GHOSTTY_CONFIG_SRC="$DOTFILES_DIR/terminal/ghostty/config"
GHOSTTY_CONFIG_DST="$HOME/.config/ghostty/config"
if [ -f "$GHOSTTY_CONFIG_SRC" ]; then
    mkdir -p "$(dirname "$GHOSTTY_CONFIG_DST")"
    cp "$GHOSTTY_CONFIG_SRC" "$GHOSTTY_CONFIG_DST"
    success "Ghostty config copied"
else
    warn "No Ghostty config found at $GHOSTTY_CONFIG_SRC — skipping"
fi

# ── 5. Nerd Fonts ─────────────────────────────────────────────────────────────

step "5. Nerd Fonts"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
success "Nerd Fonts installed"

# ── 6. NvChad (Neovim config) ─────────────────────────────────────────────────

step "6. NvChad for Neovim"
NVIM_CONFIG="$HOME/.config/nvim"
if [ -d "$NVIM_CONFIG" ]; then
    warn "~/.config/nvim already exists"
    if confirm "Remove existing Neovim config and install NvChad?"; then
        rm -rf "$NVIM_CONFIG"
        git clone https://github.com/NvChad/starter "$NVIM_CONFIG"
        success "NvChad cloned — run 'nvim' to finish setup"
    fi
else
    git clone https://github.com/NvChad/starter "$NVIM_CONFIG"
    success "NvChad cloned — run 'nvim' to finish setup"
fi

# ── 7. tmuxifier ──────────────────────────────────────────────────────────────

step "7. tmuxifier"
TMUXIFIER_DIR="$HOME/.tmuxifier"
if [ ! -d "$TMUXIFIER_DIR" ]; then
    git clone https://github.com/jimeh/tmuxifier.git "$TMUXIFIER_DIR"
    success "tmuxifier cloned"
else
    warn "tmuxifier already present at $TMUXIFIER_DIR"
fi

# Add tmuxifier to shell config if not already there
SHELL_RC="$HOME/.bashrc"
if ! grep -q 'tmuxifier' "$SHELL_RC" 2>/dev/null; then
    cat >> "$SHELL_RC" <<'EOF'

# tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
EOF
    success "tmuxifier lines added to $SHELL_RC"
else
    warn "tmuxifier already configured in $SHELL_RC"
fi

# ── 8. Snap packages ──────────────────────────────────────────────────────────

step "8. Snap packages"
sudo snap install code --classic
sudo snap install typst
sudo snap install htop
success "Snap packages installed (VSCode, typst, htop)"

# ── 9. fastfetch ──────────────────────────────────────────────────────────────

step "9. fastfetch"
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install -y fastfetch
success "fastfetch installed"

# ── 10. Rust ──────────────────────────────────────────────────────────────────

step "10. Rust (via rustup)"
if ! command -v rustc &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # shellcheck source=/dev/null
    source "$HOME/.cargo/env"
    success "Rust installed"
else
    warn "Rust already installed ($(rustc --version))"
fi

# ── 11. Node.js + Yarn ────────────────────────────────────────────────────────

step "11. Node.js + Yarn"
if ! command -v node &>/dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
    success "Node.js installed"
else
    warn "Node.js already installed ($(node --version))"
fi
npm install --global yarn
success "Yarn installed"

# ── 12. Docker ────────────────────────────────────────────────────────────────

step "12. Docker"
if ! command -v docker &>/dev/null; then
    sudo apt install -y ca-certificates gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo usermod -aG docker "$USER"
    success "Docker installed — log out and back in to use without sudo"
else
    warn "Docker already installed ($(docker --version))"
fi

# ── 13. R ─────────────────────────────────────────────────────────────────────

step "13. R"
if ! command -v R &>/dev/null; then
    sudo apt install -y r-base
    success "R installed"
else
    warn "R already installed ($(R --version | head -1))"
fi

# ── 14. LaTeX ─────────────────────────────────────────────────────────────────

step "14. LaTeX (texlive)"
if ! command -v pdflatex &>/dev/null; then
    sudo apt install -y texlive-full
    success "LaTeX installed"
else
    warn "LaTeX already installed"
fi

# ── 15. SSH key for GitHub ────────────────────────────────────────────────────

step "15. SSH key for GitHub"
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ -f "$SSH_KEY" ]; then
    warn "SSH key already exists at $SSH_KEY"
else
    read -rp "Enter your email for the SSH key: " ssh_email
    ssh-keygen -t ed25519 -C "$ssh_email" -f "$SSH_KEY"
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY"
    echo ""
    info "Add the following public key to GitHub (Settings > SSH keys):"
    echo ""
    cat "${SSH_KEY}.pub"
    echo ""
    read -rp "Press Enter once you have added the key to GitHub..."
    ssh -T git@github.com || true
fi

# ── 16. Git config ────────────────────────────────────────────────────────────

step "16. Git config"
GIT_CONFIG_SRC="$DOTFILES_DIR/git/.gitconfig"
if [ -f "$GIT_CONFIG_SRC" ]; then
    cp "$GIT_CONFIG_SRC" "$HOME/.gitconfig"
    success "Git config copied"
else
    warn "No .gitconfig found in dotfiles — skipping"
fi

GIT_IGNORE_SRC="$DOTFILES_DIR/git/.gitignore_global"
if [ -f "$GIT_IGNORE_SRC" ]; then
    cp "$GIT_IGNORE_SRC" "$HOME/.gitignore_global"
    git config --global core.excludesfile "$HOME/.gitignore_global"
    success "Global .gitignore copied"
fi

# ── 17. Wallpapers ────────────────────────────────────────────────────────────

step "17. Wallpapers"
WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
if [ ! -d "$WALLPAPERS_DIR" ]; then
    info "Download wallpapers from https://github.com/JaKooLit/Wallpaper-Bank"
    info "Place them in ~/Pictures/Wallpapers"
    if confirm "Open the Wallpaper-Bank GitHub page in the browser?"; then
        xdg-open "https://github.com/JaKooLit/Wallpaper-Bank" &>/dev/null || true
    fi
else
    warn "Wallpapers directory already exists at $WALLPAPERS_DIR"
fi

# ── Done ──────────────────────────────────────────────────────────────────────

echo ""
echo "======================================================"
echo "  Setup complete!"
echo "======================================================"
echo ""
echo "Remaining manual steps:"
echo "  - Run 'nvim' to finish NvChad plugin installation"
echo "  - Configure AwesomeWM: ~/.config/awesome/rc.lua"
echo "  - Log out and back in for Docker group to take effect"
echo "  - Source your shell: source ~/.bashrc"
echo ""