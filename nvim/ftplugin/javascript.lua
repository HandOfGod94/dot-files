local wk = require("which-key")
wk.add({
  { "<SPACE>j=", "<cmd>Dispatch! npx prettier --write %<cr>", desc = "Format current file (prettier)" },
})

