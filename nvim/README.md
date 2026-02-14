# Neovim Configuration

lazy.nvim によるプラグイン管理 + Catppuccin Mocha テーマ。

## プラグイン一覧

| プラグイン | 役割 |
|---|---|
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | カラースキーム |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | ファイルツリー |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | ファジーファインダー |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | シンタックスハイライト |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | ステータスバー |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git変更の行表示 |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | インデントガイド |

## キーマップ

leader = `Space`

### 基本

| キー | 動作 |
|---|---|
| `Space w` | 保存 |
| `Space q` | 閉じる |
| `Esc Esc` | 検索ハイライト消去 |
| `Ctrl+h/j/k/l` | ウィンドウ間移動 |
| `Tab` / `Shift+Tab` | バッファ切替 |

### Neo-tree（ファイルツリー）

| キー | 動作 |
|---|---|
| `Space e` | ファイルツリー開閉 |
| `Space o` | ファイルツリーにフォーカス |

### Telescope（検索）

| キー | 動作 |
|---|---|
| `Space f` | ファイル名で検索 |
| `Space g` | テキスト(grep)検索 |
| `Space b` | バッファ一覧 |
| `Space r` | 最近のファイル |

## プラグインの更新

```bash
nvim
# nvim 内で
:Lazy update
```
