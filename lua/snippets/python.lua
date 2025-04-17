local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("leet", {
    t({ "class Solution:", "    " }),
    t({ '    """', "    Problem Description:", "        " }),
    i(1, "Describe the problem..."),
    t({ "", "", "    Constraints:", "        " }),
    i(2, "Add constraints..."),
    t({ "", '    """', "", "" }),
    t({ "    def " }), i(3, "method_name"), t({ "(self, " }), i(4, "args"), t({ "):", "        " }),
    t({ "# TODO: implement solution", "        pass", "", "", "def main():", "    sol = Solution()" }),
    t({ "", "    # Example test case", "    input_data = " }), i(5, "your_input"),
    t({ "", "    expected_output = " }), i(6, "expected_result"),
    t({ "", "    result = sol." }), i(7, "method_name_again"), t({ "(input_data)" }),
    t({ "", '    print(f"Result: {result}")' }),
    t({ "", '    print(f"Expected: {expected_output}")' }),
    t({ "", '    print(f"Pass: {result == expected_output}")', "", "", 'if __name__ == "__main__":', "    main()" }),
  }),
}

