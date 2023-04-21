local lspkeys = require('lsphelpers').keys
lspkeys = vim.tbl_deep_extend("keep", lspkeys, {
  ["<SPACE>j"] = {
    name = "+Format",
    ["="] = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format go code" }
  },
  ["<SPACE>r"] = {
    name = "+Run",
    r = {"<cmd>Dispatch python ".. vim.api.nvim_buf_get_name(0) .."<cr>", "Run current file"}
  },
  ["<SPACE>l"] = {
    d = {
      T = { "<cmd>lua require('dap-python').test_class()<cr>", "debug current test class" },
      t = { "<cmd>lua require('dap-python').test_method()<cr>", "debug current test method" },
    }
  }
})

local wk = require('which-key')
wk.register(lspkeys)
