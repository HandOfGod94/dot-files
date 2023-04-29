local home = os.getenv('HOME')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.config/nvim/java/workspace/' .. project_name

-- TODO: Figure out a way to load this as part of lsp helpers
local on_attach = function(client, _)
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  require('jdtls.setup').add_commands()
  local lspkeys = require("mykeybindings").lspkeys
  lspkeys = vim.tbl_deep_extend("keep", lspkeys, {
    ["<SPACE>l"] = {
      d = {
        T = { "<cmd>lua require('jdtls').test_class()<cr>", "debug junit class" },
        t = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "debug junit test" }
      }
    }
  })

  local wk = require('which-key')
  wk.register(lspkeys)
end


local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
-- change it to false, post $/progress handler is fixed in jdtls, to use fidget
extendedClientCapabilities.progressReportProvider = false
local capabilities = {
  workspace = {
    configuration = true
  },
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true
      }
    }
  }
}

-- install java lang server using
-- curl -O https://download.eclipse.org/jdtls/milestones/1.18.0/jdt-language-server-1.18.0-202212011657.tar.gz
local java_paths = {
  java8_path = vim.fn.globpath(home .. "/.sdkman/candidates/java", "8*-amzn"),
  java11_path = vim.fn.globpath(home .. "/.sdkman/candidates/java", "11*-amzn"),
  java17_path = vim.fn.globpath(home .. "/.sdkman/candidates/java", "17*-amzn"),
  java19_path = vim.fn.globpath(home .. "/.sdkman/candidates/java", "19*-amzn"),
}

local settings = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = 'fernflower' },
    configuration = {
      runtimes = {
        {
          name = "JavaSE-1.8",
          path = java_paths.java8_path,
        },
        {
          name = "JavaSE-11",
          path = java_paths.java11_path,
        },
        {
          name = "JavaSE-17",
          path = java_paths.java17_path
        }
      }
    },
    import = {
      gradle = {
        enabled = true,
        wrapper = { enabled = true },
        java = { home = java_paths.java8_path }
      }
    },
    imports = {
      gradle = {
        wrapper = {
          checksums = {
            {
              sha256 = "37c2fdce55411e4c89b896c292cae1f8f437862c8433c8a74cfc3805d7670c0a",
              allowed = true
            },
            {
              sha256 = "b9c6ce6acb570a4f75256749bfac4a08cddd384363acd0172ba2ece429555af1",
              allowed = true
            },
            {
              sha256 = "1b8a81984f2686cd5a3805df798cac9d553bd5d94e8728a5e68032e7893fb964",
              allowed = true
            },
            {
              sha256 = "993dcbc33c21949695f8ea02932950eed24875eb49572cbd7c8986de3a5f675a",
              allowed = true
            },
            {
              sha256 = "a5d79beb0bf201ec897659a44c1458885ec763ea879d7340c4a3246452664455",
              allowed = true
            },
            {
              sha256 = "4c8871189c7d38adc61f911be781c2f40a62daac54564d5801871ab9983a5265",
              allowed = true
            },
            {
              sha256 = "535a31f76ed710927244dfd422a749ab4b1c267b240f0e91ed8a28c7d5bb1ff2",
              allowed = true
            }
          }
        }
      }
    }
  }
}

