# Dotfiles

macOS 開発環境の設定ファイル一式。新しい Mac でもコマンド数回で同じ環境が再現できる。

## 新しい Mac でのセットアップ

### 前提条件

- macOS (Apple Silicon)
- Xcode Command Line Tools (`xcode-select --install`)

### 手順

```bash
# 1. Homebrew をインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. dotfiles をクローン
git clone git@github.com:TakumiFunasaka/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. インストールスクリプトを実行
chmod +x install.sh
./install.sh

# 4. シェルを再起動
exec zsh

# 5. 言語バージョンをインストール（必要に応じて）
mise use -g node@lts
mise use -g python@3.12
mise use -g go@latest
```

### iTerm2 の初期設定（手動）

1. `iTerm2` > `Settings` (Cmd+,) > `Profiles` > `Text`
   - Font を **Nerd Font** に変更（例: `Hack Nerd Font`）
   - 未インストールなら `brew install --cask font-hack-nerd-font`
2. `Profiles` > `Colors` > `Color Presets...` > `Import...`
   - `~/dotfiles/gruvbox-dark.itermcolors` を選択
   - もう一度 `Color Presets...` > `gruvbox-dark` を選択
3. `Profiles` > `Keys` > `General`
   - Left Option key を `Esc+` に変更
4. `Profiles` > `Terminal`
   - Scrollback lines を `10000` 以上に
5. `Profiles` > `Window`
   - Columns: `200`, Rows: `50` 程度に

---

## ファイル構成

```
dotfiles/
├── .zshenv                 # 環境変数（常に読み込まれる、Homebrew・mise初期化）
├── .zshrc                  # メインのZsh設定（エイリアス、ツール初期化）
├── .zprofile               # ログイン時の設定（XDG、PATH）
├── .gitconfig              # Git設定（エイリアス、delta連携）
├── .gitignore_global       # グローバルgitignore
├── .tmux.conf              # tmux設定
├── .tmux/
│   └── dev-layout.conf     # 開発用レイアウト（エディタ+Claude Code+ターミナル）
├── starship.toml           # Starshipプロンプト設定
├── nvim/
│   └── init.lua            # Neovim設定（lazy.nvim + プラグイン）
├── bat/
│   └── config              # bat設定（Catppuccin テーマ）
├── bin/
│   ├── t                   # タスク管理TUI
│   └── n                   # メモ/ノートTUI（2ペイン）
├── gruvbox-dark.itermcolors      # iTerm2カラープリセット
├── Brewfile                # Homebrewパッケージ定義
├── install.sh              # インストールスクリプト
└── README.md               # このファイル
```

### シンボリックリンクの対応関係

| dotfiles 内 | リンク先 |
|---|---|
| `.zshenv` | `~/.zshenv` |
| `.zshrc` | `~/.zshrc` |
| `.zprofile` | `~/.zprofile` |
| `.gitconfig` | `~/.gitconfig` |
| `.gitignore_global` | `~/.gitignore_global` |
| `.tmux.conf` | `~/.tmux.conf` |
| `.tmux/` | `~/.tmux/` |
| `starship.toml` | `~/.config/starship.toml` |
| `nvim/` | `~/.config/nvim/` |
| `bat/config` | `~/.config/bat/config` |

---

## カラーテーマ

全ツールを **Gruvbox Dark** で統一している。暖色系で目に優しく、ブルーライトが少ない。

| ツール | 設定方法 |
|---|---|
| iTerm2 | `gruvbox-dark.itermcolors` を手動インポート |
| tmux | `.tmux.conf` にハードコード済み |
| nvim | lazy.nvim で `ellisonleao/gruvbox.nvim` プラグイン |
| bat | `bat/config` で `--theme="gruvbox-dark"` |
| Starship / eza | ターミナルのカラーパレットに従う |

---

## tmux

ターミナルの画面分割とセッション管理。

### 概念

```
セッション (Session) ← プロジェクト単位の作業空間
  └── ウィンドウ (Window) ← タブ的なもの
        └── ペイン (Pane) ← 画面分割
```

### prefix キー

全ての tmux 操作は **`Ctrl+s` の後にキーを押す**2段階操作。以下 `prefix` = `Ctrl+s`。

### 起動・セッション管理

```bash
tmux                       # 起動
tmux new -s work           # 名前付きセッション作成
dev                        # カレントディレクトリ名でセッション作成/アタッチ (zshrc関数)
dev myproject              # 名前を指定してセッション作成/アタッチ

prefix + d                 # デタッチ（セッションは裏で生き続ける）
tmux attach                # 最後のセッションに戻る
tma                        # fzfでセッション選択してアタッチ (zshrcエイリアス)
tls                        # セッション一覧 (zshrcエイリアス)
tks <name>                 # セッション削除 (zshrcエイリアス)
```

### ペイン操作（画面分割）

```
prefix + |        左右に分割
prefix + -        上下に分割
prefix + h/j/k/l  ペイン間移動（vim風）
prefix + H/J/K/L  ペインリサイズ（Shift + vim風）
prefix + x        ペインを閉じる
prefix + z        全画面化トグル
```

