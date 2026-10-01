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
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.tmux" "$HOME/.tmux"
mkdir -p "$HOME/.config/bat"
ln -sf "$DOTFILES_DIR/bat/config" "$HOME/.config/bat/config"

echo "✅ Symlinks created!"

# ----------------------------------------------------------------------------
# Karabiner-Elements（シンボリックリンクだと設定の保存で壊れるのでコピー）
# ----------------------------------------------------------------------------
if [ ! -f "$HOME/.config/karabiner/karabiner.json" ]; then
  mkdir -p "$HOME/.config/karabiner"
  cp "$DOTFILES_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
  echo "✅ Karabiner config copied"
fi

# ----------------------------------------------------------------------------
# mise グローバル設定（dotfiles内に mise/config.toml を置くと
# このディレクトリ用の設定と誤認されるため、別名で置いてコピーする）
# ----------------------------------------------------------------------------
if [ ! -f "$HOME/.config/mise/config.toml" ]; then
  mkdir -p "$HOME/.config/mise"
  cp "$DOTFILES_DIR/mise-global/config.toml" "$HOME/.config/mise/config.toml"
  echo "✅ mise config copied"
fi

# ----------------------------------------------------------------------------
# iTerm2（設定をdotfiles/iterm2から読み込む）
# ----------------------------------------------------------------------------
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
echo "✅ iTerm2 will load settings from $DOTFILES_DIR/iterm2"

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

  # ~/.config/mise/config.toml に書いた言語をインストール
  mise install

  echo "✅ mise setup complete!"
fi

# ----------------------------------------------------------------------------
# Neovimプラグインのインストール
# ----------------------------------------------------------------------------
if command -v nvim &> /dev/null; then
  echo "📦 Installing Neovim plugins..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null
  echo "✅ Neovim plugins installed!"
fi

# ----------------------------------------------------------------------------
# iTerm2 カラープリセット
# ----------------------------------------------------------------------------
if [ -f "$DOTFILES_DIR/gruvbox-dark.itermcolors" ]; then
  echo ""
  echo "🎨 iTerm2 Gruvbox Dark カラープリセット:"
  echo "   手動でインポートしてください:"
  echo "   iTerm2 > Settings > Profiles > Colors > Color Presets... > Import..."
  echo "   → $DOTFILES_DIR/gruvbox-dark.itermcolors"
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
echo "  2. iTerm2 にカラープリセットをインポート（上記参照）"
echo "  3. iTerm2 のフォントを Nerd Font に変更"
echo "     (未インストールなら: brew install --cask font-hack-nerd-font)"
echo "  4. (Optional) Install languages with mise:"
echo "     mise use -g node@lts"
echo "     mise use -g python@3.12"
echo "  5. (Optional) Configure local settings:"
echo "     touch ~/.zshrc.local"
echo ""
echo "💾 Backup location: $BACKUP_DIR"
echo ""

