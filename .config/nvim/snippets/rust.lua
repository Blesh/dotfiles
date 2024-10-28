require("luasnip.session.snippet_collection").clear_snippets "rust"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt


ls.add_snippets("rust", {
  s("lctest", fmt([[
#[cfg(test)]
pub mod test {{
    use super::*;

    #[test]
    fn it_works_01() {{
        {}
    }}
}}
]], { i(1, "test_impl") }))
})
--ls.add_snippets("rust", {
--  s("lctest", fmt("#[cfg(test)]\npub mod test \\{\n\tuse super::*;\n\n\t#[test]\n\tfn it_works_01() \\{\n\t\t{}\n\t\\}\n\\}", { i(1, "test_impl") }))
--})
