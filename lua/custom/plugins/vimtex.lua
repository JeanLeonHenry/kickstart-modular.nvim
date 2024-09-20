return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    -- Check if the global variable exists
    if not vim.g.vim_window_id then
      -- Set the global variable using the result of a system command
      vim.g.vim_window_id = vim.fn.system 'xdotool getactivewindow'
    end

    -- Define the Lua function to focus Vim and redraw the screen
    function TexFocusVim()
      -- Give window manager time to recognize focus moved to Zathura
      -- Tweak the sleep time as needed for your hardware and window manager
      vim.cmd 'sleep 200m'

      -- Refocus Vim and redraw the screen
      vim.cmd('!xdotool windowfocus ' .. vim.g.vim_window_id)
      vim.cmd 'redraw!'
    end

    -- Define the autocommand group
    vim.cmd [[
		augroup vimtex_event_focus
		autocmd!
		autocmd User VimtexEventView lua TexFocusVim()
		augroup END
	]]

    vim.o.conceallevel = 2
    vim.o.fillchars = 'fold: '
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_quickfix_mode = 0
    -- vim.g.vimtex_fold_enabled = 1
    -- vim.g.vimtex_fold_types = {
    -- 	preamble = { enabled = 0 },
    -- 	comments = { enabled = 0 },
    -- 	cmd_single = { enabled = 0 },
    -- 	cmd_single_opt = { enabled = 0 },
    -- 	cmd_multi = { enabled = 0 },
    -- 	sections = { enabled = 0 },
    -- 	envs = {
    -- 		whitelist = { "solution" }
    -- 	},
    -- }
  end,
}
