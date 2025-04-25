local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

return {
	s("cservice", {
		t({ "import logging", "", "", "" }),
		t("class "),
		f(function(_, snip)
			return snip.env.TM_FILENAME_BASE
		end, {}),
		t(":"),
		t({
			"",
			"    def __init__(self, request_nuid: str):",
			"        self.request_nuid = request_nuid",
			'        self.logger = logging.getLogger(f"',
		}),
		f(function(_, snip)
			return snip.env.TM_FILENAME_BASE
		end, {}),
		t(' | {request_nuid}")'),
		t({ "", "", "    @classmethod", "    def initialize(cls):", '        raise NotImplementedError(f"' }),
		f(function(_, snip)
			return snip.env.TM_FILENAME_BASE
		end, {}),
		t(' Initialization not yet implemented")'),
		t({
			"",
			"",
			"    @classmethod",
			"    def is_initialized(cls) -> bool:",
			'        raise NotImplementedError(f"',
		}),
		f(function(_, snip)
			return snip.env.TM_FILENAME_BASE
		end, {}),
		t(' is_initialized not yet implemented")'),
		t({ "", "", "    @classmethod", "    def destroy(cls):", '        raise NotImplementedError(f"' }),
		f(function(_, snip)
			return snip.env.TM_FILENAME_BASE
		end, {}),
		t(' Destruction not yet implemented")'),
	}),
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
			'        {"input": {}, "expected": None},',
			"    ]",
			"",
			"    successes = 0",
			"    for i, test in enumerate(tests):",
			'        print(f"\\nTest {i}:")',
			'        result = sol.solve(**test["input"])',
			"        print(f\"\\nInput: {test['input']}\")",
			'        print(f"Actual Result: {result} ({str(type(result))})")',
			"        print(f\"Expected Result: {test['expected']} ({str(type(test['expected']))})\\n\")",
			'        if result == test["expected"]:',
			'            print("Success!")',
			"            successes += 1",
			"        else:",
			'            print("Failure")',
			"",
			'    print(f"\\n{successes}/{len(tests)} Tests Passed\\n")',
			"",
			'if __name__ == "__main__":',
			"    main()",
		}),
	}),
}
