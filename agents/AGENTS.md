# AI Agent Toolkit & Environment Guide

This guide lists the preferred modern tools available in this environment for AI agents (Claude, Gemini, etc.).
Please prioritize using these tools over legacy commands for efficiency and performance.

## Preferred Modern Tools (Rust/Go based)

| Category | Preferred Tool | Legacy | Description                              |
| :------- | :------------- | :----- | :--------------------------------------- |
| Grep | `rg`       | `grep` | Fast search, respects .gitignore.        |
| List | `eza`      | `ls`   | Better formatting & icons.               |
| Cat  | `bat`      | `cat`  | Syntax highlighting.                     |
| Find | `fd`       | `find` | Fast file finding, user-friendly syntax. |
| Cd   | `z`        | `cd`   | Jump to directories (zoxide).            |
| JSON | `jq`       | -      | JSON processor.                          |
| Git  | `gh`       | `git`  | GitHub CLI for PRs & issues.             |

## Package Managers

- Python: Use `uv` (Fast pip alternative).
- Node.js: Managed by `nvm` (LTS).

## Agent Best Practices

1. Exploration: Use `eza --tree --level=2` to understand project structure.
2. Search: Use `rg` to find code. It's much faster than `grep`.
3. Reading: Use `bat` for reading code files.
