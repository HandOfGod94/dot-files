local M = {}

M.setup = function()
  local wk = require("which-key")
  wk.register({
    z             = {
      R = { "<cmd>lua require('ufo').openAllFolds()<cr>", "Open all folds using ufo" },
      M = { "<cmd>lua require('ufo').closeAllFolds()<cr>", "Open all folds using ufo" },
    },
    ["<C-h>"]     = { "zh", "Scroll left" },
    ["<C-l>"]     = { "zl", "Scroll right" },
    H             = { "<cmd>noh<cr>", "Remove highlights" },
    ["<C-p>"]     = { "<cmd>Telescope find_files hidden=true shorten_path=true<CR>", "Find files" },
    ["<SPACE>t"]  = { "<cmd>b#<CR>", "Toggle previous/current buffer" },
    ["<SPACE>T"]  = { "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true })<cr>", "Recent buffers" },
    ["<SPACE>'"]  = { "<cmd>split | term<CR>", "Open terminal" },
    ["<SPACE>d"]  = {
      name = "+dispatch",
      m = { "<cmd>Dispatch make<cr>", "make" },
    },
    ["<SPACE>p"]  = {
      name = "+Plugins",
      i    = { "<cmd>PackerInstall<cr>", "Install plugins" },
      u    = { "<cmd>PackerUpdate<cr>", "Update plugins" },
      s    = { "<cmd>PackerStatus<cr>", "Status" },
      c    = { "<cmd>PackerClean<cr>", "Clean plugins" }
    },
    ["<SPACE>c"]  = {
      name = "+Copilot",
      e = { "<cmd> Copilot enable<cr>", "Enable Copilot" },
      d = { "<cmd> Copilot disable<cr>", "Disable Copilot" },
      c = { "<cmd> CopilotChatToggle<cr>", "Toggle copilot chat" }
    },
    ["<SPACE>?"]  = {
      "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>",
      "search current word in all files",
      mode = { "n" }
    },
    ["<SPACE>/"]  = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "search in current buffer" },
    ["<SPACE>q"]  = {
      name = "+Quickfix",
      o = { "<cmd>copen<cr>", "Open quickfix list" },
      c = { "<cmd>ccl<cr>", "close quickfix list" },
      n = { "<cmd>cnext<cr>", "jump to next item in quickfix list" },
      p = { "<cmd>cp<cr>", "jump to prev item in quickfix list" },
    },
    ["<SPACE>g"]  = {
      name = "+Git",
      s    = { "<cmd>Git<cr>", "git status" },
      D    = { "<cmd>Git difftool<cr>", "git diff" },
      b    = { "<cmd>Git blame<cr>", "git blame" },
      p    = { "<cmd>Git push<cr>", "git push" },
      h    = { "<cmd>DiffviewFileHistory %<cr>", "git history current file" },
    },
    q             = { "<cmd>Bwipeout<cr>", "Close current buffer" },
    ["<SPACE>b"]  = {
      name = "+Buffers",
      l = { "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true })<cr>", "List all buffers" },
      d = { "<cmd>%bd|e#|bd#<CR>", "Close other buffers" },
      r = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Reopen last telescope view" },
    },
    ["<SPACE>F"]  = {
      name = "+Floating terminal",
      k = { "<cmd>FloatermKill<cr>", "kill floating terminal" },
      h = { "<cmd>FloatermHide<cr>", "hide floating terminal" },
      s = { "<cmd>FloatermShow<cr>", "show floating terminal" },
      n = { "<cmd>FloatermNext<cr>", "view next floating terminal" },
      p = { "<cmd>FloatermNext<cr>", "view previous floating terminal" },
      f = { "<cmd>FloatermFirst<cr>", "view first floating terminal" },
      l = { "<cmd>FloatermLast<cr>", "view last floating terminal" },
      t = { "<cmd>FloatermToggle<cr>", "toggle view floating terminal" },
    },
    ["<SPACE>f"]  = {
      name  = "+File ops",
      t     = { "<cmd>NvimTreeToggle<cr>", "Toggle file tree" },
      ["/"] = { "<cmd>NvimTreeFindFile<cr>", "Open current file in explorer" },
      f     = { "<cmd>Telescope find_files hidden=true shorten_path=true<cr>", "Open file" },
      F     = { "<cmd>Telescope find_files hidden=true shorten_path=true no_ignore=true<cr>",
        "Open file(s) including ignored" },
      g     = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "Search in file" },
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
    ["<SPACE>s"]  = { "<cmd>set spell! spell?<CR>", "Toggle spell checks" },
    ["<SPACE>\\"] = { "<cmd>BufferLinePick<cr>", "switch buffer" },
    ["<SPACE>G"]  = {
      name = "+Github",
      p = {
        name = "+PR",
        l = { "<cmd>Octo pr list<CR>", "List PRs" },
        b = { "<cmd>Octo pr browser<CR>", "Open PR in browser" },
        c = { "<cmd>Octo pr checkout<CR>", "Checkout PR" },
        r = { "<cmd>Octo pr ready<CR>", "Mark a draft PR as ready for review" },
      }
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

  -- visual mode mapping
  wk.register({
    ["<SPACE>?"] = {
      "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<cr>",
      "search selection in all files",
      mode = { "v" }
    },
  })
end

M.lspkeys = {
  ["<C-s>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "display signature help", mode = { "i", "n" } },
  ["<SPACE>P"] = {
    name = "+Peek",
    d = { "<cmd>Glance definitions<CR>", "peek definition" },
    i = { "<cmd>Glance implementations<CR>", "peek implementation" },
    r = { "<Cmd>Glance references<CR>", "peek all references" },
  },
  g = {
    name = "+Goto",
    D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "Goto definition" },
    i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "Goto implementation" },
    r = { "<Cmd>lua require('telescope.builtin').lsp_references()<CR>", "Find all references" },
  },
  ["<M-o>"] = { "<cmd>lua require('dap').step_over()<cr>", "debug: step over" },
  ["<M-i>"] = { "<cmd>lua require('dap').step_into()<cr>", "debug: step into" },
  ["<SPACE>l"] = {
    name = "+Language",
    l = { "<cmd>filetype detect<cr>", "reload language-lsp config" },
    h = { "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })<cr>",
      "Toggle inlay hints" },
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
    ["="] = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format code", mode = { "v", "n" } }
  },
}

return M
