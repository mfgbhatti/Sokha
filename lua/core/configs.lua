-- ~/.config/nvim/lua/core/configs.lua
-- colorscheme
vim.cmd.colorscheme 'murphy' -- catppuccin murphy
vim.g.have_nerd_font = true
local opt = vim.opt

-- Copy the indentation
opt.autoindent = true
-- Convert tabs to spaces
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
-- Round indentation
opt.shiftround = true
-- Visibiloty
opt.list = true
opt.listchars = {
  tab = '→ ', -- shown at the start of a tab character
  trail = '•', -- trailing whitespace at the end of a line
  eol = '↵', -- end-of-line marker
  extends = '»', -- line continues off-screen to the right (when wrap=off)
  precedes = '«', -- line continues off-screen to the left
}
-- Case-insensitive search by default...
opt.ignorecase = true
opt.smartcase = true
-- Don't highlight
opt.hlsearch = false
opt.inccommand = 'split'
-- Draw a vertical guide line
opt.colorcolumn = '80'
-- Always reserve space
opt.signcolumn = 'yes:1'
-- Enable 24-bit RGB colors
opt.termguicolors = true
-- Line numbers --off-for-mobile
opt.number = false
opt.relativenumber = false
opt.numberwidth = 2
-- Disable soft line wrapping;
opt.wrap = false
-- Highlight the line the cursor is currently on.
opt.cursorline = true
-- Use one status line for the whole Neovim instance
opt.laststatus = 3
-- Height (in lines) of the command-line
opt.cmdheight = 1
-- Don't show the current mode
opt.showmode = false
-- Open new vertical splits
opt.splitright = true
-- Open new horizontal splits
opt.splitbelow = true
-- Keep at least 8 lines visible
-- above/below the cursor when scrolling.
opt.scrolloff = 8
-- Don't create .swp swap files.
opt.swapfile = false
-- Keep a persistent undo history
opt.undofile = true
-- Ask for confirmation
opt.confirm = true
-- Enable filetype detection plus filetype-specific plugins and indent
-- rules (needed for things like per-language indentation and syntax).
vim.cmd.filetype 'plugin indent on'
-- How the native completion popup menu behaves:
--   menu     - popup menu for multichoice
--   menuone  - popup menu even for a single match
--   noselect - don't auto-select the first match;
--   popup    - show extra info in a popup
--   fuzzy    - allow fuzzy (not just prefix) matching
opt.completeopt = 'menu,menuone,noselect,popup,fuzzy'
--   .  current buffer   
--   w  other open windows   
--   b  other loaded buffers
--   u  unloaded buffers 
--   t  tags
-- (Add "o" here if you want LSP omnifunc
opt.complete = '.,w,b,u,t'
-- Max number of items visible in the completion
-- popup before scrolling.
opt.pumheight = 10
-- ms of inactivity before triggering CursorHold, etc.
opt.updatetime = 250
-- Decrease mapped sequence wait time
opt.timeoutlen = 350
--enable mouse support in all modes
-- opt.mouse = 'a'
-- yank/delete/paste use the system
-- opt.clipboard = 'unnamedplus'
-- Command-line completion (native wildmenu,
-- unrelated to blink.cmp that only powers
-- buffer/insert-mode completion
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildoptions = 'pum'
opt.wildignore = '*.o,*.pyc,*/node_modules/*,*/.git/*'

-- vim: set ts=2 sts=2 sw=2 et :
