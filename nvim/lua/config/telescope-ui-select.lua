require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- Options:
				-- get_dropdown {}
				-- get_cursor {}
				-- get_ivy {}
			}),
		},
	},
})

-- Must be called after telescope.setup()
require("telescope").load_extension("ui-select")
