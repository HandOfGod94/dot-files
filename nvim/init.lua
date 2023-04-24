-- Plugins

vim.cmd([[packadd packer.nvim]])

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'gpanders/editorconfig.nvim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-abolish'
  use 'tpope/vim-endwise'
  use 'tpope/vim-rails'
  use 'voldikss/vim-floaterm'
  use 'RRethy/nvim-treesitter-endwise'
  use 'folke/which-key.nvim'
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'mhinz/vim-startify'
  use 'nvim-treesitter/nvim-treesitter'
  use 'godlygeek/tabular'
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-jdtls'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-tags'
  use 'ludovicchabant/vim-gutentags'
  use 'windwp/nvim-autopairs'
  use 'schickling/vim-bufonly'
  use {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end
  }
  use 'preservim/vim-markdown'
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  use 'j-hui/fidget.nvim'
  use 'terryma/vim-expand-region'
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  use 'rgroli/other.nvim'
  use 'ggandor/lightspeed.nvim'
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use 'ThePrimeagen/refactoring.nvim'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'tpope/vim-dispatch'
  use 'simrat39/rust-tools.nvim'
  use 'Olical/conjure'
  use 'gpanders/nvim-parinfer'
  use 'vim-scripts/applescript.vim'
  use { 'kosayoda/nvim-lightbulb', requires = 'antoinemadec/FixCursorHold.nvim' }
  use 'shumphrey/fugitive-gitlab.vim'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'leoluz/nvim-dap-go'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'Invertisment/conjure-clj-additions-cider-nrepl-mw'
  use 'xolox/vim-misc'
  use 'windwp/nvim-ts-autotag'
  use 'mfussenegger/nvim-dap-python'
  use 'vim-test/vim-test'
  use 'matze/vim-move'
  use 'DanilaMihailov/beacon.nvim'
  use 'nacro90/numb.nvim'
  use 'chrisbra/csv.vim'
  use 'rizzatti/dash.vim'
  use 'folke/zen-mode.nvim'
  use 'janet-lang/janet.vim'
  use { 'nvim-neorg/neorg', requires = "nvim-lua/plenary.nvim" }
  use 'dhruvasagar/vim-table-mode'
  use 'imsnif/kdl.vim'
  use 'jlcrochet/vim-rbs'

  -- custom blocks, for heling in navigating languages with do,end (ruby, elixir)
  use 'kana/vim-textobj-user'
  use 'nelstrom/vim-textobj-rubyblock'

  -- themes
  use 'marko-cerovac/material.nvim'
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
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
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'

