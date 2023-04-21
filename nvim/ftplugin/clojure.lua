local wk = require("which-key")
wk.register({
  ["<SPACE>r"] = {
    name = "+Run",
    l = {"<cmd>VimuxPromptCommand('lein run ')<CR>", "lein run anything.."}
  },
  ["<SPACE>l"] = {
    name = "+Language",
    t = { "<cmd>CcaNreplRunCurrentTest<cr>", "Run current test" },
    T = { "<cmd>CcaNreplRunTestsInTestNs<cr>", "Run test in namespace" },
  },
})
