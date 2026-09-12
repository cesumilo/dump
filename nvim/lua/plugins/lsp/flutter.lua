return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("flutter-tools").setup({
			ui = { border = "rounded" },
			decorations = {
				statusline = {
					app_version = true,
					device = true,
					project_config = true,
				},
			},
			widget_guides = { enabled = true },
			dev_tools = { autostart = true, autorestart_on_flutter_restart = true },
			debugger = {
				enabled = true,
				register_configurations = function(paths)
					require("dap").configurations.dart = {
						{
							type = "dart",
							request = "launch",
							name = "Launch flutter",
							dartSdkPath = paths.dart_sdk,
							flutterPath = paths.flutter,
							program = "${workspaceFolder}/lib/main.dart",
							cwd = "${workspaceFolder}",
						},
					}
				end,
			},
		})
	end,
}
