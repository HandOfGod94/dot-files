local lspkeys = require("mykeybindings").lspkeys
lspkeys = vim.tbl_deep_extend("keep", lspkeys, {
  ["<SPACE>l"] = {
    d = {
      T = { "<cmd>lua require('dap-python').test_class()<cr>", "debug current test class" },
      t = { "<cmd>lua require('dap-python').test_method()<cr>", "debug current test method" },
    }
  }
})

local wk = require('which-key')
wk.register(lspkeys)
