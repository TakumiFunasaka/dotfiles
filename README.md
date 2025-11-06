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
├── .zshenv             # 環境変数（常に読み込まれる）
├── .zshrc              # メインのZsh設定
├── .zprofile           # ログイン時の設定
├── .gitconfig          # Git設定
├── .gitignore_global   # グローバルgitignore
├── starship.toml       # Starshipプロンプト設定
├── Brewfile            # Homebrewパッケージ定義
├── install.sh          # インストールスクリプト
├── nvim/               # Neovim設定
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
- `ls`, `ll`, `la` - eza/lsのエイリアス
- `lt` - ツリー表示
- `cat` - batのエイリアス

### Git（基本コマンド）
- `g` → `git`
- `gs` → `git status`
- `ga` → `git add`
- `gaa` → `git add --all`
- `gc` → `git commit -v`
- `gcm` → `git commit -m`
- `gca` → `git commit --amend`

### Git（ブランチ操作）
- `gco` → `git checkout`
- `gcb` → `git checkout -b`
- `gb` → `git branch`
- `gbd` → `git branch -d`

### Git（差分・履歴）
- `gd` → `git diff`
- `gds` → `git diff --staged`
- `glog` → `git log --oneline --graph --decorate`
- `gloga` → `git log --oneline --graph --decorate --all`

### Git（リモート）
- `gl` → `git pull`
- `gp` → `git push`
- `gf` → `git fetch`

### Git（スタッシュ）
- `gst` → `git stash`
- `gsta` → `git stash apply`
- `gstp` → `git stash pop`

### グローバルエイリアス（超便利！）
- `G` → `| grep` - コマンドの後ろに付けるだけ
- `L` → `| less` - ページャーで表示
- `H` → `| head` - 先頭だけ表示
- `T` → `| tail` - 末尾だけ表示
- `C` → `| pbcopy` - クリップボードにコピー

**使用例:**
```bash
ls -la G "test"        # ls -la | grep "test"
history G "git" H      # history | grep "git" | head
cat file.txt C         # ファイル内容をクリップボードへ
```

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

## 📝 Tips & 詳細な使い方

### 🎯 mise（バージョンマネージャー）の使い方

#### グローバル設定
```bash
# よく使う言語をグローバルにインストール
mise use -g node@lts          # Node.js LTS版
mise use -g node@20           # Node.js 20系
mise use -g python@3.12       # Python 3.12
mise use -g go@latest         # Go最新版

# インストール済みバージョンの確認
mise list

# 現在アクティブなバージョンを確認
mise current
```

#### プロジェクトごとの設定
```bash
# プロジェクトディレクトリで実行
cd your-project
mise use node@18              # このプロジェクトだけNode 18
mise use python@3.11          # このプロジェクトだけPython 3.11

# .mise.toml が自動生成される
cat .mise.toml
# [tools]
# node = "18"
# python = "3.11"

# プロジェクトメンバーと設定を共有
git add .mise.toml
git commit -m "Add mise configuration"
```

#### 利用可能なバージョンの確認
```bash
# Node.jsの利用可能なバージョン一覧
mise ls-remote node

# 特定のバージョンを検索
mise ls-remote node | grep "20"

# Pythonの利用可能なバージョン
mise ls-remote python
```

#### バージョンの切り替え
```bash
# ディレクトリに入ると自動的に切り替わる
cd project-a      # → Node 18が有効化
cd ../project-b   # → Node 20が有効化
cd ~              # → グローバル設定（LTS）に戻る
```

### 🔍 fzf（ファジーファインダー）の使い方

#### 基本的なキーバインド
```bash
# コマンド履歴を検索
Ctrl+R            # 履歴を検索して実行

# ファイルを検索してパスを挿入
Ctrl+T            # カレントディレクトリ配下のファイルを検索

# ディレクトリを検索して移動
Alt+C             # ディレクトリを検索してcd
```

#### fzfの操作方法
```
↑/↓ または Ctrl+j/k  : 上下移動
Enter                 : 選択して確定
Ctrl+c または Esc     : キャンセル
Tab                   : 複数選択（トグル）
Shift+Tab             : 複数選択解除
```

#### 実践的な使い方
```bash
# Gitブランチを検索して切り替え
git branch | fzf | xargs git checkout

# プロセスをfzfで選んで終了
ps aux | fzf | awk '{print $2}' | xargs kill

# ファイルを検索してvimで開く
vim $(fzf)

# 複数ファイルを選択して削除（Tabで複数選択）
rm $(fzf -m)
```

### 🚀 zoxide（スマートcd）の使い方

#### 基本的な使い方
```bash
# 初回は通常のcdで移動
cd ~/Documents/projects/my-awesome-app

# 2回目以降は部分一致でOK
z awesome         # → ~/Documents/projects/my-awesome-app
z app            # → 同じく移動
z my-a           # → 同じく移動
```

#### よく使うコマンド
```bash
z foo            # foo にマッチするディレクトリへ移動
zi foo           # インタラクティブに選択（複数候補がある場合）
z foo bar        # foo と bar 両方を含むディレクトリへ
z -              # 前のディレクトリに戻る

# データベースを表示
zoxide query -l          # 記憶している全ディレクトリ
zoxide query -ls foo     # foo にマッチするディレクトリ一覧
zoxide query --score     # スコア付きで表示
```

