# ============================================================================
# ZSH Profile - ログイン時に1度だけ実行
# ============================================================================

# Homebrew (Apple Silicon Mac)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# XDG Base Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# PATH設定
export PATH="$HOME/.local/bin:$PATH"

# ローカル設定の読み込み
[ -f ~/.zprofile.local ] && source ~/.zprofile.local
