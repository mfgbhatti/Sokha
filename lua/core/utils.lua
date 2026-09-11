-- ~/.config/nvim/lua/core/utils.lua
-- a. Modeline
local function append_modeline()
  local expandtab_str = vim.o.expandtab and '' or 'no'
  local modeline = string.format(
    ' vim: set ts=%d sts=%d sw=%d %set :',
    vim.o.tabstop,
    vim.o.softtabstop,
    vim.o.shiftwidth,
    expandtab_str
  )
  modeline = string.gsub(vim.o.commentstring, '%%s', modeline)
  vim.api.nvim_buf_set_lines(0, -1, -1, true, { modeline })
end
vim.keymap.set('n', '<Leader>ml', append_modeline, { silent = true })

--  vim: set ts=2 sts=2 sw=2 et :
