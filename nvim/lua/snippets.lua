local M = {}

function M.setup()
  local ls = require("luasnip")
  local fmt = require("luasnip.extras.fmt").fmt

  -- go snippets
  ls.add_snippets("go", {
    ls.s("main", fmt([[
    package main

    func main() {
      <>
    }

    ]], ls.i(0), { delimiters = "<>" })),

    ls.s("udd", {
      ls.t("type "),
      ls.i(1),
      ls.t(" struct {"),
      ls.i(0),
      ls.t({ "}", "" })
    }),

    ls.s("forrange", fmt([[
        for <>, <> := range <> {
          <>
        }
      ]], { ls.i(3), ls.i(2), ls.i(1), ls.i(0) }, { delimiters = "<>" })
    )
  }, {
    key = "go"
  })

  -- git commit snippet
  ls.add_snippets("gitcommit", {
    ls.s("atm", fmt([[
      [ATM-{}][+{}] {}

      Co-authored-by: {} <{}>
    ]], { ls.i(1), ls.i(2), ls.i(3), ls.i(4), ls.i(5) }))
  }, { key = "gitcommit" })

  -- python snippets
  ls.add_snippets("python", {
    ls.s("main", fmt([[ 

    def main():
        {}

    if __name__ == "__main__":
        main()

    ]], { ls.i(0) }))
  }, {
    key = "python"
  })
end

return M
