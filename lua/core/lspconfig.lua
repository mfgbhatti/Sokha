-- ~/.config/nvim/lsp/lspconfig.lua
--
local platform = require 'core.utils'

local lsps = {
  common = {
    'html',
    'ruff',
    'cssls',
    'lua_ls',
    'stylua',
    'bashls',
    'yamlls',
    'basedpyright',
    'emmet_language_server',
    'nginx_language_server',
  },

  linux = {
    'djls',
    'tsc',
  },
}

local current = platform.is_android and 'android' or 'linux'

vim.lsp.enable(vim.list_extend(vim.deepcopy(lsps.common), lsps[current] or {}))

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many', max_width = 60 },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '●',
      [vim.diagnostic.severity.WARN] = '●',
    },
  },

  -- Can switch between these as you prefer
  virtual_text = false, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}
-- core/keymaps.lua
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Line Diagnostics (float)' })

--  vim: set ts=2 sts=2 sw=2 et :