-- vim test config
vim.g['test#strategy'] = 'floaterm'
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.cmd([[
  set breakindent
  let &showbreak='    '
  let test#python#runner = 'pyunit'
  let test#ruby#bundle_exec = 0
  let test#ruby#use_spring_binstub = 1
  let g:table_mode_corner_corner='+'
  let g:table_mode_header_fillchar='='

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

vim.g.material_style = "deep ocean"
-- vim.g.material_style = "lighter"
vim.cmd('colorscheme material')
-- vim.cmd('colorscheme tokyonight-night')

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').]] ..
    [[' ... '.trim(getline(v:foldend)).]] ..
    [[' ('.(v:foldend-v:foldstart).' lines folded...)']]
vim.opt.fillchars = "fold: "
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 4


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

-- auto reload file
-- vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
--   pattern = "*",
--   group = "auto_read",
--   callback = function()
--     vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
--   end,
-- })



-- Key bindings
local wk = require("which-key")
wk.register({
  ["<C-h>"]     = { "zh", "Scroll left" },
  ["<C-l>"]     = { "zl", "Scroll right" },
  H             = { "<cmd>noh<cr>", "Remove highlights" },
  ["<C-p>"]     = { "<cmd>Telescope find_files hidden=true shorten_path=true<CR>", "Find files" },
  ["<SPACE>t"]  = { "<cmd>b#<CR>", "Toggle previous/current buffer" },
  ["<SPACE>'"]  = { "<cmd>split | term<CR>", "Open terminal" },
  ["<SPACE>p"]  = {
    name = "+Plugins",
    i    = { "<cmd>PackerInstall<cr>", "Install plugins" },
    u    = { "<cmd>PackerUpdate<cr>", "Update plugins" },
    s    = { "<cmd>PackerStatus<cr>", "Status" },
    c    = { "<cmd>PackerClean<cr>", "Clean plugins" }
  },
  ["<SPACE>?"]  = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "search current word in all files", mode = {
    "n", "v" } },
  ["<SPACE>/"]  = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "search in current buffer" },
  ["<SPACE>q"]  = {
    name = "+Quickfix",
    o = { "<cmd>copen<cr>", "Open quickfix list" },
    c = { "<cmd>ccl<cr>", "close quickfix list" },
    n = { "<cmd>cnext<cr>", "jump to next item in quickfix list" },
    p = { "<cmd>cp<cr>", "jump to prev item in quickfix list" }
  },
  ["<SPACE>g"]  = {
    name = "+Git",
    s    = { "<cmd>Git<cr>", "git status" },
    D    = { "<cmd>Git difftool<cr>", "git diff" },
    b    = { "<cmd>Git blame<cr>", "git blame" }
  },
  q             = { "<cmd>bd | bp<cr>", "Close current buffer" },
  ["<SPACE>b"]  = {
    name = "+Buffers",
    l = { "<cmd>Telescope buffers<cr>", "List all buffers" },
    d = { "<cmd>Bonly<CR>", "Close other buffers" },
  },
  ["<SPACE>f"]  = {
    name  = "+File ops",
    t     = { "<cmd>NvimTreeToggle<cr>", "Toggle file tree" },
    ["/"] = { "<cmd>NvimTreeFindFile<cr>", "Open current file in explorer" },
    f     = { "<cmd>Telescope find_files hidden=true shorten_path=true<cr>", "Open file" },
    g     = { "<cmd>Telescope live_grep<cr>", "Search in file" },
    h     = { "<cmd>Telescope help_tags<cr>", "Telescope help" }
  },
  ["<SPACE>s"]  = {
    name = "+Stack",
    r = {
      "<cmd>Dispatch docker-compose stop && docker-compose rm -f -v && docker volume prune -f && docker-compose up -d<CR>",
      "Reset docker stack" },
    s = { "<cmd>Dispatch docker-compose up -d<CR>", "start docker stack" },
    S = { "<cmd>Dispatch docker-compose stop && docker-compose rm -f -v && docker volume prune -f<CR>",
      "stopc docker stack" }
  },
  ["<SPACE>\\"] = { "<cmd>BufferLinePick<cr>", "switch buffer" },
  ["<SPACE>T"]  = {
    name = "+Theme",
    l    = { "<cmd>lua require('material.functions').change_style('light')<cr>", "Switch to ligher theme" },
    d    = { "<cmd>lua require('material.functions').change_style('dark')<cr>", "Switch to darker theme" }
  },
  ["<SPACE>a"]  = {
    name = "+Alternate files",
    t    = { "<cmd>Other<cr>", "Toggle between related files" },
    v    = { "<cmd>OtherVSplit<cr>", "Vertical split related file" },
    h    = { "<cmd>OtherSplit<cr>", "Horizontal split related file" }
  },
  ["<SPACE>z"]  = { "<cmd>ZenMode<cr>", "Toggle zen mode" },
  ["<SPACE>l"]  = { name = "+Language" },
  ["<SPACE>r"]  = {
    name = "+Run",
    t = {
      name = "+Tests",
      s = { "<cmd>TestSuite<cr>", "run test suite" },
      f = { "<cmd>TestFile<cr>", "run test file" },
      t = { "<cmd>TestNearest<cr>", "run current test" },
      l = { "<cmd>TestLast<cr>", "rerun latest test" },
      v = { "<cmd>TestVisit<cr>", "visit last run test" },
    }
  },
  ["<SPACE>N"]  = { "<cmd>Neorg<cr>", "Open neorg notes" }
  -- note: each binding needs to be added to on_attach as well
})


