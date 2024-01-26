local wk = require("which-key")
wk.register({
  ["<SPACE>j"] = {
    name = "+Format",
    ["="] = {"<cmd>Dispatch! npm run --prefix frontend format<cr>", "Format current file (prettier)"}
  },
})

