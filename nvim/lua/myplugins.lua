local M = {}

M.setup = function()
  require("CopilotChat").setup({
    window = {
      layout = "float",
      height = 0.7,
      width = 0.8,
    }
  })
  require("glance").setup({})
  require("coverage").setup()
  require("octo").setup()
  require("treesitter-context").setup({
    max_lines = 5
  })
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      diagnostics = "nvim_lsp",
      numbers = 'ordinal',
      show_buffer_close_icons = false,
      indicator = { style = "icon", icon = "▎" },
      separator_style = "slant",
      offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
    },
  })

  require('lualine').setup({
    sections = {
      lualine_x = { 'encoding', 'filetype' },
      lualine_y = {},
    },
    options = {
      -- theme = 'gruvbox-baby',
      theme = 'catppuccin',
      -- theme = 'tokyonight',
    }
  })
  require("nvim-tree").setup({
    disable_netrw = false,     -- required for GBrowse
    prefer_startup_root = true,
    sync_root_with_cwd = true, -- caveat with root and cwd
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = { 'COMMIT_EDITMSG', 'gitcommit', 'vendor', '.git', 'fugitive' }
    },
    view = {
      adaptive_size = false,
      side = "left",
      width = "20%",
    },
    actions = {
      open_file = {
        resize_window = true
      }
    },
  })

  -- Install grammar with nvim-treesitter
  local list = require("nvim-treesitter.parsers").get_parser_configs()
  list.reason = {
    install_info = {
      url = "https://github.com/reasonml-editor/tree-sitter-reason",
      files = { "src/parser.c", "src/scanner.c" },
      branch = "master",
    },
  }

  -- treesitter configs
  require('nvim-treesitter.configs').setup({
    ensure_installed = { "go", "java", "lua", "rust", "ruby", "elixir", "python", "clojure", "fennel", "json", "yaml",
      "svelte", "javascript", "css", "vue", "html", "heex", "vim", "vimdoc", "norg", "markdown", "kdl", "typescript",
      "graphql", "hcl", "terraform", "dart", "reason" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },
    endwise = { enable = true }
  })


  require('telescope').setup({
    defaults = {
      file_ignore_patterns = { "node_modules", "target", ".git/", ".elixir_ls/", "deps", "_build/", "tags" },
      path_display = { "smart" },
      dynamic_preview_title = true,
      layout_strategy = 'bottom_pane',
      layout_config = { prompt_position = "bottom" }
    },
    extensions = {
      ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
    }
  })
  require("telescope").load_extension("live_grep_args")
  require('toggle_lsp_diagnostics').init()
  require("telescope").load_extension("ui-select")
  require('telescope').load_extension('ctags_plus')
  require("lightspeed").setup({})
  require("fidget").setup({})
  -- require("lsphelpers").setup()
  require("mylsp").setup()
  require("snippets").setup()
  require('refactoring').setup({})
  require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
  require("nvim-autopairs").setup({})
  require('gitsigns').setup()
  require('dapui').setup()
  require('zen-mode').setup({})
  require('numb').setup()
  require('nvim-ts-autotag').setup({
    autotag = {
      enable = true,
    }
  })
  require('ufo').setup()

  -- other files, add more mappings
  require('other-nvim').setup({
    rememberBuffers = false,
    mappings = {
      {
        pattern = "test/(.*)_test.dart",
        target = "lib/%1.dart",
        context = "source"
      },
      {
        pattern = "lib/(.*).dart",
        target = "test/%1_test.dart",
        context = "test"
      },
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
        pattern = "./(.*)/(.*).py$",
        target = "tests/%1/test_%2.py",
        context = "test"
      },
      {
        pattern = "tests/(.*)/test_(.*).py",
        target = "src/%1/%2.py",
        context = "source"
      },
      {
        pattern = "tests/(.*)/test_(.*).py",
        target = "%1/%2.py",
        context = "source"
      },
      {
        pattern = "app/(.*).rb",
        target = "spec/%1_spec.rb",
        context = "test"
      },
      {
        pattern = "src/(.*).cr",
        target = "spec/%1_spec.cr",
        context = "test"
      },
      {
        pattern = "lib/(.*).ex",
        target = "test/%1_test.exs",
        context = "test"
      },
      {
        pattern = "test/(.*)_test.exs",
        target = "lib/%1.ex",
        context = "source"
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
        pattern = "spec/(.*)_spec.cr",
        target = "src/%1.cr",
        context = "source"
      },
      {
        pattern = "sig/rbs_rails/app/(.*).rbs",
        target = "app/%1.rb",
        context = "source"
      },
      {
        pattern = "sig/rbs_rails/app/(.*).rbs",
        target = "spec/%1_spec.rb",
        context = "test"
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
      { name = 'conjure' },
      { name = 'buffer' },
    })
  })
end

return M
