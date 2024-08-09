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

require('dap-python').setup('python')
require('dap-go').setup()
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🟡', texthl = '', linehl = '', numhl = '' })
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

-- vim.api.nvim_create_autocmd({ "BufEnter","CursorHold","InsertLeave"}, {
--   callback = function()
--     vim.lsp.codelens.refresh({ bufnr = 0 })

--     local lenses = vim.lsp.codelens.get(0)
--     vim.lsp.codelens.display(lenses, 0, nil)
--   end
-- })
-----------------------------------------------------------

local on_attach = function(opts)
  opts = opts or {}

  return function(client, bufnr)
    local wk = require('which-key')
    wk.register(require('mykeybindings').lspkeys)

    if opts.inlay_hint and opts.inlay_hint == true then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end
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
    on_attach = on_attach(),
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
    on_attach = on_attach(),
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
    on_attach = on_attach(),
    capabilities = default_capabilities,
    root_dir = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
  },
  tsserver = {
    on_attach = on_attach({ inlay_hint = true }),
    capabilities = default_capabilities,
    root_dir = require('lspconfig.util').root_pattern("tsconfig.json", "package.json"),
    single_file_support = false,
    commands = {
      OrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = ""
          })
        end,
        description = "orgranize imports"
      }
    },
    init_options = {
      preferences = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        importModuleSpecifierPreference = 'non-relative',
      },
    },
  },
  jsonls = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  clojure_lsp = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  gopls = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  cucumber_language_server = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  rust_analyzer = {
    on_attach = on_attach({ inlay_hint = true }),
    capabilities = default_capabilities
  },
  volar = {
    filetypes = { 'vue' },
  },
  svelte = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  solargraph = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  elixirls = {
    cmd = { home .. "/.config/nvim/elixir/lang-server/language_server.sh" },
    on_attach = on_attach(),
    capabilities = default_capabilities,
    init_options = {
      elixirLS = {
        dialyzerEnabled = true,
        fetchDeps = true,
        suggestSpecs = true
      }
    }
  },
  html = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  emmet_ls = {
    on_attach = on_attach(),
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'heex' },
  },
  terraformls = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  crystalline = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  docker_compose_language_service = {
    on_attach = on_attach(),
    capabilities = default_capabilities
  },
  ocamllsp = {
    on_attach = on_attach(),
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

  require("flutter-tools").setup({
    lsp = {
      color = {
        enabled = true
      },
      on_attach = on_attach({ inlay_hint = false }),
      capabilities = default_capabilities,
    }
  })
end

return M
