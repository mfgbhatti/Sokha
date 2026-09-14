-- ~/.config/nvim/lua/core/commands.lua
local command = vim.api.nvim_create_user_command

-- Remove Trailing Whitespace
command('RemoveTrailingSpaces', function() vim.cmd [[%s/\s\+$//e]] end, {
  desc = 'Remove all trailing spaces in the current buffer',
})

-- Join Empty Lines
command('JoinEmptyLines', function(args)
  if args.fargs[1] ~= nil then
    -- Custom maximum number of empty lines to join
    vim.cmd('silent! g/^$/,/./-' .. args.fargs[1] .. 'j')
  elseif args.bang then
    -- Force join: remove *all* empty lines
    vim.cmd 'silent! g/^$/-j'
  else
    -- Default behavior: join single empty lines
    vim.cmd 'silent! g/^$/,/./-1j'
  end

  -- Remove trailing empty lines at the end of file
  vim.cmd [[%s/\_s*\%$//e]]
  vim.cmd 'nohlsearch'
end, {
  desc = 'Join or remove empty lines',
  bang = true,
  nargs = '?',
})

-- Clear Vim Registers
command('ClearRegisters', function()
  local regs = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
  for r in regs:gmatch '.' do
    vim.fn.setreg(r, '')
  end
  vim.notify('Registers cleared', vim.log.levels.INFO, { title = 'Neovim' })
end, {
  desc = 'Clear yank/delete registers',
})

-- Add modeline
command('AppendModeline', function()
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
end, { desc = 'Append modeline at EOF' })

-- Copy file path to clipboard
vim.api.nvim_create_user_command('CopyPath', function(context)
  local full_path = vim.fn.glob '%:p'

  local file_path = nil
  if context['args'] == 'nameonly' then file_path = vim.fn.fnamemodify(full_path, ':t') end

  -- get the file path relative to project root
  if context['args'] == 'relative' then
    local project_marker = { '.git', 'pyproject.toml' }
    local project_root = vim.fs.root(0, project_marker)
    if project_root == nil then
      vim.print 'can not find project root'
      return
    end

    file_path = vim.fn.substitute(full_path, project_root, '<project-root>', 'g')
  end

  if context['args'] == 'absolute' then file_path = full_path end

  vim.fn.setreg('+', file_path)
  vim.print 'Filepath copied to clipboard!'
end, {
  bang = false,
  nargs = 1,
  force = true,
  desc = 'Copy current file path to clipboard',
  complete = function() return { 'nameonly', 'relative', 'absolute' } end,
})

--  vim: set ts=2 sts=2 sw=2 et :
