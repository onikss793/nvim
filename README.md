# My Neovim Config

Personal Neovim configuration, customized from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
Optimized for full-stack development (TypeScript/React/Next.js, Python, Go) on macOS.

## Structure

```
~/.config/nvim/
├── init.lua                          # Main config (options, keymaps, plugins)
├── lua/
│   ├── custom/
│   │   ├── options.lua               # Custom editor options
│   │   └── plugins/init.lua          # Custom plugin specs (empty, ready to extend)
│   └── kickstart/
│       └── plugins/
│           ├── autopairs.lua          # Auto-close brackets/quotes
│           ├── debug.lua              # DAP debugger (Go via Delve)
│           ├── gitsigns.lua           # Git gutter signs & hunk keymaps
│           ├── indent_line.lua        # Indentation guides
│           ├── lint.lua               # nvim-lint (disabled by default)
│           └── neo-tree.lua           # File explorer sidebar
└── lazy-lock.json
```

## Plugin Manager

[lazy.nvim](https://github.com/folke/lazy.nvim) — run `:Lazy` to manage plugins.

## Colorschemes

Multiple themes installed, switchable by uncommenting in `init.lua`:

- **gruvbox-material** (active) — `soft` background, `material` foreground
- onedark (`warm`)
- catppuccin (`mocha`)
- gruvbox (`soft`)
- tokyonight

Per-filetype override: Go files automatically use `gruvbox-material`.

## Language Support

All LSP servers and tools are managed via **Mason** (`:Mason` to browse).

### LSP Servers

- **TypeScript / JavaScript** — `ts_ls` (inlay hints enabled)
- **ESLint** — auto-fix on save (`EslintFixAll`)
- **Tailwind CSS** — `tailwindcss`
- **HTML / CSS / JSON** — `html`, `cssls`, `jsonls`
- **Emmet** — `emmet_ls` (HTML, CSS, JSX/TSX, Vue, Svelte)
- **Python** — `pyright`
- **Go** — `gopls` (full inlay hints)
- **Lua** — `lua_ls` (with Neovim runtime workspace)

### Formatting (auto-format on save via conform.nvim)

- **Lua** — `stylua`
- **JS / TS / HTML / CSS / JSON / YAML** — `prettier`
- **Python** — `isort` + `black`
- **Go** — `gofumpt` + `goimports`

Manual format: `<leader>f`

### Treesitter Parsers

bash, c, diff, html, lua, luadoc, markdown, markdown_inline, query, vim, vimdoc,
javascript, typescript, tsx, css, json, jsonc, python, yaml, graphql

## Autocompletion

[blink.cmp](https://github.com/Saghen/blink.cmp) with sources: LSP, path, snippets (LuaSnip + friendly-snippets), buffer.

- `<Tab>` — accept completion
- `<C-j>` / `<C-k>` — navigate completion list
- Signature help enabled

## AI Code Assistant

**Codeium** (active) — free AI completions as virtual text.

- `<C-f>` — accept suggestion
- `<C-]>` / `<C-[>` — next / prev suggestion
- `<C-e>` — dismiss
- `<Esc>` in insert mode clears suggestion and exits

Alternative options (commented out in `init.lua`):
- GitHub Copilot + CopilotChat
- Avante (Claude / GPT chat inside Neovim)

## Key Bindings

Leader key: `<Space>`

### General

| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | n | Save file |
| `<leader>x` | n | Close buffer |
| `<leader>e` | n | Reveal in Neo-tree |
| `<leader>q` | n | Diagnostic quickfix list |
| `<Esc>` | n | Clear search highlight |
| `H` / `L` | n, v | Start / End of line |
| `<Tab>` / `<S-Tab>` | n | Next / Prev buffer |
| `J` / `K` | v | Move selected lines down / up |
| `<C-h/j/k/l>` | n | Window navigation |

### Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Grep current word |
| `<leader>sb` | Search buffers |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>sc` | Search commands |
| `<leader>sn` | Search Neovim config files |
| `<leader>s/` | Grep in open files |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader><leader>` | Find existing buffers |

### LSP (active on attach)

| Key | Action |
|-----|--------|
| `grr` | Go to references |
| `grd` | Go to definition |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `grD` | Go to declaration |
| `grn` | Rename symbol |
| `gra` | Code action |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `K` | Hover documentation |
| `<leader>ci` | Add missing imports |
| `<leader>co` | Organize imports |
| `<leader>ti` | Toggle inlay hints |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |
| `]c` / `[c` | Next / Prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hd` | Diff this |
| `<leader>tb` | Toggle inline blame |

Inline git blame is **on by default** (author, date, summary at end of line).

### Terminal (toggleterm.nvim)

| Key | Action |
|-----|--------|
| `` <C-`> `` | Toggle horizontal terminal |
| `<leader>tt` | Floating terminal |
| `<leader>th` | Horizontal split terminal |
| `<leader>tv` | Vertical split terminal |
| `<leader>tg` | LazyGit in float |
| `<leader>tn` | Node REPL |
| `<leader>tp` | Python REPL |

`<C-h/j/k/l>` works from terminal mode to navigate back to editor windows.

### Debug (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start / Continue |
| `<F1>` | Step Into |
| `<F2>` | Step Over |
| `<F3>` | Step Out |
| `<F7>` | Toggle DAP UI |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Conditional breakpoint |

Go debugging via Delve is pre-configured.

## Other Plugins

- **which-key** — shows available keybindings after pressing leader
- **mini.nvim** — `ai` (textobjects), `surround`, `statusline`
- **nvim-autopairs** — auto-close brackets and quotes
- **nvim-ts-autotag** — auto-close/rename HTML & JSX tags
- **indent-blankline** — indentation guides
- **todo-comments** — highlight TODO/FIXME/HACK in code
- **guess-indent** — auto-detect indentation style
- **go.nvim** — Go tooling (test runner, struct tags, etc.)
- **fidget.nvim** — LSP progress notifications

## Custom Editor Options

Defined in `lua/custom/options.lua`:

- 2-space indentation (tabs expanded to spaces)
- No line wrap, no swap/backup files
- Color column at 100
- System clipboard integration
- Smart case search
- Persistent undo

## Prerequisites

- Neovim >= stable (latest recommended)
- [Nerd Font](https://www.nerdfonts.com/) installed and selected in terminal
- `git`, `make`, `gcc`, [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd)
- `npm` (for TypeScript/JS tooling)
- `go` (for Go tooling)
- `python3` (for Python tooling)
- [lazygit](https://github.com/jesseduffield/lazygit) (optional, for `<leader>gg` / `<leader>tg`)
- Conda auto-detected if `CONDA_PREFIX` is set

## Installation

```sh
git clone <this-repo> ~/.config/nvim
nvim
```

On first launch, lazy.nvim will auto-install all plugins. Mason will then install the configured LSP servers, formatters, and linters.

Run `:Lazy` to check plugin status, `:Mason` to check tool installations.
