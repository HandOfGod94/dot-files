vim.g.gutentags_enabled = 1
vim.g.gutentags_ctags_executable_ruby = 'ctags'
vim.g.gutentags_ctags_extra_args = {
  '--append',
  '-R',
  '--exclude=.git',
  '--exclude=log',
  '--exclude=tmp',
  '--exclude=coverage',
  '--exclude=*_spec.rb',
}

vim.cmd([[
  set iskeyword+=?
  set iskeyword+=!
  set iskeyword+=:
]])

local lspkeys = require("mykeybindings").lspkeys
lspkeys = vim.tbl_deep_extend("keep", lspkeys, {
  g = { name = "+Goto" },
  ["g]"] = { "<cmd>lua require('mytelescope_extensions').custom_tag_jump()<CR>", "jump to tag", mode = { "n", "v" } }
})

local wk = require('which-key')
wk.register(lspkeys)
