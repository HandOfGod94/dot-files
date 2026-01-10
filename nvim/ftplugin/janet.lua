local function target_filename()
  local current_buffer = vim.api.nvim_buf_get_name(0)
  return current_buffer:sub(0, -5) .. ".lua"
end

local wk = require("which-key")
wk.add({
  { "<SPACE>j=", "<cmd>Dispatch! janet ./jpm_tree/bin/janet-format -f %<CR>", desc = "Format document" }
})
