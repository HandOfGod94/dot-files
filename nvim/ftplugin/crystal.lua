
local wk = require("which-key")
wk.register({
  ["<SPACE>j="] = { "<cmd>Dispatch! crystal tool format %<CR>", "Format document using crystal tool" }
})
