--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

--]]

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

require 'custom.options'

-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move selected lines up/down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Buffer navigation
vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprev<CR>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- Save shortcut
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

-- L and H as stronger line motion (end/start), won't conflict with anything
vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'End of line' })
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'First non-blank of line' })

-- Neo-tree Reveal the current file
vim.keymap.set('n', '<leader>e', '<cmd>Neotree reveal<CR>', { desc = 'Reveal file in Neo-tree' })

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- [[ Install lazy.nvim ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({

  -- ── Colorscheme ─────────────────────────────────────────────────────
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup { style = 'warm' }
      require('onedark').load()
      vim.cmd 'colorscheme onedark'
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup { flavour = 'mocha' }
      -- vim.cmd 'colorscheme catppuccin'
    end,
  },

  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        contrast = 'soft', -- 'hard', 'medium', 'soft'
      }
      -- vim.cmd 'colorscheme gruvbox'
    end,
  },

  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'soft' -- 'hard', 'medium', 'soft'
      vim.g.gruvbox_material_foreground = 'material' -- 'material', 'mix', 'original'
      vim.g.gruvbox_material_better_performance = 1
      -- vim.cmd 'colorscheme gruvbox-material'
    end,
  },

  -- ── Utilities ───────────────────────────────────────────────────────
  { 'NMAC427/guess-indent.nvim', opts = {} },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- ── Which-key ───────────────────────────────────────────────────────
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>c', group = '[C]ode' },
        { '<leader>g', group = '[G]it' },
      },
    },
  },

  -- ── Git ─────────────────────────────────────────────────────────────
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },

      -- ✅ Git blame shown on every line by default
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- shown at end of line
        delay = 300,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> · <summary>',

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc }) end

        -- Hunk navigation
        map('n', ']c', gs.next_hunk, 'Next Hunk')
        map('n', '[c', gs.prev_hunk, 'Prev Hunk')

        -- Hunk actions
        map('n', '<leader>hs', gs.stage_hunk, 'Stage Hunk')
        map('n', '<leader>hr', gs.reset_hunk, 'Reset Hunk')
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Stage Hunk')
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Reset Hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview Hunk')
        map('n', '<leader>hd', gs.diffthis, 'Diff This')

        -- Toggle blame on/off (it's ON by default, use this to temporarily hide)
        map('n', '<leader>tb', gs.toggle_current_line_blame, '[T]oggle [B]lame line')
      end,
    },
  },

  -- LazyGit TUI
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = { { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'LazyGit' } },
  },

  -- ── Telescope ───────────────────────────────────────────────────────
  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable 'make' == 1 end },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { 'node_modules', '.git/', 'dist/', '.next/', '__pycache__', '.venv' },
        },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
        end,
      })

      vim.keymap.set(
        'n',
        '<leader>/',
        function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false }) end,
        { desc = '[/] Fuzzily search in current buffer' }
      )

      vim.keymap.set(
        'n',
        '<leader>s/',
        function() builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end,
        { desc = '[S]earch [/] in Open Files' }
      )

      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- ── LSP ─────────────────────────────────────────────────────────────
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            'pyright',
            'ruff',
            'ruff-lsp',
          },
        },
      },
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- Add missing imports (auto-import)
          map(
            '<leader>ci',
            function()
              vim.lsp.buf.code_action {
                context = { only = { 'source.addMissingImports' } },
                apply = true,
              }
            end,
            '[C]ode: Add Missing [I]mports'
          )

          -- Organize imports
          map(
            '<leader>co',
            function()
              vim.lsp.buf.code_action {
                context = { only = { 'source.organizeImports' } },
                apply = true,
              }
            end,
            '[C]ode: [O]rganize Imports'
          )

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            -- Enable inlay hints by default for every buffer
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
            -- <leader>th toggles them off/on if they get noisy
            map('<leader>ti', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle [I]nlay Hints')
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- ── Language Servers ──────────────────────────────────────────────
      --   Covers: TypeScript · JavaScript · NestJS · React · Next.js
      --           Remix · Python · HTML · CSS · Tailwind · Emmet · Lua
      local servers = {

        -- TypeScript / JavaScript / NestJS / React / Next.js / Remix
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
              },
            },
            python = {
              analysis = {
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                  callArgumentNames = true,
                  pytestParameters = true,
                },
              },
            },
          },
        },

        -- ESLint: auto-fix entire file on save
        eslint = {
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        },

        -- Tailwind CSS (works in React, Next.js, Remix class strings)
        tailwindcss = {},

        -- HTML / CSS / JSON
        html = {},
        cssls = {},
        jsonls = {},

        -- Emmet for fast HTML & JSX expansion
        emmet_ls = {
          filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact', 'vue', 'svelte' },
        },

        -- Python: auto-detect uv (.venv) and conda environments
        pyright = {
          on_init = function(client)
            local root = client.config.root_dir or vim.fn.getcwd()
            local venv_python = root .. '/.venv/bin/python'
            local python_path

            if vim.fn.executable(venv_python) == 1 then
              python_path = venv_python
            else
              local conda_env = os.getenv 'CONDA_PREFIX'
              if conda_env then python_path = conda_env .. '/bin/python' end
            end

            if python_path then
              -- Update client.settings (what neovim returns for workspace/configuration)
              client.settings = vim.tbl_deep_extend('force', client.settings or {}, {
                python = { pythonPath = python_path },
              })
              -- Tell pyright to re-request workspace config (settings = nil is intentional)
              client:notify('workspace/didChangeConfiguration', { settings = nil })
            end
          end,
        },

        -- Lua (for editing this config)
        lua_ls = {},

        -- Go
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
      }

      -- Mason package names (different from lspconfig names!)
      -- Run :Mason to browse all available packages
      local mason_packages = {
        'typescript-language-server', -- ts_ls
        'eslint-lsp', -- eslint
        'tailwindcss-language-server', -- tailwindcss
        'html-lsp', -- html
        'css-lsp', -- cssls
        'json-lsp', -- jsonls
        'emmet-ls', -- emmet_ls
        'pyright', -- pyright (same name)
        'lua-language-server', -- lua_ls
        -- Formatters & linters
        'stylua',
        'prettier',
        'black',
        'isort',
        'eslint_d',
        -- Go
        'gopls',
        'gofumpt',
        'goimports',
      }

      require('mason-tool-installer').setup { ensure_installed = mason_packages }

      for name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end

      -- Special Lua config (points workspace to nvim runtime)
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file('', true),
            },
          })
        end,
        settings = { Lua = {} },
      })
      vim.lsp.enable 'lua_ls'
    end,
  },

  -- ── Formatting (auto-format on save) ────────────────────────────────
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
        return { timeout_ms = 3000, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        -- markdown = { 'prettier' },
        yaml = { 'prettier' },
        python = { 'isort', 'black' },
        -- python = { 'ruff_format' },

        go = { 'gofumpt', 'goimports' },
      },
      formatters = {
        black = {
          command = 'black',
          prepend_args = { '--fast' }, -- speeds up formatting
        },
      },
    },
  },

  -- ── Autocompletion (blink.cmp) ──────────────────────────────────────
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- Pre-built snippets for JS, TS, React, Python, NestJS, etc.
          {
            'rafamadriz/friendly-snippets',
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          },
        },
        opts = {},
      },
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'normal',
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
      },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },

  -- ── Treesitter ──────────────────────────────────────────────────────
  -- NOTE: Uses the NEW standalone nvim-treesitter API.
  -- Do NOT use `main = 'nvim-treesitter.configs'` — that module no longer exists.
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local filetypes = {
        -- Kickstart defaults
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        -- Full-stack additions
        'javascript',
        'typescript',
        'tsx',
        'css',
        'json',
        'jsonc',
        'python',
        'yaml',
        'graphql',
      }
      -- New API: pass a list of parser names directly
      require('nvim-treesitter').install(filetypes)
      -- Enable treesitter highlighting per filetype.
      -- Wrapped in pcall so opening a file doesn't crash if the
      -- parser isn't installed yet (e.g. first launch before :TSUpdate finishes).
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },

  -- Auto-close and rename HTML / JSX tags
  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'javascriptreact', 'typescriptreact', 'vue', 'svelte', 'xml' },
    opts = {},
  },

  -- ── TokyoNight (available but onedark is active above) ──────────────
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup { styles = { comments = { italic = false } } }
      -- Switch theme: uncomment the line below (and comment out onedark above)
      -- vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- ── mini.nvim ───────────────────────────────────────────────────────
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },

  -- ── AI Tools ────────────────────────────────────────────────────────
  --
  -- Pick ONE of the three options below and uncomment it.
  --
  -- ┌─────────────────────────────────────────────────────────────────┐
  -- │ OPTION A: GitHub Copilot  (requires GitHub Copilot subscription) │
  -- │ After uncommenting, run :Copilot auth to authenticate            │
  -- └─────────────────────────────────────────────────────────────────┘
  --
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd   = 'Copilot',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('copilot').setup {
  --       suggestion = {
  --         enabled     = true,
  --         auto_trigger = true,
  --         keymap = {
  --           accept      = '<M-l>',   -- Alt+L to accept full suggestion
  --           accept_word = '<M-w>',   -- Alt+W to accept next word
  --           accept_line = '<M-j>',   -- Alt+J to accept next line
  --           next        = '<M-]>',
  --           prev        = '<M-[>',
  --           dismiss     = '<C-]>',
  --         },
  --       },
  --       panel = { enabled = true },
  --     }
  --   end,
  -- },
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   dependencies = { 'zbirenbaum/copilot.lua', 'nvim-lua/plenary.nvim' },
  --   config = function()
  --     require('CopilotChat').setup()
  --     vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChat<CR>',        { desc = 'Copilot [C]hat' })
  --     vim.keymap.set('v', '<leader>ce', '<cmd>CopilotChatExplain<CR>', { desc = '[E]xplain Code' })
  --     vim.keymap.set('v', '<leader>cf', '<cmd>CopilotChatFix<CR>',     { desc = '[F]ix Code' })
  --     vim.keymap.set('v', '<leader>ct', '<cmd>CopilotChatTests<CR>',   { desc = 'Generate [T]ests' })
  --   end,
  -- },

  -- ┌────────────────────────────────────────────────────────────┐
  -- │ OPTION B: Codeium  (FREE — no subscription required)       │
  -- │ After uncommenting, run :Codeium Auth to authenticate       │
  -- └────────────────────────────────────────────────────────────┘
  --
  -- {
  --   'Exafunction/codeium.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'saghen/blink.cmp' },
  --   config = function()
  --     require('codeium').setup {}
  --     -- Also add 'codeium' to blink.cmp sources.default above:
  --     --   sources = { default = { 'lsp', 'path', 'snippets', 'buffer', 'codeium' } },
  --   end,
  -- },
  {
    'Exafunction/codeium.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'saghen/blink.cmp' },
    build = ':Codeium Auth',
    config = function()
      require('codeium').setup {
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = '<C-f>',
            next = '<C-]>',
            prev = '<C-[>',
            dismiss = '<C-e>',
          },
        },
      }

      -- Esc overwrite
      vim.keymap.set('i', '<Esc>', function()
        require('codeium.virtual_text').clear()
        return '<Esc>'
      end, { expr = true, silent = true })
    end,
  },
  -- ┌───────────────────────────────────────────────────────────────────┐
  -- │ OPTION C: Avante — chat with Claude / GPT / Copilot inside Neovim │
  -- │ Set your key first:  export ANTHROPIC_API_KEY=sk-ant-...           │
  -- │                  or: export OPENAI_API_KEY=sk-...                  │
  -- └───────────────────────────────────────────────────────────────────┘
  --
  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   build = 'make',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     require('avante').setup {
  --       provider = 'claude',  -- or 'openai' / 'copilot'
  --       claude   = {
  --         endpoint     = 'https://api.anthropic.com',
  --         model        = 'claude-sonnet-4-5',
  --         api_key_name = 'ANTHROPIC_API_KEY',
  --       },
  --       behaviour = { auto_suggestions = true },
  --       mappings  = {
  --         ask     = '<leader>aa',  -- open chat
  --         edit    = '<leader>ae',  -- edit selection with AI
  --         refresh = '<leader>ar',  -- refresh response
  --       },
  --     }
  --   end,
  -- },

  -- ── Kickstart built-in extras ────────────────────────────────────────
  -- ── Terminal (toggleterm.nvim) ─────────────────────────────────────
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        -- Open with <C-`> (Ctrl+backtick) — same as VS Code
        open_mapping = [[<C-`>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_only = false,
        persist_size = true,
        persist_mode = true,
        direction = 'horizontal', -- default: horizontal split at bottom
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = 'curved',
          winblend = 3,
        },
      }

      -- Helper to create named terminals
      local Terminal = require('toggleterm.terminal').Terminal

      -- Floating terminal (scratchpad)
      local float_term = Terminal:new {
        direction = 'float',
        hidden = true,
      }

      -- LazyGit inside toggleterm (alternative to the lazygit plugin)
      local lazygit = Terminal:new {
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        hidden = true,
        float_opts = { border = 'curved' },
        on_open = function(term)
          -- Escape exits lazygit, not nvim
          vim.keymap.set('t', '<Esc>', '<Esc>', { buffer = term.bufnr })
        end,
      }

      -- Node REPL
      local node_term = Terminal:new {
        cmd = 'node',
        direction = 'horizontal',
        hidden = true,
      }

      -- Python REPL
      local python_term = Terminal:new {
        cmd = 'python3',
        direction = 'horizontal',
        hidden = true,
      }

      -- ── Keymaps ───────────────────────────────────────────────────────
      local map = vim.keymap.set

      -- <C-`>  → toggle horizontal terminal (set by open_mapping above)

      -- <leader>tt → floating terminal (scratchpad)
      map('n', '<leader>tt', function() float_term:toggle() end, { desc = '[T]erminal Float' })

      -- <leader>th → horizontal split terminal
      map('n', '<leader>th', function() vim.cmd 'ToggleTerm direction=horizontal' end, { desc = '[T]erminal [H]orizontal' })

      -- <leader>tv → vertical split terminal
      map('n', '<leader>tv', function() vim.cmd 'ToggleTerm direction=vertical' end, { desc = '[T]erminal [V]ertical' })

      -- <leader>tg → LazyGit in float
      map('n', '<leader>tg', function() lazygit:toggle() end, { desc = '[T]erminal La[g]yGit' })

      -- <leader>tn → Node REPL
      map('n', '<leader>tn', function() node_term:toggle() end, { desc = '[T]erminal [N]ode' })

      -- <leader>tp → Python REPL
      map('n', '<leader>tp', function() python_term:toggle() end, { desc = '[T]erminal [P]ython' })

      -- Navigate OUT of terminal back to editor without closing it
      -- <C-h/j/k/l> works from terminal mode too
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        map('t', '<C-h>', '<cmd>wincmd h<CR>', opts)
        map('t', '<C-j>', '<cmd>wincmd j<CR>', opts)
        map('t', '<C-k>', '<cmd>wincmd k<CR>', opts)
        map('t', '<C-l>', '<cmd>wincmd l<CR>', opts)
        -- <C-`> also closes from inside terminal
      end

      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*toggleterm#*',
        callback = function() _G.set_terminal_keymaps() end,
      })
    end,
  },
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  --  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',

  -- { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },

  -- Go plugins (run tests, create struct tags, etc)
  {
    'ray-x/go.nvim',
    dependencies = { 'ray-x/guihua.lua' },
    ft = { 'go', 'gomod' },
    build = ':GoInstallBinaries',
    opts = {},
  },
})

-- vim: ts=2 sts=2 sw=2 et
-- Auto-detect conda env
local conda_env = os.getenv 'CONDA_PREFIX'
if conda_env then vim.g.python3_host_prog = conda_env .. '/bin/python' end

-- set colorscheme catppuccin-frappe for python
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'python',
--   callback = function() vim.cmd 'colorscheme catppuccin-frappe' end,
-- })
--
-- vim.api.nvim_create_autocmd('BufEnter', {
--   callback = function()
--     if vim.bo.filetype ~= 'python' then vim.cmd 'colorscheme onedark' end
--   end,
-- })
-- set colorscheme for go
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function() vim.cmd 'colorscheme gruvbox-material' end,
})