#### 学習の仕組み
- **頻度**: よく訪れるディレクトリほど優先度が高い
- **最近性**: 最近使ったディレクトリも優先される
- **自動削除**: 存在しないディレクトリは自動で削除される

### 📂 eza（モダンなls）の使い方

```bash
# 基本（アイコン + Git情報付き）
ls               # eza --icons --git
ll               # 詳細表示
la               # 隠しファイルも表示
lt               # ツリー表示

# さらに詳細な使い方
eza -l --git            # Git情報を表示
eza --tree --level=2    # 2階層までツリー表示
eza -l --sort=size      # サイズでソート
eza -l --sort=modified  # 更新日時でソート
eza -la --no-icons      # アイコンなし
```

### 📄 bat（モダンなcat）の使い方

```bash
# 基本（シンタックスハイライト付き）
cat file.json         # JSONが色付きで表示
cat file.py          # Pythonのコードが色付き

# ページャーとして使う
less file.txt        # → bat として動作

# 行番号付きで表示
bat -n file.txt

# 特定の行を表示
bat -r 10:20 file.txt    # 10〜20行目を表示

# Gitの差分と一緒に表示
bat -d file.txt          # Git差分を表示

# プレーンテキストとして表示（色なし）
bat --plain file.txt
```

### 🔎 ripgrep（高速grep）の使い方

```bash
# 基本的な検索
rg "pattern"                    # カレントディレクトリ配下を検索
rg "pattern" path/              # 特定のディレクトリを検索
rg -i "pattern"                 # 大文字小文字を区別しない

# ファイルタイプを指定
rg -t js "function"             # JavaScriptファイルのみ
rg -t py "class"                # Pythonファイルのみ
rg -T js "function"             # JavaScriptファイルを除外

# コンテキスト付き表示
rg -C 3 "pattern"               # 前後3行を表示
rg -A 2 "pattern"               # 後2行を表示
rg -B 2 "pattern"               # 前2行を表示

# 統計情報
rg --stats "pattern"            # マッチ数などの統計
```

### 🔧 ghq（リポジトリ管理）の使い方

```bash
# リポジトリをクローン（自動で整理される）
ghq get https://github.com/user/repo
# → ~/code/src/github.com/user/repo にクローン

# リポジトリ一覧
ghq list

# リポジトリのパスを取得
ghq root
ghq list -p                     # フルパス表示

# fzfと組み合わせて移動（repoエイリアス）
repo                            # リポジトリ選択→移動
```

### 🎨 Starshipプロンプトのカスタマイズ

```bash
# 設定ファイルを編集
vim ~/.config/starship.toml

# プリセットを試す
starship preset nerd-font-symbols -o ~/.config/starship.toml
starship preset bracketed-segments -o ~/.config/starship.toml

# 設定を確認
starship config

# 特定のモジュールを無効化（例：時間表示）
[time]
disabled = true
```

### 🍺 Homebrewパッケージの管理

```bash
# 現在の環境からBrewfileを生成
brew bundle dump --file=~/dotfiles/Brewfile --force

# Brewfileからインストール
brew bundle --file=~/dotfiles/Brewfile

# Brewfileに無いパッケージを削除
brew bundle cleanup --file=~/dotfiles/Brewfile

# Brewfileをチェック
brew bundle check --file=~/dotfiles/Brewfile
```

### 🔄 便利なワークフロー

#### Git操作の基本フロー
```bash
# ブランチを切る
gcb feature/new-feature

# 変更を加える
vim file.txt

# コミット＆プッシュ
gaa                    # 全変更をステージング
gcm "feat: 新機能追加"  # コミット
gp                     # プッシュ
```

#### プロジェクト間の移動
```bash
# リポジトリを検索して移動
repo                   # fzfでリポジトリ選択

# または、zoxideで移動
z my-project          # よく使うプロジェクトに瞬時に移動
```

#### ファイル検索とコマンド実行
```bash
# ファイルを検索してvimで開く
vim $(fzf)

# ディレクトリを検索して移動
cd $(fd --type d | fzf)

# コードを検索してvimで開く
rg -l "TODO" | fzf | xargs vim
```

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

# シェルを再読み込み
source ~/.zshenv
source ~/.zshrc

# または
exec zsh
```

### Cursorのサンドボックス環境でnpm/nodeが使えない

Cursorのサンドボックス環境は非インタラクティブシェルのため、`.zshenv`で初期化されます。
通常は自動的に動作しますが、問題がある場合：

```bash
# .zshenvが正しくリンクされているか確認
ls -la ~/.zshenv

# miseが読み込まれているか確認
echo $MISE_SHELL

# 手動でシェルをリロード
exec zsh
```

**根本原因**: `.zshrc`は非インタラクティブシェルでは読み込まれませんが、`.zshenv`は常に読み込まれます。このdotfilesでは`.zshenv`でmiseとHomebrewを初期化しているため、Cursorのサンドボックス環境でも動作します。

## 📚 参考リンク

- [Starship Documentation](https://starship.rs/)
- [mise Documentation](https://mise.jdx.dev/)
- [Homebrew Documentation](https://docs.brew.sh/)
- [fzf Wiki](https://github.com/junegunn/fzf/wiki)

## 📄 ライセンス

MIT

---

**最終更新**: 2025年11月

