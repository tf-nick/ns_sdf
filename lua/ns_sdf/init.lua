local M = {}

function M.setup()
	vim.api.nvim_set_option("statusline", "Your text goes here")

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

-- Define a function to extract the value associated with the "defaultAuthId" key
function M.extractDefaultAuthId(filename)
	-- Open the project.json file in read mode
	local file = io.open(filename, "r")
	if not file then
		print("Error: Unable to open " .. filename)
		return nil
	end
	-- Read the content of the file
	local content = file:read("*all")
	-- Close the file
	file:close()
	-- Parse the content as JSON
	local json = require("rapidjson")
	local data = json.decode(content)
	-- Extract the value associated with the "defaultAuthId" key
	local defaultAuthId = data.defaultAuthId
	return defaultAuthId
end

function M.showEnvironment()
	local file = M.getCurrentDir() .. "/project.json"
	if M.file_exists(file) then
		local defaultAuthId = M.extractDefaultAuthId(file)
		print(defaultAuthId)
	else
		print("file does not exist")
	end
end

function M.configure_keymaps()
	vim.cmd("command! SdfEnv :lua require'ns_sdf'.showEnvironment()")
end

return M
