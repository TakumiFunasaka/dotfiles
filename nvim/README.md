# Neovim Configuration

シンプルなNeovim設定ファイルです。

## セットアップ

```bash
# ~/.config/nvim にシンボリックリンクを作成
ln -sf ~/dotfiles/nvim ~/.config/nvim
```

## プラグインマネージャーの導入（推奨）

本格的に使う場合は、[lazy.nvim](https://github.com/folke/lazy.nvim) などのプラグインマネージャーを導入することをお勧めします。

```lua
-- lazy.nvimのインストール例
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
```

## 推奨プラグイン

- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - ファジーファインダー
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - シンタックスハイライト
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP設定
- **[catppuccin](https://github.com/catppuccin/nvim)** - モダンなカラースキーム

