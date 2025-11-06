#!/bin/bash
# ============================================================================
# Dotfiles Installer
# ============================================================================

set -e  # エラーで停止

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "🚀 Dotfiles installation starting..."

# ----------------------------------------------------------------------------
# バックアップ
# ----------------------------------------------------------------------------
echo "📦 Creating backup..."
mkdir -p "$BACKUP_DIR"

for file in .zshenv .zshrc .zprofile .gitconfig .gitignore_global; do
  if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
    echo "  Backing up $file"
    mv "$HOME/$file" "$BACKUP_DIR/"
  fi
done

if [ -d "$HOME/.config/starship.toml" ]; then
  mv "$HOME/.config/starship.toml" "$BACKUP_DIR/"
fi

# ----------------------------------------------------------------------------
# シンボリックリンク作成
# ----------------------------------------------------------------------------
echo "🔗 Creating symlinks..."

# .configディレクトリの作成
mkdir -p "$HOME/.config"

# シンボリックリンク
ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "✅ Symlinks created!"

# ----------------------------------------------------------------------------
# Homebrewのインストール確認
# ----------------------------------------------------------------------------
if ! command -v brew &> /dev/null; then
  echo "⚠️  Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Apple Silicon用のパス設定
  if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "✅ Homebrew already installed"
fi

# ----------------------------------------------------------------------------
# Brewfileからインストール
# ----------------------------------------------------------------------------
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo "🍺 Installing packages from Brewfile..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  echo "✅ Packages installed!"
else
  echo "⚠️  Brewfile not found, skipping package installation"
fi

# ----------------------------------------------------------------------------
# mise設定
# ----------------------------------------------------------------------------
if command -v mise &> /dev/null; then
  echo "🔧 Setting up mise..."
  
  # よく使う言語をインストール（コメントアウト - 必要に応じて有効化）
  # mise use -g node@lts
  # mise use -g python@3.12
  # mise use -g go@latest
  
  echo "✅ mise setup complete!"
fi

# ----------------------------------------------------------------------------
# 完了
# ----------------------------------------------------------------------------
echo ""
echo "======================================================================"
echo "✨ Dotfiles installation complete!"
echo "======================================================================"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. (Optional) Install languages with mise:"
echo "     mise use -g node@lts"
echo "     mise use -g python@3.12"
echo "  3. (Optional) Configure local settings:"
echo "     touch ~/.zshrc.local"
echo ""
echo "💾 Backup location: $BACKUP_DIR"
echo ""

