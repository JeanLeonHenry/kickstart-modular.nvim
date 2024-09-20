return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>hh', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H]arpoon menu' })
    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [a]dd' })
    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
    end, { desc = '[H]arpoon [r]emove' })

    vim.keymap.set('n', '<leader>hu', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<leader>hi', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<leader>ho', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>jj', function()
      harpoon:list():prev { ui_nav_wrap = true }
    end, { desc = 'Harpoon prev' })
    vim.keymap.set('n', '<leader>kk', function()
      harpoon:list():next { ui_nav_wrap = true }
    end, { desc = 'Harpoon next' })
  end,
}
