-- ~/.config/nvim/lua/plugins/snacks.lua
local excluded = {
  'node_modules/',
  '.local/',
  '.cache/',
  'package-lock.json',
  'pnpm-lock.yaml',
  'yarn.lock',
}
return {
  plugin = {
    src = 'https://github.com/folke/snacks.nvim',
  },
  config = function()
    require('snacks').setup {

      -- your configuration comes here
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
      terminal = { enable = true },
      picker = {
        sources = {
          explorer = {
            auto_close = false,
            hidden = true,
            ignored = true,
            layout = {
              layout = { position = 'left' },
            },
          },
          files = {
            hidden = true,
            ignored = true,
            exclude = excluded,
          },
        },
        hidden = true,
        ignored = true,
      },
    }
    -- key bindings
    local snacks = require 'snacks'
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        desc = desc,
        silent = true,
      })
    end

    map('n', '<leader><space>', function() snacks.picker.smart() end, 'Smart Find Files')

    map('n', '<leader>,', function() snacks.picker.buffers() end, 'Buffers')

    map('n', '<leader>fg', function() snacks.picker.grep() end, 'Grep')

    map('n', '<leader>n', function() snacks.picker.notifications() end, 'Notification History')

    map('n', '<leader>e', function() snacks.explorer() end, 'File Explorer')

    map('n', '<leader>fc', function() snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, 'Find Config File')

    map('n', '<leader>ff', function() snacks.picker.files() end, 'Find Files')

    map('n', '<leader>fr', function() snacks.picker.recent() end, 'Recent')

    -- grep / search
    map('n', '<leader>sb', function() snacks.picker.lines() end, 'Buffer Lines')
    map('n', '<leader>sB', function() snacks.picker.grep_buffers() end, 'Grep Open Buffers')
    map('n', '<leader>sg', function() snacks.picker.grep() end, 'Grep')
    map({ 'n', 'x' }, '<leader>sw', function() snacks.picker.grep_word() end, 'Visual selection or word')
    map('n', '<leader>sr', function() snacks.picker.registers() end, 'Registers')
    map('n', '<leader>sh', function() snacks.picker.search_history() end, 'Search History')
    map('n', '<leader>sa', function() snacks.picker.autocmds() end, 'Autocmds')
    map('n', '<leader>sc', function() snacks.picker.command_history() end, 'Command History')
    map('n', '<leader>sC', function() snacks.picker.commands() end, 'Commands')
    map('n', '<leader>sd', function() snacks.picker.diagnostics() end, 'Diagnostics')
    map('n', '<leader>sj', function() snacks.picker.jumps() end, 'Jumps')
    map('n', '<leader>sk', function() snacks.picker.keymaps() end, 'Keymaps')
    map('n', '<leader>sM', function() snacks.picker.man() end, 'Man Pages')
    map('n', '<leader>sq', function() snacks.picker.qflist() end, 'Quickfix List')
    map('n', '<leader>su', function() snacks.picker.undo() end, 'Undo History')
    map('n', '<leader>uC', function() snacks.picker.colorschemes() end, 'Colorschemes')

    -- git
    map('n', '<leader>gb', function() snacks.picker.git_branches() end, 'Git Branches')

    map('n', '<leader>gl', function() snacks.picker.git_log() end, 'Git Log')

    map('n', '<leader>gL', function() snacks.picker.git_log_line() end, 'Git Log Line')

    map('n', '<leader>gs', function() snacks.picker.git_status() end, 'Git Status')

    map('n', '<leader>gS', function() snacks.picker.git_stash() end, 'Git Stash')

    map('n', '<leader>gd', function() snacks.picker.git_diff() end, 'Git Diff (Hunks)')

    -- lsp
    map('n', 'gd', function() snacks.picker.lsp_definitions() end, 'Goto Definition')

    map('n', 'gD', function() snacks.picker.lsp_declarations() end, 'Goto Declaration')

    map('n', 'gr', function() snacks.picker.lsp_references() end, 'References')

    map('n', 'gI', function() snacks.picker.lsp_implementations() end, 'Goto Implementation')

    map('n', 'gy', function() snacks.picker.lsp_type_definitions() end, 'Goto T[y]pe Definition')

    map('n', '<leader>ss', function() snacks.picker.lsp_symbols() end, 'LSP Symbols')

    map('n', '<leader>sS', function() snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')

    -- django terminal
    local venv_bin = vim.fn.getcwd() .. '/.venv/bin'
    local function django_term(cmd)
      return function()
        snacks.terminal(cmd, {
          cwd = vim.fn.getcwd(),
          env = { PATH = venv_bin .. ':' .. vim.env.PATH },
          win = { position = 'float' },
        })
      end
    end
    map('n', '<leader>dr', django_term 'python manage.py runserver', 'Django runserver')
    map('n', '<leader>dm', django_term 'python manage.py migrate', 'Django migrate')
    map('n', '<leader>dk', django_term 'python manage.py makemigrations', 'Django makemigrations')
  end,
}

--  vim: set ts=2 sts=2 sw=2 et :
