local dap = require("dap")

-- Direct launch approach using netcoredbg to start Godot-Mono
dap.adapters.coreclr = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
	args = {
		"--interpreter=vscode",
	},
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Godot - Launch (macOS)",
		request = "launch",
		-- macOS application bundles hide the executable inside the Contents/MacOS folder.
		-- Change this if your Godot app has a different name (e.g., Godot_mono.app)
		program = "/Applications/Godot.app/Contents/MacOS/Godot",
		cwd = "${workspaceFolder}",
		-- Tells Godot to run the project located in the Neovim working directory
		args = { "--path", "${workspaceFolder}" },
		stopAtEntry = false,
	},
}

-- DAP UI
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui"] = function()
	dapui.close()
end

-- Keymaps
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dq", function()
	require("dap").terminate()
end, { desc = "Quit debugger" })
