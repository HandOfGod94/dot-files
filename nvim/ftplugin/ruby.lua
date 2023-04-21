vim.g.gutentags_enabled = 1
vim.g.gutentags_ctags_executable_ruby = 'ripper-tags'
vim.g.gutentags_ctags_extra_args = { '--ignore-unsupported-options', '--recursive' }

vim.cmd([[
  set iskeyword+=?
  set iskeyword+=!
]])

local lspkeys = require('lsphelpers').keys
lspkeys = vim.tbl_deep_extend("keep", lspkeys, {
  g = {
    name = "+Search",
    R = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Search current word reference" }
  },
})

local wk = require('which-key')
wk.register(lspkeys)
