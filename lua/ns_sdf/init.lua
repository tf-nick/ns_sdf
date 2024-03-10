local M = {}

function M.setup()
	print("setup function")
end

function M.file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

function M.getCurrentDir()
	return vim.fn.expand("%:p:h")
end

function M.checkFile()
	local file = M.getCurrentDir() .. "/project.json"
	if M.file_exists(file) then
		print("file exists")
	else
		print("file does not exist")
	end
end

function M.configure_keymaps()
	vim.api.nvim_set_keymap("v", "<Plug>SnipRun", ":lua require'sniprun'.run('v')<CR>", { silent = true })
	vim.api.nvim_set_keymap("n", "<Plug>SnipRun", ":lua require'sniprun'.run()<CR>", { silent = true })
	vim.api.nvim_set_keymap("n", "<Plug>SnipRunOperator", ":set opfunc=SnipRunOperator<CR>g@", { silent = true })
	vim.api.nvim_set_keymap("n", "<Plug>SnipReset", ":lua require'sniprun'.reset()<CR>", { silent = true })
	vim.api.nvim_set_keymap("n", "<Plug>SnipInfo", ":lua require'sniprun'.info()<CR>", {})
	vim.api.nvim_set_keymap(
		"n",
		"<Plug>SnipReplMemoryClean",
		":lua require'sniprun'.clear_repl()<CR>",
		{ silent = true }
	)
	vim.api.nvim_set_keymap("n", "<Plug>SnipClose", ":lua require'sniprun.display'.close_all()<CR>", { silent = true })

	vim.cmd("command! SnipReset :lua require'sniprun'.reset()")
	vim.cmd("command! SnipReplMemoryClean :lua require'sniprun'.clear_repl()")
	vim.cmd("function! SnipRunOperator(...) \n lua require'sniprun'.run('n') \n endfunction")
	vim.cmd("command! SnipClose :lua require'sniprun.display'.close_all()")

	vim.cmd(
		"function! ListInterpreters(A,L,P) \n let l = split(globpath('"
			.. M.config_values.sniprun_path
			.. "/doc/sources/interpreters', '*.md'),'\\n') \n let rl = [] \n for e in l \n let rl += [split(e,'/')[-1][:-4]] \n endfor \n return rl \n endfunction"
	)
	vim.cmd("command! -nargs=* -complete=customlist,ListInterpreters SnipInfo :lua require'sniprun'.info(<q-args>)")

	vim.cmd(
		"function! SnipRunLauncher(...) range \nif a:firstline == a:lastline \n lua require'sniprun'.run() \n elseif a:firstline == 1 && a:lastline == line(\"$\")\nlet g:sniprun_cli_args_list = a:000\n let g:sniprun_cli_args = join(g:sniprun_cli_args_list,\" \") \n lua require'sniprun'.run('w') \n else \n lua require'sniprun'.run('v') \n endif \n endfunction"
	)
	vim.cmd("command! -range -nargs=? SnipRun <line1>,<line2>call SnipRunLauncher(<q-args>)")
end

return M
