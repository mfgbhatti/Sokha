-- ~/.config/nvim/init.lua
-- Enable the new Lua loader for faster startup
if vim.loader then vim.loader.enable() end
-- leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'plugins'
require 'core'
