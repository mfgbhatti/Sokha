-- ~/.config/nvim/lua/plugins/mason.lua
return {
  plugin = {
    src = 'https://github.com/mason-org/mason.nvim',
  },
  config = function()
    require('mason').setup {}
  end,
}
