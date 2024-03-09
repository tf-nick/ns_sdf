local M = {}

function M.setup()
	print("setup function")
end

-- Check if a file exists in the current directory
local function fileExists(filename)
	local stat = vim.loop.fs_stat(filename)
	return stat and stat.type == "file"
end

-- Get the current working directory
local function getCurrentDirectory()
	return vim.fn.getcwd()
end

function M.checkFile()
	local filename = getCurrentDirectory() .. "/" .. "project.json"
	if fileExists(filename) then
		print("File exists:", filename)
	else
		print("File does not exist:", filename)
	end
end

return M
