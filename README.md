# 🏠 Dotfiles (2025 Edition)

モダンで高速、保守しやすいdotfiles環境です。

## ✨ 特徴

- **🚀 高速**: Starship、eza、ripgrepなどの現代的なツール
- **🎨 美しい**: Starshipによるカスタマイズ可能なプロンプト
- **🔧 シンプル**: 必要最小限の設定で理解しやすい
- **📦 統一管理**: miseで複数言語のバージョンを統一管理
- **🔍 強力な検索**: fzfによるファジーファインダー

## 📦 含まれるツール

### コアツール
- **[mise](https://mise.jdx.dev/)** - 統一的なバージョンマネージャー（asdfの後継）
- **[Starship](https://starship.rs/)** - 高速でカスタマイズ可能なプロンプト
- **[Homebrew](https://brew.sh/)** - macOSパッケージマネージャー

### モダンCLIツール
- **[eza](https://github.com/eza-community/eza)** - `ls`の現代的な代替
- **[bat](https://github.com/sharkdp/bat)** - `cat`の代替（シンタックスハイライト付き）
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - スマートな`cd`
- **[fzf](https://github.com/junegunn/fzf)** - ファジーファインダー
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** - 高速grep
- **[fd](https://github.com/sharkdp/fd)** - 高速find
- **[ghq](https://github.com/x-motemen/ghq)** - Gitリポジトリ管理

## 🚀 インストール

### 新規インストール

```bash
# リポジトリをクローン
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# インストールスクリプトを実行
chmod +x install.sh
./install.sh
```

### 既存環境からの移行

```bash
cd ~/dotfiles

# 最新の変更を取得
git pull

# modernize-2025ブランチに切り替え（テスト用）
git checkout modernize-2025

# インストール
./install.sh

# 問題なければmasterにマージ
git checkout master
git merge modernize-2025
```

### インストール後

```bash
# ターミナルを再起動するか
source ~/.zshrc

# 言語のバージョンをインストール（必要に応じて）
mise use -g node@lts
mise use -g python@3.12
mise use -g go@latest
```

## 📁 ファイル構成

```
dotfiles/
├── .zshrc              # メインのZsh設定
├── .zprofile           # ログイン時の設定
├── .gitconfig          # Git設定
├── .gitignore_global   # グローバルgitignore
├── starship.toml       # Starshipプロンプト設定
├── Brewfile            # Homebrewパッケージ定義
├── install.sh          # インストールスクリプト
└── README.md           # このファイル
```

## 🎨 カスタマイズ

### ローカル設定

個人的な設定は以下のファイルに記載することで、gitで管理せずに済みます：

```bash
# Zsh設定
~/.zshrc.local

# プロファイル設定
~/.zprofile.local
```

### Starshipのカスタマイズ

```bash
vim ~/.config/starship.toml
```

詳細は[Starshipドキュメント](https://starship.rs/config/)を参照。

### 言語バージョンの管理

```bash
# プロジェクトごとに指定
cd your-project
mise use node@18
mise use python@3.11

# グローバルに指定
mise use -g node@lts
mise use -g python@3.12

# インストール済みバージョンの確認
mise list

# 利用可能なバージョンの確認
mise ls-remote node
```

## 🔑 主要なエイリアスとコマンド

### ディレクトリ移動
- `z <dir>` - zoxideによるスマートcd
- `..`, `...`, `....` - 上のディレクトリへ移動

### ファイル操作
- `ls`, `ll`, `la` - exa/lsのエイリアス
- `lt` - ツリー表示
- `cat` - batのエイリアス

### Git
- `g` → `git`
- `gs` → `git status`
- `ga` → `git add`
- `gc` → `git commit -v`
- `gco` → `git checkout`
- `glog` → `git log --oneline --graph`
- その他多数（`.zshrc`参照）

### リポジトリ管理
- `repo` - ghq + fzfでリポジトリを検索・移動

## 🔄 アップデート

```bash
cd ~/dotfiles
git pull
./install.sh
```

## 🔙 ロールバック

何か問題があった場合：

```bash
# 旧バージョンに戻す
git checkout master  # または任意のコミット

# バックアップから復元
# install.shが作成したバックアップは ~/dotfiles_backup_YYYYMMDD_HHMMSS にあります
```

## 📝 Tips

### Homebrewパッケージの管理

```bash
# 現在の環境からBrewfileを生成
brew bundle dump --file=~/dotfiles/Brewfile --force

# Brewfileからインストール
brew bundle --file=~/dotfiles/Brewfile

# クリーンアップ
brew bundle cleanup --file=~/dotfiles/Brewfile
```

### fzfの便利な使い方

- `Ctrl+R` - コマンド履歴を検索
- `Ctrl+T` - ファイルを検索
- `Alt+C` - ディレクトリを検索して移動

## 🐛 トラブルシューティング

### 補完が効かない

```bash
rm -f ~/.zcompdump
autoload -Uz compinit && compinit
```

### miseが認識されない

```bash
# Homebrewのパスを確認
which mise

# .zshrcを再読み込み
source ~/.zshrc
```

## 📚 参考リンク

- [Starship Documentation](https://starship.rs/)
- [mise Documentation](https://mise.jdx.dev/)
- [Homebrew Documentation](https://docs.brew.sh/)
- [fzf Wiki](https://github.com/junegunn/fzf/wiki)

## 📄 ライセンス

MIT

---

**最終更新**: 2025年11月

