vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.wo.number = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.laststatus = 3

if vim.fn.has('mac') == 1 then
  vim.opt.guifont = "Hack Nerd Font:h14"
elseif vim.fn.has('linux') == 1 then
  vim.opt.guifont = "Hack Nerd Font:h14"
elseif vim.fn.has('win64') == 1 then
  vim.opt.guifont = "HackGen Console NF:h12"
end

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.opt.swapfile = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

vim.keymap.set('n', '<C-j>', 'gj')
vim.keymap.set('n', '<C-k>', 'gk')

vim.keymap.set('n', '<leader>nt', ':NvimTreeToggle<CR>')
vim.keymap.set('n','<Esc><Esc>', '<cmd>nohlsearch<CR><Esc>' )

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "frappe"
      }
      vim.cmd[[colorscheme catppuccin]]
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
      "nvim-tree/nvim-tree.lua",
      config = function()
          require("nvim-tree").setup({
              sync_root_with_cwd = true,
              respect_buf_cwd = false,
              update_focused_file = {
                  enable = true,
                  update_root = false
              }
          })
      end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
    end,
  },
  {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Telescope find files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope live grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Telescope buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Telescope help tags' },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "sindrets/diffview.nvim"
  },
  {
    "voldikss/vim-floaterm",
    keys = {
      { "<leader>gt", function()
        vim.cmd("FloatermNew lazygit")
        end, desc = "Floaterm Lazygit" },
    },
    config = function()
      require("floaterm").setup({
        -- floatterm の設定 (必要に応じて)
      })
    end
  },
  require('plugins.lsp_config'),
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "hrsh7th/cmp-buffer" }, -- 現在のバッファの内容を補完候補に含める
        { "saadparwaiz1/cmp_luasnip" }, -- LuaSnip と nvim-cmp を統合
        { "L3MON4D3/LuaSnip" }, -- スニペットエンジン LuaSnip
        { "rafamadriz/friendly-snippets" }, -- 事前定義されたスニペットコレクション
    },
    config = function()
        -- nvim-cmp の設定
        local cmp = require("cmp") -- nvim-cmp のメインモジュールをロード
        local luasnip = require("luasnip") -- LuaSnip のモジュールをロード
        require("luasnip/loaders/from_vscode").lazy_load() -- VSCode スタイルのスニペットをロード

        cmp.setup({
            snippet = {
                -- スニペット展開方法を定義
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- LuaSnip を使ってスニペットを展開
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- 補完候補のドキュメントを上にスクロール
                ["<C-f>"] = cmp.mapping.scroll_docs(4), -- 補完候補のドキュメントを下にスクロール
                ["<C-Space>"] = cmp.mapping.complete(), -- 手動で補完候補を表示
                ["<C-e>"] = cmp.mapping.abort(), -- 補完を中断して閉じる
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 補完確定 (現在選択中の候補を使用)
            }),
            sources = cmp.config.sources({
                { name = "luasnip", priority_weight = 20 }, -- LuaSnip を補完候補に含める
            }, {
                { name = "buffer" }, -- バッファの内容を補完候補に含める
            }),
        })
    end,
  },
})
