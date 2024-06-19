local M = {}
local home = os.getenv('HOME')


-- TODO: figure out a better place for this
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

require('dap-python').setup('debugpy')
require('dap-go').setup()
vim.cmd([[autocmd BufWritePre *.go lua OrgImports(1000)]])

----------------------------------------------------------
-- Autoset docker-compose.yml file type
local group = vim.api.nvim_create_augroup("filetypedetect", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
  group = group,
})
-----------------------------------------------------------


local default_on_attach = function(_, _)
  local wk = require('which-key')
  wk.register(require('mykeybindings').lspkeys)
end

local default_capabilities =
    require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lua external libs
local libraries = vim.api.nvim_get_runtime_file("", true)
vim.list_extend(libraries,
  vim.split(vim.fn.glob("/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/*.lua"), "\n"))
vim.list_extend(libraries, { home .. "/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations" })

local default_config = {
  lua_ls = {
    on_attach = default_on_attach,
    capabilities = default_capabilities,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', },
        diagnostics = { globals = { 'vim', 'use', 'hs', 'spoon' } },
        workspace = { library = libraries, checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  },
  pylsp = {
    on_attach = default_on_attach,
    capabilities = default_capabilities,
    settings = {
      pylsp = {
        plugins = {
          black = { enabled = true, line_length = 120 },
          pyflakes = { enabled = true }
        }
      }
    }
  },
  denols = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  tsserver = {
    on_attach = default_on_attach,
    capabilities = default_capabilities,
    root_dir = require('lspconfig.util').root_pattern("tsconfig.json", "package.json"),
    single_file_support = false

  },
  jsonls = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  clojure_lsp = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  gopls = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  -- ["rust-tools"] = {
  --   server = {
  --     on_attach = default_on_attach,
  --     capabilities = default_capabilities
  --   }
  -- },
  volar = {
    filetypes = { 'vue' },
  },
  svelte = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  solargraph = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  elixirls = {
    cmd = { home .. "/.config/nvim/elixir/lang-server/language_server.sh" },
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  html = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  emmet_ls = {
    on_attach = default_on_attach,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'heex' },
  },
  terraformls = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  crystalline = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  docker_compose_language_service = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  dartls = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  ocamllsp = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  },
  docker_compose_language_service = {
    on_attach = default_on_attach,
    capabilities = default_capabilities
  }
}

function M.setup(options)
  -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  options = options or {}
  local lsp_options = vim.tbl_deep_extend("force", default_config, options)
  for language, setup_values in pairs(lsp_options) do
    require("lspconfig")[language].setup(setup_values)
  end
end

return M
