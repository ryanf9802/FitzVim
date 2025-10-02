local M = {}

local severity_names = {
  [vim.diagnostic.severity.ERROR] = "ERROR",
  [vim.diagnostic.severity.WARN] = "WARN",
  [vim.diagnostic.severity.INFO] = "INFO",
  [vim.diagnostic.severity.HINT] = "HINT",
}

local function wait_for_lsp(bufnr, timeout_ms)
  return vim.wait(timeout_ms, function()
    return #vim.lsp.get_clients({ bufnr = bufnr }) > 0
  end, 20)
end

local function wait_for_diagnostics(bufnr, timeout_ms)
  local diagnostics = vim.diagnostic.get(bufnr)
  if diagnostics and #diagnostics > 0 then
    return true
  end

  local augroup = vim.api.nvim_create_augroup("CliDiagnosticsTemp", { clear = true })
  local received = false

  vim.api.nvim_create_autocmd("DiagnosticChanged", {
    group = augroup,
    once = true,
    callback = function(args)
      if args.buf == bufnr then
        received = true
      end
    end,
  })

  local ok = vim.wait(timeout_ms, function()
    return received
  end, 20)

  pcall(vim.api.nvim_del_augroup_by_id, augroup)

  return ok
end

local function normalize_diagnostic(bufnr, diagnostic)
  return {
    filename = vim.api.nvim_buf_get_name(bufnr),
    lnum = (diagnostic.lnum or 0) + 1,
    col = (diagnostic.col or 0) + 1,
    end_lnum = diagnostic.end_lnum and (diagnostic.end_lnum + 1) or nil,
    end_col = diagnostic.end_col and (diagnostic.end_col + 1) or nil,
    severity = severity_names[diagnostic.severity] or tostring(diagnostic.severity),
    source = diagnostic.source,
    code = diagnostic.code,
    message = diagnostic.message,
  }
end

local function emit_text(diagnostics)
  for _, diagnostic in ipairs(diagnostics) do
    local parts = {
      diagnostic.filename,
      diagnostic.lnum,
      diagnostic.col,
      diagnostic.severity,
      diagnostic.message and diagnostic.message:gsub("\n", " ") or "",
    }
    print(table.concat(parts, ":"))
  end
end

local function emit_json(diagnostics)
  local ok, encoded = pcall(vim.fn.json_encode, diagnostics)
  if ok then
    print(encoded)
  else
    error("Failed to encode diagnostics as JSON: " .. encoded)
  end
end

function M.run(opts)
  opts = opts or {}

  local bufnr = opts.buf or vim.api.nvim_get_current_buf()
  local timeout_ms = opts.timeout_ms or 5000
  local format = opts.format or "text"

  wait_for_lsp(bufnr, timeout_ms)
  wait_for_diagnostics(bufnr, timeout_ms)

  local diagnostics = {}
  for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
    table.insert(diagnostics, normalize_diagnostic(bufnr, diagnostic))
  end

  if format == "json" then
    emit_json(diagnostics)
  else
    emit_text(diagnostics)
  end
end

return M
