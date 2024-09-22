-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'tpope/vim-fugitive',
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      function(_, opts)
        table.insert(opts.sections.lualine_x, {
          function()
            local status = require('ollama').status()

            if status == 'IDLE' then
              return '󱙺' -- nf-md-robot-outline
            elseif status == 'WORKING' then
              return '󰚩' -- nf-md-robot
            end
          end,
          cond = function()
            return package.loaded['ollama'] and require('ollama').status() ~= nil
          end,
        })
      end,
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
