-- ~/.config/nvim/lua/plugins/mason.lua
vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup({})
