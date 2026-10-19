return {
	"nvim-treesitter/nvim-treesitter",
	opts = { ensure_installed = { "dart" } },
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)
	end,
}
