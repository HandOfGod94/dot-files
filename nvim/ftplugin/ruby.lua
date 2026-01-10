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
  '--exclude=fixtures',
  '--exclude=*.json',
  '--exclude=*.html',
}

vim.cmd([[
  set iskeyword+=?
  set iskeyword+=!
  set iskeyword+=:
]])

local wk = require('which-key')
wk.add(require("mykeybindings").lspkeys)
wk.add({
  { "g]", "<cmd>lua require('mytelescope_extensions').custom_tag_jump()<CR>", desc = "jump to tag", mode = { "n", "v" } }
})