マウスも有効。クリックでペイン切替、境界線ドラッグでリサイズできる。

### ウィンドウ操作

```
prefix + c        新しいウィンドウ
prefix + n / p    次 / 前のウィンドウ
prefix + 1~9      番号で直接移動
prefix + ,        ウィンドウ名を変更
prefix + &        ウィンドウを閉じる
```

### コピーモード

```
prefix + [        コピーモードに入る（スクロール可能になる）
  j/k             上下移動
  Ctrl+u/d        半ページスクロール
  /               検索
  v               選択開始
  y               コピー（macのクリップボードに入る）
  q               終了
```

### その他

```
prefix + r        設定リロード
prefix + D        開発用レイアウト展開
prefix + s        セッション一覧ツリー
prefix + w        ウィンドウ一覧ツリー
```

### 開発用レイアウト（prefix + D）

```
┌──────────────────┬──────────────────┐
│                  │                  │
│  エディタ(nvim)  │  Claude Code     │
│                  │                  │
├──────────────────┤                  │
│  ターミナル      │                  │
└──────────────────┴──────────────────┘
```

---

## Neovim

### 起動

```bash
v .               # カレントディレクトリで開く
v file.txt        # ファイルを開く
```

### 基本操作

leader キーは `Space`。

```
Space + w         保存
Space + q         閉じる
Esc Esc           検索ハイライト消去
Ctrl + h/j/k/l   ウィンドウ間移動
Tab / Shift+Tab   バッファ切替
```

### ファイルツリー (Neo-tree)

Finder のようにファイル/フォルダを操作できる。

```
Space + e         ファイルツリー開閉
Space + o         ファイルツリーにフォーカス
```

ツリー内の操作:

```
Enter             ファイルを開く / ディレクトリ開閉
a                 新規作成（末尾 / でディレクトリ）
d                 削除
r                 リネーム
c                 コピー
m                 移動
y                 パスをコピー
H                 隠しファイル表示切替
/                 名前でフィルター
q                 ツリーを閉じる
```

### ファイル検索 (Telescope)

```
Space + f         ファイル名で検索
Space + g         テキスト(grep)検索
Space + b         バッファ一覧
Space + r         最近開いたファイル
```

Telescope 内の操作:

```
Ctrl + j/k        候補を上下移動
Enter             開く
Ctrl + x          水平分割で開く
Ctrl + v          垂直分割で開く
Esc               閉じる
```

### インストール済みプラグイン

| プラグイン | 役割 |
|---|---|
| catppuccin | カラースキーム |
| neo-tree | ファイルツリー |
| telescope | ファジーファインダー |
| treesitter | シンタックスハイライト |
| lualine | ステータスバー |
| gitsigns | Git変更の行表示 |
| indent-blankline | インデントガイド |

---

## Claude Code

AI を使ったコーディングアシスタント。

### 起動

```bash
cc                         # claude を起動
ccc                        # 前回の会話を続ける
ccr                        # 過去のセッションを選んで再開
cc "この関数にテストを書いて"   # 指示付きで起動
```

### tmux と組み合わせた使い方

```bash
# 1. プロジェクトディレクトリでセッション開始
cd ~/code/src/github.com/user/project
dev

# 2. 開発レイアウトを展開 (prefix + D)
# 3. 左上ペインでエディタ: v .
# 4. 右ペインに移動 (prefix + l) して Claude Code: cc
# 5. 左下ペインでサーバーやテスト

# Claude Code が作業中に隣のペインで確認できる
```

### Claude Code 内の操作

```
/help              ヘルプ
/compact           会話を要約して圧縮
Ctrl+C             実行中のキャンセル
Escape             入力をクリア
```

---

## シェル (Zsh)

### エイリアス一覧

#### ファイル操作（eza / bat）

```bash
ls                 # eza --icons --git
ll                 # 詳細表示
la                 # 隠しファイル含む
lt                 # ツリー表示
lt -L 2            # ツリー（深さ2まで）
cat file.txt       # bat（シンタックスハイライト付き）
```

#### ディレクトリ移動（zoxide）

```bash
cd foo             # zoxide: 部分一致でジャンプ（過去に行ったディレクトリを学習）
cd proj            # → ~/code/src/.../project に飛ぶ
zi foo             # インタラクティブ選択（複数候補がある場合）
..                 # cd ..
...                # cd ../..
```

#### ファジー検索（fzf）

```bash
Ctrl+r             # コマンド履歴を検索
Ctrl+t             # ファイルを検索してパス挿入
Alt+c              # ディレクトリを検索してcd
repo               # ghqリポジトリをfzfで選んでcd
```

#### Git

```bash
# 状態確認
gs                 # git status
gd                 # git diff
gds                # git diff --staged
glog               # git log --oneline --graph --decorate

# コミット
ga file            # git add file
gaa                # git add --all
gc                 # git commit -v
gcm "msg"          # git commit -m "msg"
gca                # git commit --amend

# ブランチ
gco branch         # git checkout branch
gcb new-branch     # git checkout -b new-branch
gb                 # git branch

# リモート
gl                 # git pull
gp                 # git push
gf                 # git fetch

# スタッシュ
gst                # git stash
gstp               # git stash pop
```

