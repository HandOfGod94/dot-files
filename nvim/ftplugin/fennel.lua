local function target_filename()
  local current_buffer = vim.api.nvim_buf_get_name(0)
  return current_buffer:sub(0, -5) .. ".lua"
end

local wk = require("which-key")
wk.add({
  { "<SPACE>lc", "<cmd>Dispatch fennel --compile " .. vim.api.nvim_buf_get_name(0) .. " > " .. target_filename() .. "<cr>", desc = "compile current file" },
  { "<SPACE>lb", "<cmd>Dispatch make<cr>", desc = "build current project" },
  { "<SPACE>lp", "<cmd>Dispatch make install<cr>", desc = "install current project" },
  { "<SPACE>j=", "<cmd>Dispatch! fnlfmt --fix %<CR>", desc = "Format document" }
})
