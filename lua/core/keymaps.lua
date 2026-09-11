-- ~/.config/nvim/lua/core/keymaps.lua
--
local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { silent = true, desc = desc }, opts))
end
map('n', '<space>', '<Nop>', 'Disable default space movement (used as leader)')

map(
  'n',
  'j',
  function() return vim.v.count > 0 and 'j' or 'gj' end,
  'Move down (gj when no count given)',
  { expr = true }
)

map(
  'n',
  'k',
  function() return vim.v.count > 0 and 'k' or 'gk' end,
  'Move up (gk when no count given)',
  { expr = true }
)

map('n', '<C-d>', '<C-d>zz', 'Scroll down and center cursor')

map('n', '<C-u>', '<C-u>zz', 'Scroll up and center cursor')

map('n', '<Leader>w', '<cmd>w!<CR>', 'Save file')

map('n', '<Leader>q', '<cmd>q<CR>', 'Quit')

map('n', '<Leader>te', '<cmd>tabnew<CR>', 'Open new tab')

map('n', '<Leader>_', '<cmd>vsplit<CR>', 'Split window vertically')

map('n', '<Leader>-', '<cmd>split<CR>', 'Split window horizontally')
-- copy and paste system clipboard on demand
map('n', '<leader>y', '"+y', 'Yank to system clipboard')

map('v', '<leader>y', '"+y', 'Yank to system clipboard')

map('n', '<leader>Y', '"+Y', 'Yank line to system clipboard')

map('n', '<leader>p', '"+p', 'Paste from system clipboard')

map('v', '<leader>P', '"+p', 'Paste from system clipboard (visual)')

map('v', '<Leader>p', '"_dP', 'Paste without overwriting default register')

map('n', '<leader>cd', '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>', 'Change directory')

map('n', 'grd', '<cmd>lua vim.lsp.buf.definition()<CR>', 'Goto definition', { expr = true })

map('n', '<leader>ps', '<cmd>lua vim.pack.update()<CR>', 'Update plugins')

map('i', 'jk', '<Esc>', 'Exit insert mode')

map('x', '<Leader>mw', ':d | new +put! "<CR>', 'Move selection to new split')

map('n', '<Leader>fpr', '<Cmd>CopyPath relative<CR>', 'Insert relative file path')

map({ 'n', 'v' }, '<Leader>ml', '<Cmd>AppendModeline<CR>', 'Append modeline to eof')

--  vim: set ts=2 sts=2 sw=2 et :
