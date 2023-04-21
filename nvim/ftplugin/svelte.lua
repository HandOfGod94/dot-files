local wk = require("which-key")
wk.register({
  ["<SPACE>j"] = {
    name = "+Format",
    ["="] = {"<cmd>Dispatch! npx prettier --plugin-search-dir=. --write " .. vim.api.nvim_buf_get_name(0) .. "<cr>", "Format current file (prettier)"}
  },
})

