# ============================================================================
# Modern ZSH Configuration (2025)
# ============================================================================

# ----------------------------------------------------------------------------
# 基本設定
# ----------------------------------------------------------------------------
export LANG=ja_JP.UTF-8
export EDITOR=vim

# 色を有効化
autoload -Uz colors && colors

# ----------------------------------------------------------------------------
# ヒストリ設定
# ----------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history              # セッション間でヒストリを共有
setopt hist_ignore_all_dups       # 重複を記録しない
setopt hist_ignore_space          # スペース始まりは記録しない
setopt hist_reduce_blanks         # 余分なスペースを削除
setopt hist_verify                # ヒストリ展開時に確認

# ----------------------------------------------------------------------------
# 補完設定
# ----------------------------------------------------------------------------
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 大文字小文字を区別しない
zstyle ':completion:*' menu select                     # 補完候補をハイライト
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' ignore-parents parent pwd ..

# ----------------------------------------------------------------------------
# オプション
# ----------------------------------------------------------------------------
setopt auto_cd                    # ディレクトリ名だけでcd
setopt auto_pushd                 # cdで自動的にpushd
setopt pushd_ignore_dups          # 重複したディレクトリを追加しない
setopt no_beep                    # ビープ音を無効化
setopt no_flow_control            # Ctrl+S/Qを無効化
setopt ignore_eof                 # Ctrl+Dで終了しない
setopt interactive_comments       # コメントを有効化
setopt print_eight_bit            # 日本語ファイル名を表示
setopt extended_glob              # 拡張グロブ

# ----------------------------------------------------------------------------
# キーバインド
# ----------------------------------------------------------------------------
bindkey -e  # Emacs風キーバインド

# 単語の区切り文字設定（Ctrl+Wでディレクトリ単位削除）
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# ----------------------------------------------------------------------------
# エイリアス - 基本
# ----------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# ----------------------------------------------------------------------------
# エイリアス - モダンツール
# ----------------------------------------------------------------------------
# eza (modern ls)
if command -v eza &> /dev/null; then
  alias ls='eza --icons --git'
  alias ll='eza --icons --git -l'
  alias la='eza --icons --git -la'
  alias lt='eza --icons --git --tree'
else
  alias ls='ls -G -F'
  alias ll='ls -l'
  alias la='ls -la'
fi

# bat (modern cat)
if command -v bat &> /dev/null; then
  alias cat='bat --paging=never'
  alias less='bat'
fi

# その他のグローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g C='| pbcopy'

# ----------------------------------------------------------------------------
# エイリアス - Git（厳選版）
# ----------------------------------------------------------------------------
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit -v --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gbd='git branch -d'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git pull'
alias gp='git push'
alias gf='git fetch'
alias glog='git log --oneline --graph --decorate'
alias gloga='git log --oneline --graph --decorate --all'
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash pop'

# ----------------------------------------------------------------------------
# エイリアス - 開発
# ----------------------------------------------------------------------------
alias vim='nvim' 2>/dev/null || alias vim='vim'
alias v='vim'
alias python='python3'
alias pip='pip3'

# ----------------------------------------------------------------------------
# 環境固有の設定
# ----------------------------------------------------------------------------
case ${OSTYPE} in
  darwin*)
    # Mac固有の設定
    export CLICOLOR=1
    ;;
  linux*)
    # Linux固有の設定
    ;;
esac

# ----------------------------------------------------------------------------
# ツール初期化
# ----------------------------------------------------------------------------
# Note: Homebrewとmiseは .zshenv で初期化済み（サンドボックス環境対応）

# Starship (プロンプト)
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# zoxide (スマートcd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

# fzf (ファジーファインダー)
if command -v fzf &> /dev/null; then
  source <(fzf --zsh) 2>/dev/null
fi

# ghq + fzf でリポジトリ移動
if command -v ghq &> /dev/null && command -v fzf &> /dev/null; then
  function repo() {
    local repo=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
    if [ -n "$repo" ]; then
      cd $(ghq root)/$repo
    fi
  }
fi

# ----------------------------------------------------------------------------
# ローカル設定の読み込み
# ----------------------------------------------------------------------------
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# vim:set ft=zsh:
