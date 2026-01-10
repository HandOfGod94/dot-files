local wk = require("which-key")
wk.add({
  { "<SPACE>j=", "<cmd>Dispatch! npm run --prefix frontend format<cr>", desc = "Format current file (prettier)" },
})

