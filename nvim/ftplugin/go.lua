local wk = require("which-key")
wk.register({
  ["<SPACE>j"] = {
    name = "+Format",
    ["="] = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format go code" }
  },
  ["<SPACE>l"] = {
    d = {
      name = "+Debug",
      t    = { "<cmd>lua require('dap-go').debug_test()<cr>", "debug test" }
    }
  }
})
