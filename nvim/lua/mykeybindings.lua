local M = {}

M.setup = function()
  local wk = require("which-key")
  wk.register({
    z = {
      R = {"<cmd>lua require('ufo').openAllFolds()<cr>", "Open all folds using ufo"},
      M = {"<cmd>lua require('ufo').closeAllFolds()<cr>", "Open all folds using ufo"},
    },
    ["<C-h>"]     = { "zh", "Scroll left" },
    ["<C-l>"]     = { "zl", "Scroll right" },
    ["<C-t>"]     = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Last telescope view"},
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
      b    = { "<cmd>Git blame<cr>", "git blame" },
      p    = { "<cmd>Git push<cr>", "git push" }
    },
    q             = { "<cmd>bd<cr>", "Close current buffer" },
    ["<SPACE>b"]  = {
      name = "+Buffers",
      l = { "<cmd>Telescope buffers<cr>", "List all buffers" },
      d = { "<cmd>%bd|e#|bd#<CR>", "Close other buffers" },
    },
    ["<SPACE>F"]  = { k = { "<cmd>FloatermKill<cr>", "kill floating terminal" } },
    ["<SPACE>f"]  = {
      name  = "+File ops",
      t     = { "<cmd>NvimTreeToggle<cr>", "Toggle file tree" },
      ["/"] = { "<cmd>NvimTreeFindFile<cr>", "Open current file in explorer" },
      f     = { "<cmd>Telescope find_files hidden=true shorten_path=true<cr>", "Open file" },
      g     = { "<cmd>Telescope live_grep<cr>", "Search in file" },
      h     = { "<cmd>Telescope help_tags<cr>", "Telescope help" }
    },
    ["<SPACE>S"]  = {
      name = "+Stack",
      r = {
        "<cmd>Dispatch docker-compose stop && docker-compose rm -f -v && docker volume prune -f && docker-compose up -d<CR>",
        "Reset docker stack" },
      s = { "<cmd>Dispatch docker-compose up -d<CR>", "start docker stack" },
      S = { "<cmd>Dispatch docker-compose stop && docker-compose rm -f -v && docker volume prune -f<CR>",
        "stopc docker stack" }
    },
    ["<SPACE>s"] = { "<cmd>set spell! spell?<CR>" , "Toggle spell checks"},
    ["<SPACE>\\"] = { "<cmd>BufferLinePick<cr>", "switch buffer" },
    ["<SPACE>T"]  = {
      name = "+Theme",
      l    = { "<cmd>lua require('material.functions').change_style('light')<cr>", "Switch to lighter theme" },
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
    }
  })
end

M.lspkeys = {
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
    I = { "<cmd>Dash<CR>", "View dash docs" },
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

return M
