local function target_filename()
  local current_buffer = vim.api.nvim_buf_get_name(0)
  return current_buffer:sub(0, -5) .. ".lua"
end

local wk = require("which-key")
wk.register({
  ["<SPACE>l"] = {
    name = "+Language",
    c = { "<cmd>Dispatch fennel --compile " .. vim.api.nvim_buf_get_name(0) .. " > " .. target_filename() .. "<cr>",
      "compile current file" },
    b = { "<cmd>Dispatch make<cr>", "build current project"},
    p = { "<cmd>Dispatch make install<cr>", "install current project"},
  },
  ["<SPACE>j="] = { "<cmd>Dispatch! fnlfmt --fix %<CR>", "Format document" }
})
