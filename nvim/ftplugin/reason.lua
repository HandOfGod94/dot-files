local wk = require("which-key")
wk.register({
  ["<SPACE>l"] = {
    name = "+Language",
    b = { "<cmd>Dispatch! dune build<cr>", "build current project"},
  },
})
