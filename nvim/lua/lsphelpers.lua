local M = {}
local home = os.getenv('HOME')

local on_attach = function(client, bufnr)
  local wk = require('which-key')
  wk.register(require('mykeybindings').lspkeys)
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
  local libraries = vim.api.nvim_get_runtime_file("", true)
  vim.list_extend(libraries, vim.split(vim.fn.glob("/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/*.lua"), "\n"))
  vim.list_extend(libraries, {home .. "/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations"})
  require('lspconfig')['lua_ls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', },
        diagnostics = { globals = { 'vim', 'use', 'hs', 'spoon' } },
        workspace = { library =  libraries },
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
    capabilities = capabilities,
  }
  -- require'lspconfig'.standardrb.setup{
  --   on_attach = on_attach,
  --   capabilities = capabilities
  -- }

  -- elixir lsp
  -- curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/download/v0.13.0/elixir-ls-1.14-25.1.zip
  require('lspconfig').elixirls.setup({
    cmd = { home .. "/.config/nvim/elixir/lang-server/language_server.sh" },
    on_attach = on_attach
  })

  require 'lspconfig'.emmet_ls.setup {
    on_attach = on_attach,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'heex' },
  }

  require 'lspconfig'.terraformls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

return M
