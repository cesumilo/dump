require("noice").setup({
	lsp = {
		hover = {
			enabled = true,
		},
		signature = {
			enabled = true,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true, -- adds border to hover docs
	},
	views = {
		cmdline_popup = {
			position = {
				row = "95%", -- Bottom of screen
				col = "50%", -- Centered horizontally
			},
		},
	},
})
