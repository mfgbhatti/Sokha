-- ~/.config/nvim/lua/plugins/fidget.lua
return {
  plugin = {
    src = 'https://github.com/j-hui/fidget.nvim',
  },
  config = function()
    require('fidget').setup {}
  end,
}
