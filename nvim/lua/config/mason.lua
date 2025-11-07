require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"denols",
		"ts_ls",
		"terraformls",
		"pyright",
		"rust_analyzer",
	},
})
require("mason-tool-installer").setup({
	-- a list of all tools you want to ensure are installed upon
	-- start
	ensure_installed = {
		"codelldb",
		"cpptools",
		"pylint",
		"black",
		"stylua",
	},
	auto_update = false,
	run_on_start = true,
	start_delay = 3000, -- 3 second delay
	debounce_hours = 5, -- at least 5 hours between attempts to install/update
	integrations = {
		["mason-lspconfig"] = true,
	},
})
