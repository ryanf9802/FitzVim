local ls   = require("luasnip")
local s    = ls.snippet
local t    = ls.text_node
local i    = ls.insert_node
local rep  = require("luasnip.extras").rep

return {
  s("cservice", {
    -- import
    t({ "import logging", "", "" }),

    -- class declaration
    t("class "), i(1, "ServiceName"), t(":"),

    -- __init__
    t({
      "",
      "",
      "    def __init__(self, request_nuid: str):",
      "        self.request_nuid = request_nuid",
      '        self.logger = logging.getLogger(f"' }),
    rep(1),
    t(' | {request_nuid}")'),

    -- initialize
    t({
      "",
      "",
      "    @classmethod",
      "    def initialize(cls) -> None:",
      '        """Initialize the service. Raises an exception if initialization fails,',
      '        otherwise returns None."""',
      '        raise NotImplementedError(f"' }),
    rep(1),
    t(" Initialization not yet implemented\")"),

    -- is_initialized
    t({
      "",
      "",
      "    @classmethod",
      "    def is_initialized(cls) -> bool:",
      '        """Returns True if the service is initialized, otherwise False."""',
      '        raise NotImplementedError(f"' }),
    rep(1),
    t(" is_initialized not yet implemented\")"),

    -- destroy
    t({
      "",
      "",
      "    @classmethod",
      "    def destroy(cls) -> str | None:",
      '        """Destroy the service. Returns None if successful, `str` `reason` if ',
      '        in progress, and raises an Exception if destruction failed."""',
      '        raise NotImplementedError(f"' }),
    rep(1),
    t(" Destruction not yet implemented\")"),
  }),
}