local bundles = {
  -- vim.fn.glob(home .. '/.config/nvim/java/support-libs/*.jar')
  -- make it more dynamic (ideally glob list should expand)
  -- curl -fLo dg.jdt.ls.decompiler.common-0.0.3.jar https://github.com/dgileadi/vscode-java-decompiler/blob/master/server/dg.jdt.ls.decompiler.common-0.0.3.jar\?raw\=true
  vim.fn.globpath(home .. '/.config/nvim/java/support-libs', '*common*.jar'),
  -- curl -fLo dg.jdt.ls.decompiler.fernflower-0.0.3.jar https://github.com/dgileadi/vscode-java-decompiler/blob/master/server/dg.jdt.ls.decompiler.fernflower-0.0.3.jar\?raw\=true
  vim.fn.globpath(home .. '/.config/nvim/java/support-libs', '*fernflower*.jar'),
  -- curl -fLo com.microsoft.java.debug.plugin-0.41.0.jar https://repo1.maven.org/maven2/com/microsoft/java/com.microsoft.java.debug.plugin/0.41.0/com.microsoft.java.debug.plugin-0.41.0.jar
  vim.fn.globpath(home .. '/.config/nvim/java/support-libs', 'com.microsoft.java.debug.plugin*.jar'),
  -- curl -O https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar
  vim.fn.globpath(home .. '/.config/nvim/java/support-libs', 'junit-4.*.jar'),
  -- curl -O https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
  vim.fn.globpath(home .. '/.config/nvim/java/support-libs', 'hamcrest-core-*.jar')
}

-- git clone git@github.com:microsoft/vscode-java-test.git
-- cd vscode-java-test
-- npm install
-- npm run build-plugin
vim.list_extend(bundles,
  vim.split(vim.fn.glob(home .. '/.config/nvim/java/support-libs/vscode-java-test/server/*.jar'), "\n"))

local config = {
  on_attach = on_attach,
  extendedClientCapabilities = extendedClientCapabilities,
  capabilities = capabilities,
  flags = {
    allow_incremental_sync = true,
  },
  cmd = {
    java_paths.java17_path .. '/bin/java',
    -- '-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=127.0.0.1:8000',
    -- curl -O https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar
    '-javaagent:' .. vim.fn.globpath(home .. '/.config/nvim/java/support-libs', 'lombok-*.jar'),
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.checkConfiguration=true',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-noverify',
    '-Xms1G',
    -- '-Dlog.protocol=true',
    -- '-Dlog.level=ALL',
    -- '-Xms500m',
    '-XX:+UseParallelGC',
    '-XX:GCTimeRatio=4',
    '-XX:AdaptiveSizePolicyWeight=90',
    -- '-Dsun.zip.disableMemoryMapping=true',
    '--add-modules=ALL-SYSTEM',
    '--add-exports', 'java.base/java.net=ALL-UNNAMED',
    '--add-exports', 'java.base/java.util=ALL-UNNAMED',
    '--add-exports', 'java.base/java.lang=ALL-UNNAMED',
    '--add-exports', 'java.base/java.io=ALL-UNNAMED',
    '--add-exports', 'java.base/java.util.concurrent=ALL-UNNAMED',
    '--add-exports', 'java.base/sun.nio.fs=ALL-UNNAMED',

    '--add-opens', 'java.base/java.net=ALL-UNNAMED',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '--add-opens', 'java.base/java.io=ALL-UNNAMED',
    '--add-opens', 'java.base/java.util.concurrent=ALL-UNNAMED',
    '--add-opens', 'java.base/sun.nio.fs=ALL-UNNAMED',
    '-jar', home .. '/.config/nvim/java/lang-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', home .. '/.config/nvim/java/lang-server/config_mac',
    '-data', workspace_dir
  },
  root_dir = require('jdtls.setup').find_root({ 'mvnw', 'gradlew', 'build.gradle', 'pom.xml' }),
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles,
    settings = settings
  },
  settings = settings
}

config.on_init = function(client, _)
  client.notify('workspace/didChangeConfiguration', { settings = config.settings })
end

-- UI
local finders = require 'telescope.finders'
local sorters = require 'telescope.sorters'
local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'

require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
  local opts = {}
  pickers.new(opts, {
    prompt_title    = prompt,
    finder          = finders.new_table {
      results = items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = label_fn(entry),
          ordinal = label_fn(entry),
        }
      end,
    },
    sorter          = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.goto_file_selection_edit:replace(function()
        local selection = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)

        cb(selection.value)
      end)

      return true
    end,
  }):find()
end

require('jdtls').start_or_attach(config)
