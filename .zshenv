# ============================================================================
# ZSH Environment - 常に読み込まれる（非インタラクティブシェルでも）
# ============================================================================

# Homebrew (Apple Silicon Mac)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  # curl: macOS標準(/usr/bin/curl)は証明書の一覧が更新されないため、Homebrew版を優先
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
  # python3: Homebrewの既定は3.15になったが、3.13を使い続ける
  export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
fi

# mise (バージョンマネージャー) - サンドボックス環境でも動作するように
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# dotfiles bin
export PATH="$HOME/dotfiles/bin:$PATH"

# Rust (rustup)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
