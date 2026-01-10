local wk = require("which-key")
wk.add(require("mykeybindings").lspkeys)
wk.add({
  { "<SPACE>jo", "<cmd>OrganizeImports<cr>", desc = "Organize imports" },
})
