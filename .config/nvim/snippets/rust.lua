require("luasnip.session.snippet_collection").clear_snippets "rust"

-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options
local ls = require("luasnip")
local extras = require("luasnip.extras")

local rep = extras.rep
local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt


ls.add_snippets("rust", {

  s("lc", fmt([[
pub struct Solution<prob_num>;

impl Solution<prob_num> {
    pub fn <fn_name>(<params>) ->> <rt_type> {
        <exit>
    }
}

#[cfg(test)]
pub mod test {
    use super::*;

    #[test]
    fn it_works_01() {
        assert_eq!(Solution<prob_num>::<fn_name>(<args>), <exp>);
    }
}
]],
  {
      prob_num = i(1, "prob_num"),
      fn_name = i(2, "fn_name"),
      params = i(3, "params"),
      rt_type = i(4, "rt_type"),
      args = i(5, "args"),
      exp = i(6, "expected"),
      exit = i(0),
  },
  {
    delimiters = "<>",
    repeat_duplicates = true
  }
  ))
})
