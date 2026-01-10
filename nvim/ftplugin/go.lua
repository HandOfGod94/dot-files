local wk = require("which-key")
wk.add({
  { "<SPACE>j=", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", desc = "Format go code" },
  { "<SPACE>ldt", "<cmd>lua require('dap-go').debug_test()<cr>", desc = "debug test" }
})
