local wk = require("which-key")
wk.register({
  ["<SPACE>j"] = {
    name = "+Format",
    ["="] = {"<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format go code"}
  },
})

