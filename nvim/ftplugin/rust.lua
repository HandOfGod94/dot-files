local wk = require("which-key")
wk.add({
  { "<SPACE>j=", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", desc = "Format rust code" },
})

