-- ~/.config/nvim/lua/plugins/conform.lua
-- took feom https://github.com/nvim-lua/kickstart.nvim

vim.pack.add { 'https://github.com/stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = true,
  notify_no_formatters = true,
  format_on_save = function(bufnr)
    -- You can specify filetypes to autoformat on save here:
    local enabled_filetypes = {
      -- lua = true,
      -- python = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    bash = { 'shfmt' },
    python = { 'ruff_format' },
    javascript = { 'biome' },
    typescript = { 'biome' },
    javascriptreact = { 'biome' },
    typescriptreact = { 'biome' },
    json = { 'biome' },
    jsonc = { 'biome' },
    html = { 'prettierd' },
    css = { 'prettierd' },
    scss = { 'prettierd' },
    -- rust = { 'rustfmt' },
    -- Conform can also run multiple formatters sequentially
    -- python = { "isort", "black" },
    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  formatters = {
    biome = {
      require_cwd = true,
      prepend_args = { '--indent-style=space', '--indent-width=2' },
    },
    prettierd = {
      prepend_args = { '--tab-width', '2', '--no-use-tabs' },
    },
  },
}
vim.keymap.set(
  { 'n', 'v' },
  '<Leader>fo',
  function() require('conform').format { async = true } end,
  { desc = 'Format buffer' }
)

--  vim: set ts=2 sts=2 sw=2 et :
