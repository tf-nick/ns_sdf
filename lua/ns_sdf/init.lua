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
	vim.cmd("command! SdfEnv :lua require'ns_sdf'.checkFile()")
end

return M
