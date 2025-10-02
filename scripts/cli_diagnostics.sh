#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE' >&2
Usage: scripts/cli_diagnostics.sh [--format text|json] [--timeout-ms N] <file> [<additional nvim args...>]
USAGE
  exit 1
}

format="text"
timeout=""
file=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --format)
      [[ $# -ge 2 ]] || usage
      format="$2"
      shift 2
      ;;
    --timeout-ms)
      [[ $# -ge 2 ]] || usage
      timeout="$2"
      shift 2
      ;;
    --help|-h)
      usage
      ;;
    --)
      shift
      break
      ;;
    -* )
      usage
      ;;
    * )
      file="$1"
      shift
      break
      ;;
  esac
done

[[ -n "$file" ]] || usage

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export XDG_CACHE_HOME="${repo_dir}/.cli-cache"
export XDG_STATE_HOME="${repo_dir}/.cli-state"
export NVIM_CLI_DIAGNOSTICS=1

mkdir -p "${XDG_CACHE_HOME}/nvim" "${XDG_CACHE_HOME}/nvim/luac" "${XDG_STATE_HOME}/nvim" "${XDG_STATE_HOME}/nvim/shada"

lua_call="lua require('utils.cli_diagnostics').run({ buf = 0, format = '${format}'"
if [[ -n "$timeout" ]]; then
  lua_call+=$(printf ", timeout_ms = %s" "$timeout")
fi
lua_call+=" })"

nvim --headless -n "$file" "+${lua_call}" +qa "$@"
