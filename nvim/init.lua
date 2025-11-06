-- ============================================================================
-- Neovim Configuration (Lua)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 基本設定
-- ----------------------------------------------------------------------------
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- 行番号
vim.opt.number = true
vim.opt.relativenumber = true

-- インデント
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 検索
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- 表示
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '100'
vim.opt.cursorline = true

-- ファイル
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- その他
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true

-- ----------------------------------------------------------------------------
-- キーマップ
-- ----------------------------------------------------------------------------
vim.g.mapleader = ' '

-- ノーマルモード
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>')

-- ウィンドウ移動
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- バッファ移動
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')

-- ----------------------------------------------------------------------------
-- カラースキーム
-- ----------------------------------------------------------------------------
vim.cmd('colorscheme habamax')

-- ----------------------------------------------------------------------------
-- プラグイン管理（lazy.nvim）
-- ============================================================================
-- 本格的に使う場合は、lazy.nvimなどのプラグインマネージャーを導入してください
-- https://github.com/folke/lazy.nvim
-- ============================================================================

