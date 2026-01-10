local M = {}

M.setup = function()
  local wk = require("which-key")
  wk.add({
    -- Fold operations
    { "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open all folds using ufo" },
    { "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Open all folds using ufo" },

    -- Scroll
    { "<C-h>", "zh", desc = "Scroll left" },
    { "<C-l>", "zl", desc = "Scroll right" },

    -- Misc
    { "H", "<cmd>noh<cr>", desc = "Remove highlights" },
    { "<C-p>", "<cmd>Telescope find_files hidden=true shorten_path=true<CR>", desc = "Find files" },
    { "q", "<cmd>Bwipeout<cr>", desc = "Close current buffer" },

    -- Space prefix mappings
    { "<SPACE>t", "<cmd>b#<CR>", desc = "Toggle previous/current buffer" },
    { "<SPACE>T", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true })<cr>", desc = "Recent buffers" },
    { "<SPACE>'", "<cmd>split | term<CR>", desc = "Open terminal" },
    { "<SPACE>?", "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>", desc = "search current word in all files", mode = "n" },
    { "<SPACE>?", "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<cr>", desc = "search selection in all files", mode = "v" },
    { "<SPACE>/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", desc = "search in current buffer" },
    { "<SPACE>s", "<cmd>set spell! spell?<CR>", desc = "Toggle spell checks" },
    { "<SPACE>\\", "<cmd>BufferLinePick<cr>", desc = "switch buffer" },
    { "<SPACE>z", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" },

    -- Dispatch
    { "<SPACE>d", group = "dispatch" },
    { "<SPACE>dm", "<cmd>Dispatch make<cr>", desc = "make" },

    -- Plugins
    { "<SPACE>p", group = "Plugins" },
    { "<SPACE>pi", "<cmd>PackerInstall<cr>", desc = "Install plugins" },
    { "<SPACE>pu", "<cmd>PackerUpdate<cr>", desc = "Update plugins" },
    { "<SPACE>ps", "<cmd>PackerStatus<cr>", desc = "Status" },
    { "<SPACE>pc", "<cmd>PackerClean<cr>", desc = "Clean plugins" },

    -- Quickfix
    { "<SPACE>q", group = "Quickfix" },
    { "<SPACE>qo", "<cmd>copen<cr>", desc = "Open quickfix list" },
    { "<SPACE>qc", "<cmd>ccl<cr>", desc = "close quickfix list" },
    { "<SPACE>qn", "<cmd>cnext<cr>", desc = "jump to next item in quickfix list" },
    { "<SPACE>qp", "<cmd>cp<cr>", desc = "jump to prev item in quickfix list" },

    -- Git
    { "<SPACE>g", group = "Git" },
    { "<SPACE>gs", "<cmd>Git<cr>", desc = "git status" },
    { "<SPACE>gD", "<cmd>Git difftool<cr>", desc = "git diff" },
    { "<SPACE>gb", "<cmd>Git blame<cr>", desc = "git blame" },
    { "<SPACE>gp", "<cmd>Git push<cr>", desc = "git push" },
    { "<SPACE>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "git history current file" },

    -- Buffers
    { "<SPACE>b", group = "Buffers" },
    { "<SPACE>bl", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true })<cr>", desc = "List all buffers" },
    { "<SPACE>bd", "<cmd>%bd|e#|bd#<CR>", desc = "Close other buffers" },
    { "<SPACE>br", "<cmd>lua require('telescope.builtin').resume()<cr>", desc = "Reopen last telescope view" },

    -- Floating terminal
    { "<SPACE>F", group = "Floating terminal" },
    { "<SPACE>Fk", "<cmd>FloatermKill<cr>", desc = "kill floating terminal" },
    { "<SPACE>Fh", "<cmd>FloatermHide<cr>", desc = "hide floating terminal" },
    { "<SPACE>Fs", "<cmd>FloatermShow<cr>", desc = "show floating terminal" },
    { "<SPACE>Fn", "<cmd>FloatermNext<cr>", desc = "view next floating terminal" },
    { "<SPACE>Fp", "<cmd>FloatermNext<cr>", desc = "view previous floating terminal" },
    { "<SPACE>Ff", "<cmd>FloatermFirst<cr>", desc = "view first floating terminal" },
    { "<SPACE>Fl", "<cmd>FloatermLast<cr>", desc = "view last floating terminal" },
    { "<SPACE>Ft", "<cmd>FloatermToggle<cr>", desc = "toggle view floating terminal" },

    -- File ops
    { "<SPACE>f", group = "File ops" },
    { "<SPACE>ft", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    { "<SPACE>f/", "<cmd>NvimTreeFindFile<cr>", desc = "Open current file in explorer" },
    { "<SPACE>ff", "<cmd>Telescope find_files hidden=true shorten_path=true<cr>", desc = "Open file" },
    { "<SPACE>fF", "<cmd>Telescope find_files hidden=true shorten_path=true no_ignore=true<cr>", desc = "Open file(s) including ignored" },
    { "<SPACE>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = "Search in file" },
    { "<SPACE>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help" },

    -- Stack
    { "<SPACE>S", group = "Stack" },
    { "<SPACE>Sr", "<cmd>Dispatch docker-compose stop && docker-compose rm -f -v && docker volume prune -f && docker-compose up -d<CR>", desc = "Reset docker stack" },
    { "<SPACE>Ss", "<cmd>Dispatch docker-compose up -d<CR>", desc = "start docker stack" },
    { "<SPACE>SS", "<cmd>Dispatch docker-compose stop && docker-compose rm -f -v && docker volume prune -f<CR>", desc = "stopc docker stack" },

    -- Github
    { "<SPACE>G", group = "Github" },
    { "<SPACE>Gp", group = "PR" },
    { "<SPACE>Gpl", "<cmd>Octo pr list<CR>", desc = "List PRs" },
    { "<SPACE>Gpb", "<cmd>Octo pr browser<CR>", desc = "Open PR in browser" },
    { "<SPACE>Gpc", "<cmd>Octo pr checkout<CR>", desc = "Checkout PR" },
    { "<SPACE>Gpr", "<cmd>Octo pr ready<CR>", desc = "Mark a draft PR as ready for review" },

    -- AI
    {"<SPACE>a", group = "AI Avante"},
    {"<SPACE>at", "<cmd>AvanteAsk<CR>", desc = "Avante ask"},
    {"<SPACE>at", "<cmd>AvanteToggle<CR>", desc = "Toggle AI chat"},
    {"<SPACE>at", "<cmd>AvanteToggle<CR>", desc = "Toggle AI chat"},
    {"<SPACE>ac", "<cmd>AvanteClear<CR>", desc = "Clear current chat"},
    {"<SPACE>an", "<cmd>AvanteChatNew<CR>", desc = "Start new chat"},

    -- Alternate files
    { "<SPACE>A", group = "Alternate files" },
    { "<SPACE>At", "<cmd>Other<cr>", desc = "Toggle between related files" },
    { "<SPACE>Av", "<cmd>OtherVSplit<cr>", desc = "Vertical split related file" },
    { "<SPACE>Ah", "<cmd>OtherSplit<cr>", desc = "Horizontal split related file" },

    -- Language (placeholder group)
    { "<SPACE>l", group = "Language" },

    -- Run/Tests
    { "<SPACE>r", group = "Run" },
    { "<SPACE>rt", group = "Tests" },
    { "<SPACE>rts", "<cmd>TestSuite<cr>", desc = "run test suite" },
    { "<SPACE>rtf", "<cmd>TestFile<cr>", desc = "run test file" },
    { "<SPACE>rtt", "<cmd>TestNearest<cr>", desc = "run current test" },
    { "<SPACE>rtl", "<cmd>TestLast<cr>", desc = "rerun latest test" },
    { "<SPACE>rtv", "<cmd>TestVisit<cr>", desc = "visit last run test" },
  })
end

M.lspkeys = {
  -- Signature help
  { "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "display signature help", mode = { "i", "n" } },

  -- Peek
  { "<SPACE>P", group = "Peek" },
  { "<SPACE>Pd", "<cmd>Glance definitions<CR>", desc = "peek definition" },
  { "<SPACE>Pi", "<cmd>Glance implementations<CR>", desc = "peek implementation" },
  { "<SPACE>Pr", "<Cmd>Glance references<CR>", desc = "peek all references" },

  -- Goto
  { "g", group = "Goto" },
  { "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Goto declaration" },
  { "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", desc = "Goto definition" },
  { "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", desc = "Goto implementation" },
  { "gr", "<Cmd>lua require('telescope.builtin').lsp_references()<CR>", desc = "Find all references" },

  -- Debug step controls
  { "<M-o>", "<cmd>lua require('dap').step_over()<cr>", desc = "debug: step over" },
  { "<M-i>", "<cmd>lua require('dap').step_into()<cr>", desc = "debug: step into" },

  -- Language
  { "<SPACE>l", group = "Language" },
  { "<SPACE>ll", "<cmd>filetype detect<cr>", desc = "reload language-lsp config" },
  { "<SPACE>lh", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })<cr>", desc = "Toggle inlay hints" },
  { "<SPACE>li", "<Cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover info" },
  { "<SPACE>lI", "<cmd>Dash<CR>", desc = "View dash docs" },
  { "<SPACE>le", "<Cmd>ToggleDiag<CR>", desc = "Toggle diagnostics" },
  { "<SPACE>lE", "<Cmd>lua require('telescope.builtin').diagnostics()<CR>", desc = "Toggle diagnostics list" },
  { "<SPACE>ls", "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", desc = "Lists all the symbols in current buffer" },
  { "<SPACE>lS", "<Cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", desc = "Lists all the symbols in workspace" },
  { "<SPACE>lq", "<Cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Quick code actions" },

  -- Debug
  { "<SPACE>ld", group = "Debug" },
  { "<SPACE>ldb", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
  { "<SPACE>ldr", "<cmd>lua require('dap').repl.open()<cr>", desc = "launch debug REPL" },
  { "<SPACE>ldc", "<cmd>lua require('dap').continue()<cr>", desc = "continue" },
  { "<SPACE>ldU", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle debug UI" },
  { "<SPACE>ldO", "<cmd>lua require('dapui').open()<cr>", desc = "Open debug UI" },
  { "<SPACE>ldC", "<cmd>lua require('dapui').close()<cr>", desc = "Close debug UI" },

  -- Refactor
  { "<SPACE>lr", group = "Refactor" },
  { "<SPACE>lrr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "rename" },
  { "<SPACE>lrf", "<cmd>lua require('refactoring').refactor('Extract Function')<CR>", desc = "extract function", mode = "v" },
  { "<SPACE>lrv", "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", desc = "extract variable", mode = "v" },
  { "<SPACE>lri", "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", desc = "inline variable", mode = "v" },
  { "<SPACE>lrb", "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", desc = "extract block", mode = "n" },

  -- Format
  { "<SPACE>j", group = "Format" },
  { "<SPACE>j=", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", desc = "Format code", mode = { "v", "n" } },
}

return M
