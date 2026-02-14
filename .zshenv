# ============================================================================
# ZSH Environment - 常に読み込まれる（非インタラクティブシェルでも）
# ============================================================================

# Homebrew (Apple Silicon Mac)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# mise (バージョンマネージャー) - サンドボックス環境でも動作するように
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# dotfiles bin
export PATH="$HOME/dotfiles/bin:$PATH"