-- require("tokyonight-themeswitcher").day_night_setup()
require("bufferline").setup({
  options = {
    numbers = 'ordinal',
    show_buffer_close_icons = false,
    separator_style = 'thick',
    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } }
  }
})

require('lualine').setup({
  sections = {
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = {},
  },
  theme = 'tokyonight',
})
require("nvim-tree").setup({
  disable_netrw = false, -- required for GBrowse
  -- open_on_setup = true, -- no longer supported
  prefer_startup_root = true,
  sync_root_with_cwd = true, -- caveat with root and cwd
  respect_buf_cwd = true,
  view = {
    adaptive_size = true,
    side = "left",
    width = "20%",
  },
  actions = {
    open_file = {
      resize_window = true
    }
  }
})
require('nvim-treesitter.configs').setup({
  ensure_installed = { "go", "java", "lua", "rust", "ruby", "elixir", "python", "clojure", "fennel", "json", "yaml",
    "svelte", "javascript", "css", "vue", "html", "heex", "vim", "vimdoc", "norg", "norg_meta", "markdown", "kdl" },
  highlight = {
    enable = true,
  },
  endwise = { enable = true }
})


require('telescope').setup({
  defaults = {
    file_ignore_patterns = { "node_modules", "target", ".git/", ".elixir_ls/", "deps", "_build/", "tags" },
    path_display = { "smart" },
    dynamic_preview_title = true,
    layout_strategy = 'horizontal',
    layout_config = { width = 0.95 }
  },
  extensions = {
    ["ui-select"] = { require("telescope.themes").get_dropdown({}) }
  }
})
require('toggle_lsp_diagnostics').init()
require("telescope").load_extension("ui-select")
require("lightspeed").setup({})
require("fidget").setup({})
require("lsphelpers").setup()
require("snippets").setup()
require('refactoring').setup({})
require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
require("nvim-autopairs").setup({})
require('gitsigns').setup()
require('dapui').setup()
require('zen-mode').setup({})
require('nvim-ts-autotag').setup({
  autotag = {
    enable = true,
  }
})

require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode"
      }
    },
    ["core.integrations.treesitter"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = "~/workspace/notes",
        },
      },
    },
  },
}

-- other files, add more mappings
require('other-nvim').setup({
  rememberBuffers = false,
  mappings = {
    {
      pattern = "src/main/java/(.*).java",
      target = "src/test/%1Test.java",
      context = "test"
    },
    {
      pattern = "src/test/(.*)Test.java",
      target = "src/main/java/%1.java",
      context = "source"
    },
    {
      pattern = "(.*).go",
      target = "%1_test.go",
      context = "test"
    },
    {
      pattern = "(.*)_test.go",
      target = "%1.go",
      context = "source"
    },
    {
      pattern = "src/(.*).clj",
      target = "test/%1_test.clj",
      context = "test"
    },
    {
      pattern = "test/(.*)_test.clj",
      target = "src/%1.clj",
      context = "source"
    },
    {
      pattern = "src/(.*)/(.*).py",
      target = "tests/%1/test_%2.py",
      context = "test"
    },
    {
      pattern = "tests/(.*)/test_(.*).py",
      target = "src/%1/%2.py",
      context = "source"
    },
    {
      pattern = "app/(.*).rb",
      target = "spec/%1_spec.rb",
      context = "test"
    },
    {
      pattern = "app/(.*).rb",
      target = "sig/rbs_rails/app/%1.rbs",
      context = "rbs_type"
    },
    {
      pattern = "spec/(.*)_spec.rb",
      target = "app/%1.rb",
      context = "source"
    },
    {
      pattern = "sig/rbs_rails/app/(.*).rbs",
      target = "app/%1.rb",
      context = "source"
    },

    {
      pattern = "lib/(.*).rb",
      target = "test/%1_test.rb",
      context = "test"
    },
    {
      pattern = "test/(.*)_test.rb",
      target = "lib/%1.rb",
      context = "source"
    }
  }
})

-- autocomplete config
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local ls = require('luasnip')
ls.config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif ls.expand_or_locally_jumpable() then
        ls.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    -- TODO: Replace this with CR
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'tags' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})
