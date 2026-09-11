-- ~/.config/nvim/lsp/lspconfig.lua
--
vim.lsp.enable {
  'stylua',
  'lua_ls',
  'bashls',
  'basedpyright',
  'ruff',
  'cssls',
  -- 'djls', -- djls no binary for termux
  'emmet_language_server',
  'html',
  -- 'biome' --not working,
  'nginx_language_server',
  'ts_ls',
  -- 'tsc', -- when tsc 7.2.0 is supported
  'yamlls',
}

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
