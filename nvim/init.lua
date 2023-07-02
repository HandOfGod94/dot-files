-- Plugins

vim.cmd([[packadd packer.nvim]])

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'gpanders/editorconfig.nvim'

  -- tpope goodies
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-abolish'
  use 'tpope/vim-endwise'
  use 'tpope/vim-rails'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-rhubarb'

  use 'voldikss/vim-floaterm'
  use 'nvim-treesitter/nvim-treesitter'
  use 'RRethy/nvim-treesitter-endwise'
  use 'folke/which-key.nvim'
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'mhinz/vim-startify'
  use 'godlygeek/tabular'
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

  -- LSPs and DAPs
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-jdtls'
  use 'simrat39/rust-tools.nvim'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'leoluz/nvim-dap-go'
  use 'mfussenegger/nvim-dap-python'

  -- CMP

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-buffer'
  use 'quangnguyen30192/cmp-nvim-tags'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  use 'ludovicchabant/vim-gutentags'
  use 'windwp/nvim-autopairs'
  use {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end
  }
  use 'preservim/vim-markdown'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  use 'j-hui/fidget.nvim'
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  use 'rgroli/other.nvim'
  use 'ggandor/lightspeed.nvim'
  use 'guns/vim-sexp'
  use 'ThePrimeagen/refactoring.nvim'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'Olical/conjure'
  use 'gpanders/nvim-parinfer'
  use 'vim-scripts/applescript.vim'
  use { 'kosayoda/nvim-lightbulb', requires = 'antoinemadec/FixCursorHold.nvim' }
  use 'shumphrey/fugitive-gitlab.vim'
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'Invertisment/conjure-clj-additions-cider-nrepl-mw'
  use 'windwp/nvim-ts-autotag'
  use 'vim-test/vim-test'
  use 'DanilaMihailov/beacon.nvim'
  use 'matze/vim-move'
  use 'nacro90/numb.nvim'
  use 'chrisbra/csv.vim'
  use 'rizzatti/dash.vim'
  use 'folke/zen-mode.nvim'
  use 'janet-lang/janet.vim'
  use 'imsnif/kdl.vim'
  use 'jlcrochet/vim-rbs'
  use 'github/copilot.vim'

  -- custom blocks, for heling in navigating languages with do,end (ruby, elixir)
  use 'kana/vim-textobj-user'
  use 'nelstrom/vim-textobj-rubyblock'

  -- themes
  use 'marko-cerovac/material.nvim'
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'luisiacc/gruvbox-baby'
end)

-- editor config
vim.opt.nu = true
vim.opt.hlsearch = true
vim.opt.expandtab = true
vim.opt.cc = '120'
vim.opt.showmatch = true
vim.opt.autoindent = true
vim.opt.timeoutlen = 300
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.so = 10
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamed'
vim.opt.filetype = 'on'
vim.opt.filetype.plugin = 'on'
vim.opt.pumheight = 15 --limits the height of popup menu
vim.wo.wrap = true
vim.wo.signcolumn = 'yes:1'
vim.g.do_filetype_lua = 1
vim.g.sexp_filetypes = "clojure,fennel,janet"
vim.g.github_enterprise_urls = { 'https://github.com/gaia-venture' }
vim.g.gutentags_enabled = 0
vim.opt.conceallevel = 1
vim.opt.concealcursor = 'nc'
vim.opt.spell = false
vim.opt.breakindent = true
vim.cmd.colorscheme "gruvbox-baby"
vim.g.gruvbox_baby_telescope_theme = 1

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').]] ..
    [[' ... '.trim(getline(v:foldend)).]] ..
    [[' ('.(v:foldend-v:foldstart).' lines folded...)']]
vim.opt.fillchars = "fold: "
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 4

vim.g['test#strategy'] = 'floaterm'
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.table_mode_corner_corner = "+"
vim.g.table_mode_header_fillchar = "="
vim.g.move_key_modifier = 'C'
vim.g.move_key_modifier_visualmode = 'C'

vim.cmd([[
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true

  command! W write
  command! Q quit

  let &showbreak='    '
  let test#python#runner = 'pyunit'
  let test#ruby#bundle_exec = 0
  let test#ruby#use_spring_binstub = 1

  au TextYankPost * silent! lua vim.highlight.on_yank({timeout=300})
  autocmd CursorHold * lua vim.diagnostic.open_float({scope="line", border="rounded"})
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

--- autocmd
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


local ok, myplugins = pcall(require, "myplugins")
if ok then
  myplugins.setup()
end

local ok, mykeybindings = pcall(require, "mykeybindings")
if ok then
  mykeybindings.setup()
end
