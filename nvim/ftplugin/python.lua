local lspkeys = require("mykeybindings").lspkeys

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

lspkeys = vim.tbl_deep_extend("keep", lspkeys, {
  ["<SPACE>l"] = {
    d = {
      T = { "<cmd>lua require('dap-python').test_class()<cr>", "debug current test class" },
      t = { "<cmd>lua require('dap-python').test_method()<cr>", "debug current test method" },
      d = {
      "<cmd>lua require'dap'.configurations.python[1].request = 'launch'; require'dap'.continue()<cr>",
      "Launch Django debug"
    },
    }
  }
})

local wk = require('which-key')
wk.register(lspkeys)
