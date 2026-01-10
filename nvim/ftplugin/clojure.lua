local wk = require("which-key")
wk.add({
  { "<SPACE>rl", "<cmd>VimuxPromptCommand('lein run ')<CR>", desc = "lein run anything.." },
  { "<SPACE>lt", "<cmd>CcaNreplRunCurrentTest<cr>", desc = "Run current test" },
  { "<SPACE>lT", "<cmd>CcaNreplRunTestsInTestNs<cr>", desc = "Run test in namespace" },
})
