-- ~/.config/nvim/lsp/lspconfig.lua
--
local platform = require 'core.utils'
local available_lsps = {
  'stylua',
  'lua_ls',
  'ruff',
  'cssls',
  'html',
  'yamlls',
  'bashls',
  'basedpyright',
  'emmet_language_server',
  'nginx_language_server',
}

local linux_lsps = {
  'djls',
  'tsc',
}
local all_lsps = vim.list_extend({}, available_lsps)

if platform.is_linux then vim.list_extend(all_lsps, linux_lsps) end
vim.lsp.enable(all_lsps)

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
