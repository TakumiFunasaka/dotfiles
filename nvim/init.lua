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
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ----------------------------------------------------------------------------
-- キーマップ
-- ----------------------------------------------------------------------------
vim.g.mapleader = ' '

-- ノーマルモード
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = '保存' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = '閉じる' })
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { desc = 'ハイライト消去' })

-- ウィンドウ移動
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- バッファ移動
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = '次のバッファ' })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { desc = '前のバッファ' })

-- ファイルツリー
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'ファイルツリー開閉' })
vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', { desc = 'ファイルツリーにフォーカス' })

-- ファイル検索 (Telescope)
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', { desc = 'ファイル検索' })
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>', { desc = 'テキスト検索' })
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { desc = 'バッファ一覧' })
vim.keymap.set('n', '<leader>r', ':Telescope oldfiles<CR>', { desc = '最近のファイル' })

-- ----------------------------------------------------------------------------
-- プラグイン管理（lazy.nvim）
-- ----------------------------------------------------------------------------
-- lazy.nvim のブートストラップ
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン定義
require('lazy').setup({
  -- ========================================
  -- カラースキーム: Catppuccin
  -- ========================================
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,  -- 最初にロード
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',  -- latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          neotree = true,
          telescope = { enabled = true },
          treesitter = true,
        },
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },

  -- ========================================
  -- ファイルツリー: Neo-tree (Finder的な役割)
  -- ========================================
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = true,       -- 隠しファイルも薄く表示
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = { '.git', 'node_modules', '.DS_Store' },
          },
        },
        window = {
          width = 35,
          mappings = {
            ['<space>'] = 'none',  -- leaderと競合しないように
          },
        },
      })
    end,
  },

  -- ========================================
  -- ファジーファインダー: Telescope
  -- ========================================
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { 'node_modules', '.git/', '%.lock' },
        },
      })
    end,
  },

  -- ========================================
  -- シンタックスハイライト: Treesitter
  -- ========================================
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- 新しいAPI: vim.treesitter を直接利用
      vim.treesitter.language.register('markdown', 'markdown')
      -- ハイライトとインデントを有効化
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- ========================================
  -- ステータスライン: Lualine
  -- ========================================
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'catppuccin',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },
      })
    end,
  },

  -- ========================================
  -- Git 表示: Gitsigns (行ごとの変更表示)
  -- ========================================
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- ========================================
  -- インデントガイド
  -- ========================================
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup()
    end,
  },
}, {
  -- lazy.nvim の設定
  install = {
    colorscheme = { 'catppuccin' },
  },
})
