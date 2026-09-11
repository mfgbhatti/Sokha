-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  plugin = {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
  config = function()
    require('nvim-treesitter').setup()

    local parsers = {
      'lua',
      'vim',
      'vimdoc',
      'query',
      'bash',
      'markdown',
      'markdown_inline',
      'python',
      'javascript',
      'typescript',
      'json',
      'yaml',
    }

    local ts_config = require 'nvim-treesitter.config'
    local installed = ts_config.get_installed()
    local to_install = vim.tbl_filter(function(lang) return not vim.tbl_contains(installed, lang) end, parsers)

    if #to_install > 0 then
      vim.notify('Installing treesitter parsers: ' .. table.concat(to_install, ', '), vim.log.levels.INFO)
      require('nvim-treesitter').install(to_install, { summary = false })
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        local cfg = require 'nvim-treesitter.config'

        if vim.tbl_contains(cfg.get_installed(), lang) then
          pcall(vim.treesitter.start, args.buf)
          return
        end
        if not vim.tbl_contains(cfg.get_available(), lang) then return end

        vim.notify('Installing treesitter parser: ' .. lang, vim.log.levels.INFO)
        require('nvim-treesitter').install({ lang }, { summary = false })

        local timer = assert(vim.uv.new_timer())
        timer:start(
          500,
          500,
          vim.schedule_wrap(function()
            if vim.tbl_contains(require('nvim-treesitter.config').get_installed(), lang) then
              timer:stop()
              timer:close()
              if vim.api.nvim_buf_is_valid(args.buf) then
                pcall(vim.treesitter.start, args.buf)
                vim.notify('Treesitter parser installed: ' .. lang, vim.log.levels.INFO)
              end
            end
          end)
        )
      end,
    })
  end,
}
