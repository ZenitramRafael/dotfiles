#!/usr/bin/env bash
# Bootstraps this machine from ~/dotfiles. Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> dotfiles at $DOTFILES"

# ---- 1. Detect OS ----
# uname -s prints "Darwin" on macOS, "Linux" on both native Linux and WSL2.
# WSL2 specifically also has /proc/version mentioning "microsoft".
OS="$(uname -s)"
IS_WSL=false
if [[ "$OS" == "Linux" ]] && grep -qi microsoft /proc/version 2>/dev/null; then
  IS_WSL=true
fi
echo "==> OS: $OS (WSL2: $IS_WSL)"

# ---- 2. Homebrew ----
# Homebrew works on macOS and Linux/WSL2 (as "Linuxbrew"), which is why the
# core Brewfile can be shared across both.
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$OS" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "==> Homebrew already installed"
fi

# ---- 3. Install packages ----
echo "==> brew bundle (shared CLI tools)"
brew bundle --file="$DOTFILES/Brewfile"

if [[ "$OS" == "Darwin" ]]; then
  echo "==> brew bundle (macOS-only GUI apps)"
  brew bundle --file="$DOTFILES/Brewfile.mac"
fi

# ---- 4. Symlink configs ----
# link SRC DEST: backs up any pre-existing real file/dir at DEST once, then
# points DEST at SRC. Safe to re-run -- if the symlink already points at the
# right place, it's a no-op.
link() {
  local src="$1" dest="$2"
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "==> $dest already linked"
    return
  fi
  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "==> backing up existing $dest -> ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "==> linked $dest -> $src"
}

link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES/fish/config.fish" "$HOME/.config/fish/config.fish"
link "$DOTFILES/fish/starship.toml" "$HOME/.config/starship.toml"

# ---- 5. TPM (tmux plugin manager) ----
# Cloned outside the repo, like any other third-party dependency.
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
  echo "==> Installing TPM"
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "==> TPM already installed"
fi

echo "==> Done. Open tmux and press prefix + I to install tmux plugins."
echo "==> Open nvim to let lazy.nvim install plugins from lazy-lock.json."