#### グローバルエイリアス（パイプ省略）

```bash
ls G test          # = ls | grep test
history H          # = history | head
cat file C         # = cat file | pbcopy（クリップボードへ）
```

#### tmux

```bash
dev                # カレントディレクトリ名でセッション作成/アタッチ
dev name           # 名前指定でセッション作成/アタッチ
tma                # fzfでセッション選択
tls                # セッション一覧
tks name           # セッション削除
```

#### Claude Code

```bash
cc                 # claude
ccc                # claude --continue
ccr                # claude --resume
```

---

## CLIツール詳細

### ripgrep（高速grep）

```bash
rg "pattern"                    # カレントディレクトリ配下を検索
rg "pattern" src/               # ディレクトリを指定
rg -i "pattern"                 # 大文字小文字を区別しない
rg -t ts "function"             # TypeScriptファイルのみ
rg -C 3 "pattern"               # 前後3行のコンテキスト付き
rg --stats "pattern"            # 統計情報付き
```

### fd（高速find）

```bash
fd "*.tsx"                      # .tsxファイルを検索
fd -t d "test"                  # testを含むディレクトリを検索
fd -e go                        # .goファイルを検索
fd -H ".env"                    # 隠しファイルも含めて検索
```

### ghq（リポジトリ管理）

```bash
ghq get https://github.com/user/repo   # クローン（~/code/src/... に整理される）
ghq list                                # リポジトリ一覧
repo                                    # fzfで選んでcd
```

### mise（バージョンマネージャー）

```bash
# グローバル
mise use -g node@lts
mise use -g python@3.12
mise list                       # インストール済み一覧
mise current                    # 現在のバージョン

# プロジェクトごと
cd your-project
mise use node@18                # .mise.toml が生成される
```

### bat（cat代替）

```bash
cat file.json                   # シンタックスハイライト付き表示
bat -r 10:20 file.txt           # 10〜20行目を表示
bat --plain file.txt            # プレーンテキスト（色なし）
```

---

## Homebrew パッケージの管理

```bash
# Brewfileからインストール
brew bundle --file=~/dotfiles/Brewfile

# 現在の環境からBrewfileを再生成
brew bundle dump --file=~/dotfiles/Brewfile --force

# Brewfileに無いパッケージを確認
brew bundle cleanup --file=~/dotfiles/Brewfile
```

---

## 自作 CLI ツール (`~/dotfiles/bin/`)

### `t` - タスク管理 TUI

```bash
t                              # 起動
```

tmux ペインに常駐できる Neo-tree 風タスク管理ツール。

```
j/k          カーソル移動
a            タスク追加
d            完了トグル
x            削除
e            タイトル編集
Enter        詳細(メモ)編集 (Alt+Enter保存, ESCキャンセル)
g/G          先頭/末尾
q            終了
```

データ: `~/.tasks.json`

### `n` - メモ/ノート TUI（2ペイン）

```bash
n                              # 起動
```

Neo-tree + エディタ風の 2 ペイン構成メモアプリ。左にノート一覧、右に本文表示。

```
── 左ペイン ──
j/k          カーソル移動（右ペインが追従）
a            ノート追加（Blank / テンプレート選択）
x            削除
e            タイトル編集
Enter        本文編集モード (Alt+Enter保存, ESCキャンセル)
y            本文をクリップボードにコピー
t            テンプレート管理画面
Tab          右ペインへフォーカス移動

── 右ペイン（閲覧モード）──
j/k          スクロール
g/G          先頭/末尾
y            本文をクリップボードにコピー
Tab          左ペインへフォーカス移動

q            終了
```

データ: `~/.notes.json` / テンプレート: `~/.note-templates.json`

---

## ローカル設定

Git 管理しない個人設定はこれらのファイルに書く:

```bash
~/.zshrc.local       # Zsh追加設定
~/.zprofile.local    # PATH追加など
```

---

## トラブルシューティング

### 補完が効かない

```bash
rm -f ~/.zcompdump && exec zsh
```

### mise / node が認識されない

```bash
# .zshenv のリンクを確認
ls -la ~/.zshenv
# シェル再起動
exec zsh
```

### nvim のプラグインがおかしい

```bash
# プラグインを再インストール
nvim --headless "+Lazy! sync" +qa
# キャッシュをクリア
rm -rf ~/.local/share/nvim/lazy
nvim  # 起動すると自動で再インストールされる
```

### tmux のカラーがおかしい

iTerm2 の `Profiles` > `Terminal` > `Report Terminal Type` が `xterm-256color` になっているか確認。

---

## 更新履歴

- **2025-02**: tmux 導入、Gruvbox Dark でカラーテーマ統一、nvim に lazy.nvim + プラグイン追加、Claude Code エイリアス追加
- **2025-11**: 2025年版に完全刷新、Cursor サンドボックス対応

## ライセンス

MIT
