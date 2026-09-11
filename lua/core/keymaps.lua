-- ~/.config/nvim/lua/core/keymaps.lua
local keymap = vim.keymap.set
local s = { silent = true }
local opts = { noremap = true, silent = true, desc = 'Goto Definition' }
local Snacks = require 'snacks'

keymap('n', '<space>', '<Nop>', { desc = 'Disable default space movement (used as leader)' })

keymap(
  'n',
  'j',
  function() return tonumber(vim.api.nvim_get_vvar 'count') > 0 and 'j' or 'gj' end,
  { expr = true, silent = true, desc = 'Move down (gj when no count given)' }
)
keymap(
  'n',
  'k',
  function() return tonumber(vim.api.nvim_get_vvar 'count') > 0 and 'k' or 'gk' end,
  { expr = true, silent = true, desc = 'Move up (gk when no count given)' }
)
keymap('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center cursor' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center cursor' })
keymap('n', '<Leader>w', '<cmd>w!<CR>', vim.tbl_extend('force', s, { desc = 'Save file' }))
keymap('n', '<Leader>q', '<cmd>q<CR>', vim.tbl_extend('force', s, { desc = 'Quit' }))
keymap('n', '<Leader>te', '<cmd>tabnew<CR>', vim.tbl_extend('force', s, { desc = 'Open new tab' }))
keymap('n', '<Leader>_', '<cmd>vsplit<CR>', vim.tbl_extend('force', s, { desc = 'Split window vertically' }))
keymap('n', '<Leader>-', '<cmd>split<CR>', vim.tbl_extend('force', s, { desc = 'Split window horizontally' }))
keymap('v', '<Leader>p', '"_dP', { desc = 'Paste without overwriting default register' })
-- copy and paste system clipboard on demand
keymap('n', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
keymap('v', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
keymap('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })
keymap('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
keymap('v', '<leader>P', '"+p', { desc = 'Paste from system clipboard (visual)' })

keymap('t', '<Esc>', '<C-\\><C-N>', { desc = 'Exit terminal mode' })
keymap('n', '<leader>cd', '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>', { desc = 'Change directory' })

keymap('n', 'grd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts) -- Go to definition

keymap('n', '<leader>ps', '<cmd>lua vim.pack.update()<CR>', { desc = 'Update plugins' })

keymap('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
-- Move the visually selected lines into a new horizontal split.
keymap('x', '<Leader>mw', ':d | new +put! "<CR>', { silent = true, desc = 'Move selection to new split' })

-- Insert the current file's path at the cursor position (relative to cwd).
-- %  -> current file path
-- Use ':p' for the absolute path instead: vim.fn.expand('%:p')
keymap(
  'n',
  '<Leader>fp',
  function() vim.api.nvim_put({ vim.fn.expand '%' }, 'c', true, true) end,
  { silent = true, desc = 'Insert relative file path' }
)

-- Alternative: copy the file path to the system clipboard
keymap('n', '<Leader>fy', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
  vim.notify('Copied: ' .. vim.fn.expand '%:p')
end, { silent = true, desc = 'Yank absolute file path to clipboard' })
-- clear search highlight and LSP document-highlight references in one press
keymap('n', '<Esc>', function()
  vim.cmd 'nohlsearch'
  pcall(vim.lsp.buf.clear_references)
end, { desc = 'Clear search highlight and LSP references' })
-- django terminal
local venv_bin = vim.fn.getcwd() .. '/.venv/bin'
local function django_term(cmd)
  return function()
    Snacks.terminal(cmd, {
      cwd = vim.fn.getcwd(),
      env = { PATH = venv_bin .. ':' .. vim.env.PATH },
      win = { position = 'float' },
    })
  end
end
keymap('n', '<leader>dr', django_term 'python manage.py runserver', { desc = 'Django runserver' })
keymap('n', '<leader>dm', django_term 'python manage.py migrate', { desc = 'Django migrate' })
keymap('n', '<leader>dk', django_term 'python manage.py makemigrations', { desc = 'Django makemigrations' })
-- snacks keybindings
keymap('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = 'Smart Find Files' })
keymap('n', '<leader>,', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
keymap('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
keymap('n', '<leader>n', function() Snacks.picker.notifications() end, { desc = 'Notification History' })
keymap('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File Explorer' })
-- find
keymap(
  'n',
  '<leader>fc',
  function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
  { desc = 'Find Config File' }
)
keymap('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find Files' })
keymap('n', '<leader>fg', function() Snacks.picker.git_files() end, { desc = 'Find Git Files' })
keymap('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Recent' })

-- git
keymap('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git Branches' })
keymap('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git Log' })
keymap('n', '<leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'Git Log Line' })
keymap('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
keymap('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
keymap('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
keymap('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Log File' })

-- github
keymap('n', '<leader>gi', function() Snacks.picker.gh_issue() end, { desc = 'GitHub Issues (open)' })
keymap('n', '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, { desc = 'GitHub Issues (all)' })
keymap('n', '<leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub Pull Requests (open)' })
keymap('n', '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, { desc = 'GitHub Pull Requests (all)' })

-- grep / search
keymap('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
keymap('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
keymap('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
keymap({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Visual selection or word' })
keymap('n', '<leader>sr', function() Snacks.picker.registers() end, { desc = 'Registers' })
keymap('n', '<leader>sh', function() Snacks.picker.search_history() end, { desc = 'Search History' })
keymap('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Autocmds' })
keymap('n', '<leader>sc', function() Snacks.picker.command_history() end, { desc = 'Command History' })
keymap('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' })
keymap('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
keymap('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
keymap('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
keymap('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' })
keymap('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
keymap('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
keymap('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Location List' })
keymap('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
keymap('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' })
keymap('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = 'Search for Plugin Spec' })
keymap('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
keymap('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })
keymap('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
keymap('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })

-- Other
keymap('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
keymap('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom' })
keymap('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
keymap('n', '<leader>S', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
keymap('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
keymap('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
keymap({ 'n', 'v' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
keymap('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
keymap('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
keymap({ 'n', 't' }, '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
keymap({ 'n', 't' }, '<c-_>', function() Snacks.terminal() end, { desc = 'which_key_ignore' })
keymap({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
keymap({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })
keymap(
  'n',
  '<leader>N',
  function()
    Snacks.win {
      file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
      width = 0.6,
      height = 0.6,
      wo = { spell = false, wrap = false, signcolumn = 'yes', statuscolumn = ' ', conceallevel = 3 },
    }
  end,
  { desc = 'Neovim News' }
)

--  vim: set ts=2 sts=2 sw=2 et :
