local M = {}

M.keys = {
  ["<C-s>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "display signature help", mode = { "i", "n" } },
  g = {
    name = "+Goto",
    D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "Goto definition" },
    i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "Goto implementation" },
    r = { "<Cmd>lua require('telescope.builtin').lsp_references()<CR>", "Find all references" }
  },
  ["<M-o>"] = { "<cmd>lua require('dap').step_over()<cr>", "debug: step over" },
  ["<M-i>"] = { "<cmd>lua require('dap').step_into()<cr>", "debug: step into" },
  ["<SPACE>l"] = {
    name = "+Language",
    l = { "<cmd>filetype detect<cr>", "reload language-lsp config" },
    i = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover info" },
    I = { "<cmd>Dash<CR>", "View dash docs"},
    e = { "<Cmd>ToggleDiag<CR>", "Toggle diagnostics" },
    E = { "<Cmd>lua require('telescope.builtin').diagnostics()<CR>", "Toggle diagnostics list" },
    s = { "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Lists all the symbols in current buffer" },
    S = { "<Cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>",
      "Lists all the symbols in workspace" },
    d = {
      name = "+Debug",
      b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
      r = { "<cmd>lua require('dap').repl.open()<cr>", "launch debug REPL" },
      c = { "<cmd>lua require('dap').continue()<cr>", "continue" },
      U = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle debug UI" },
      O = { "<cmd>lua require('dapui').open()<cr>", "Open debug UI" },
      C = { "<cmd>lua require('dapui').close()<cr>", "Close debug UI" },
      -- move this to language specific file
      -- t = { "<cmd>lua require('dap-go').debug_test()<cr>", "debug test" }
      -- t = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "debug junit test" }
    },
    r = {
      name = "+Refactor",
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
      f = { "<cmd>lua require('refactoring').refactor('Extract Function')<CR>", "extract function", mode = "v" },
      v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "extract variable", mode = "v" },
      i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "inline variable", mode = "v" },
      b = { "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", "extract block", mode = "n" }
    },
    q = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Quick code actions" }
  },
  -- todo: move this to lang specific files
  ["<SPACE>j"] = {
    name = "+Format",
    ["="] = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format code" }
  },
}


local on_attach = function(client, bufnr)
  local wk = require('which-key')
  wk.register(M.keys)
end

function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

function M.setup()

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  -- lua server
  require('lspconfig')['lua_ls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', },
        diagnostics = { globals = { 'vim', 'use', 'hs', 'spoon' } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      },
    },
  }

  -- python server
  require('lspconfig').pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          black = { enabled = true, line_length = 120 }
        }
      }
    }
  })
  require('dap-python').setup('debugpy')

  -- javascript server
  require('lspconfig').tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

  -- json server
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  require('lspconfig').jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

  -- clojure server
  require('lspconfig').clojure_lsp.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

  -- golang server
  require('lspconfig').gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })
  require('dap-go').setup()
  -- allow autoimports in golang
  vim.cmd([[autocmd BufWritePre *.go lua OrgImports(1000)]])

  -- rust analyzer
  require('rust-tools').setup({
    server = {
      on_attach = on_attach,
      capabilities = capabilities
    },
    tools = {
      inlay_hints = { auto = true }
    }
  })

  -- vue volar
  require 'lspconfig'.volar.setup {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    init_options = {
      typescript = {
        tsdk = "/usr/local/lib/node_modules/typescript/lib"
      }
    }
  }

  -- svelte
  require 'lspconfig'.svelte.setup {
    on_attach = on_attach
  }

  -- ruby
  require 'lspconfig'.solargraph.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

  -- elixir lsp
  -- curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/download/v0.13.0/elixir-ls-1.14-25.1.zip
  require('lspconfig').elixirls.setup({
    cmd = { os.getenv('HOME') .. "/.config/nvim/elixir/lang-server/language_server.sh" },
    on_attach = on_attach
  })

  require 'lspconfig'.emmet_ls.setup {
    on_attach = on_attach,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'heex' },
  }
end

return M
