local lspkeys = require("mykeybindings").lspkeys
lspkeys = vim.tbl_deep_extend("keep", lspkeys, {
  ["<SPACE>j"] = {
    name = "+Format",
    o = {"<cmd>OrganizeImports<cr>", "Organize imports"}
  },
})


require("which-key").register(lspkeys)
