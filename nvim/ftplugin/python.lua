-- add django config
local dap = require('dap')
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'Django',
  program = vim.fn.getcwd() .. '/manage.py',
  args = { 'runserver', '--noreload' },
  django = true,
  justMyCode = true
})

local wk = require('which-key')
wk.add(require("mykeybindings").lspkeys)
wk.add({
  { "<SPACE>ldT", "<cmd>lua require('dap-python').test_class()<cr>", desc = "debug current test class" },
  { "<SPACE>ldt", "<cmd>lua require('dap-python').test_method()<cr>", desc = "debug current test method" },
  { "<SPACE>ldd", "<cmd>lua require'dap'.configurations.python[1].request = 'launch'; require'dap'.continue()<cr>", desc = "Launch Django debug" },
})
