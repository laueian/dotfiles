local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	-- absolute path is important here, otherwise the argument in the `runInTerminal` request will default to $CWD/lldb-vscode
	-- command = "/usr/bin/lldb",
	command = "$(brew --prefix llvm)/bin/lldb-vscode",
	name = "lldb",
}

dap.adapters.python = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
	args = { "-m", "debugpy.adapter" },
}

dap.adapters.generic_remote = function(callback, config)
	callback({
		type = "server",
		host = "127.0.0.1",
		port = 5678,
	})
end

dap.configurations.cpp = {
	{
		name = "Launch lldb",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = true,
	},
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "/Users/ilaue/.pyenv/shims/python"
		end,
	},
	{
		type = "generic_remote",
		request = "attach",
		name = "Generic remote",
        cwd = vim.fn.getcwd();
        pathMappings = {
            {
                localRoot = vim.fn.getcwd(); -- Wherever your Python code lives locally.
                remoteRoot = function()
                    return vim.fn.input("Container code folder > ", "/opt/python-dynamic-segmentation" ,"file")
                end,


            },
        },
	},
}

-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp
