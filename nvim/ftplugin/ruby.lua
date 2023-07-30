vim.g.gutentags_enabled = 1
vim.g.gutentags_ctags_executable_ruby = '/opt/homebrew/Cellar/ctags/5.8_2/bin/ctags'
vim.g.gutentags_ctags_extra_args = {
  '--append',
  '-R',
  '--exclude=.git',
  '--exclude=log',
  '--exclude=tmp',
  '--exclude=coverage',
}

vim.cmd([[
  set iskeyword+=?
  set iskeyword+=!
  set iskeyword+=:
]])
