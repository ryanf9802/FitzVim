# Repository Guidelines

## Project Structure & Module Organization

- Entry point: `init.lua` loads core modules and Lazy setup.
- Core: `lua/core/{options,keymaps,autocommands}.lua`.
- Plugins: `lua/plugins/init.lua` auto-loads each `lua/plugins/*.lua` file that returns a plugin spec table.
- Utilities: `lua/utils/python.lua` (virtualenv detection and helpers).
- Lockfile: `lazy-lock.json` pins plugin versions.
- Bootstrap: `lua/lazy_setup.lua` installs/configures `folke/lazy.nvim`.
- Setup script: `requirements.sh` (optional host dependencies).

## Build, Test, and Development Commands

- Install/sync plugins: `nvim --headless "+Lazy! sync" +qa` or inside Neovim `:Lazy sync`.
- Update Treesitter parsers: `:TSUpdate`.
- Health check: `nvim --headless "+checkhealth" +qa` (or run `:checkhealth`).
- Format Lua (if installed): `stylua .` or inside Neovim `:lua require("conform").format()`.
- One-time deps (optional): `bash requirements.sh`.

## Coding Style & Naming Conventions

- Language: Lua; indent 2 spaces; keep lines readable (~80–100 cols).
- Naming: use `snake_case` for variables/functions; plugin config files named after the tool (e.g., `lualine.lua`, `treesitter.lua`).
- Plugin modules must `return` a spec table and are auto-collected by `lua/plugins/init.lua`.
- Formatting: prefer `stylua`; for Markdown/JSON, follow `.prettierrc` (e.g., 2-space tabs, 80 char width).

## Testing Guidelines

- No unit test suite; validate via runtime checks:
  - Launch Neovim and ensure no startup errors.
  - Run `:checkhealth`, `:Mason`, and `:LspInfo`.
  - Open representative files (Python, TS/JS, Scala) to verify LSP/formatting.
- Update `lazy-lock.json` only when intentionally bumping plugin versions.

## Commit & Pull Request Guidelines

- History favors short, imperative summaries (e.g., "lsp: adjust metals config", "docs: update readme").
- Prefer focused commits; include context in body when changing behavior.
- PRs should include: clear description, rationale, verification steps (commands used), screenshots/gifs for UI changes, and any env notes (OS, Neovim version).

## Contributor Tips

- Adding a plugin: create `lua/plugins/<name>.lua` returning its spec; run `:Lazy sync`.
- Editing core behavior: update files under `lua/core/`; keep changes minimal and documented in commit body.
- When in doubt, test with `--headless` commands above and `:checkhealth`.

## LSP Diagnostics (Headless)

- Use `~/.config/nvim/scripts/cli_diagnostics.sh <file>` to capture diagnostics with a CLI-safe Neovim setup (defaults to text output).
- Add `--format json` for JSON output or `--timeout-ms N` to wait longer for LSP attachment.
- The script handles cache/state isolation and disables Mason installs; run it after modifying files so lint/type errors are current.
- If `nvim` is not installed in the current environment, skip this check and do not note it in the review output.
