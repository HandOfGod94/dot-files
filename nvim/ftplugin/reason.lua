local wk = require("which-key")
wk.add({
  { "<SPACE>lb", "<cmd>Dispatch! dune build<cr>", desc = "build current project" },
})
