return {
  'vim-test/vim-test',
  init = function()
    vim.g['test#strategy'] = 'neovim'
    vim.g['test#python#runner'] = 'pytest'
    vim.g['test#bash#runner'] = 'bats'
    vim.keymap.set('t', '<C-o>', '<C-\\><C-n>')
    vim.keymap.set('n', '<leader>tf', vim.cmd.TestFile, { desc = '[T]est [f]ile' })
    vim.keymap.set('n', '<leader>tn', vim.cmd.TestNearest, { desc = '[T]est [n]earest' })
    vim.keymap.set('n', '<leader>tl', vim.cmd.TestLast, { desc = '[T]est [l]ast' })
  end,
}
