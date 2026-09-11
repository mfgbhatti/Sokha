-- Highlight todo, notes, etc in comments
return {
  plugin = {
    src = 'https://github.com/folke/todo-comments.nvim',
  },
  config = function() require('todo-comments').setup { signs = false } end,
}
