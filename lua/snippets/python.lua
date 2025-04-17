local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("leet", {
    t({
      "class Solution:",
      "    def solve(self):",
      "        return",
      "",
      "",
      "def main():",
      "    sol = Solution()",
      "    tests = [",
      "        {\"input\": {}, \"expected\": None},",
      "    ]",
      "",
      "    successes = 0",
      "    for i, test in enumerate(tests):",
      "        print(f\"\\nTest {i}:\")",
      "        result = sol.solve(**test[\"input\"])",
      "        print(f\"\\nInput: {test['input']}\")",
      "        print(f\"Actual Result: {result} ({str(type(result))})\")",
      "        print(f\"Expected Result: {test['expected']} ({str(type(test['expected']))})\\n\")",
      "        if result == test[\"expected\"]:",
      "            print(\"Success!\")",
      "            successes += 1",
      "        else:",
      "            print(\"Failure\")",
      "",
      "    print(f\"\\n{successes}/{len(tests)} Tests Passed\\n\")",
      "",
      "if __name__ == \"__main__\":",
      "    main()",
    }),
  }),
}

