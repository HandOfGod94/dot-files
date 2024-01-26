local wk = require("which-key")
wk.register({
  ["<SPACE>j"] = {
    name = "+Format",
    ["="] = {"<cmd>Dispatch! npx prettier --write %<cr>", "Format current file (prettier)"}
  },
})

