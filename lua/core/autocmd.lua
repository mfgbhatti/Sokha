-- ~/.config/nvim/lua/core/autocmd.lua

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  pattern = '*',
  callback = function() vim.highlight.on_yank { timeout = 170 } end,
  group = highlight_group,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not (client and client.name == 'basedpyright') then return end
    local ruff_attached = #vim.lsp.get_clients { bufnr = event.buf, name = 'ruff' } > 0
    if ruff_attached then
      client.server_capabilities.hoverProvider = false -- let ruff handle hover instead
    end

    if
      client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
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
        group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds {
            group = 'user-lsp-highlight',
            buffer = event2.buf,
          }
        end,
      })
    end
    local opts = { buffer = event.buf }
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>ca',
      vim.lsp.buf.code_action,
      vim.tbl_extend('force', opts, { desc = 'Code action' })
    )
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover docs' }))
  end,
})
-- See `:help vim.pack-events`
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local name = event.data.spec.name
    local kind = event.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'nvim-treesitter' then
      if not event.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
      return
    end
  end,
})
