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

-- LSP keybindings via Snacks.keymap: auto-scoped to buffers whose attached
-- client supports the given method
require('snacks').keymap.set('n', 'gn', vim.lsp.buf.rename, {
  lsp = { method = 'textDocument/rename' },
  desc = 'Rename',
})
require('snacks').keymap.set({ 'n', 'x' }, 'ga', vim.lsp.buf.code_action, {
  lsp = { method = 'textDocument/codeAction' },
  desc = 'Goto Code Action',
})
require('snacks').keymap.set('n', 'gr', require('snacks').picker.lsp_references, {
  lsp = { method = 'textDocument/references' },
  nowait = true,
  desc = 'Goto References',
})
require('snacks').keymap.set('n', 'gi', require('snacks').picker.lsp_implementations, {
  lsp = { method = 'textDocument/implementation' },
  desc = 'Goto Implementation',
})
require('snacks').keymap.set('n', 'gd', require('snacks').picker.lsp_definitions, {
  lsp = { method = 'textDocument/definition' },
  desc = 'Goto Definition',
})
require('snacks').keymap.set('n', 'gD', vim.lsp.buf.declaration, {
  lsp = { method = 'textDocument/declaration' },
  desc = 'Goto Declaration',
})
require('snacks').keymap.set('n', 'gO', require('snacks').picker.lsp_symbols, {
  lsp = { method = 'textDocument/documentSymbol' },
  desc = 'Open Document Symbols',
})
require('snacks').keymap.set('n', 'gW', require('snacks').picker.lsp_workspace_symbols, {
  lsp = { method = 'workspace/symbol' },
  desc = 'Open Workspace Symbols',
})
require('snacks').keymap.set('n', 'gt', require('snacks').picker.lsp_type_definitions, {
  lsp = { method = 'textDocument/typeDefinition' },
  desc = 'Goto Type Definition',
})
require('snacks').keymap.set(
  'n',
  '<leader>th',
  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  {
    lsp = { method = 'textDocument/inlayHint' },
    desc = 'Toggle Inlay Hints',
  }
)
