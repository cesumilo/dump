return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
	},
	config = function()
		-- =====================
		-- OmniSharp (C# LSP)
		-- =====================
		vim.lsp.config("omnisharp", {
			cmd = {
				vim.fn.stdpath("data") .. "/mason/bin/omnisharp",
				"--languageserver",
				"--hostPID",
				tostring(vim.fn.getpid()),
			},
			root_markers = { "*.sln", "*.csproj", "project.godot" },
			filetypes = { "cs" },
			settings = {
				FormattingOptions = {
					EnableEditorConfigSupport = true,
					OrganizeImports = true,
				},
				RoslynExtensionsOptions = {
					EnableAnalyzersSupport = true,
					EnableImportCompletion = true,
					EnableDecompilationSupport = true,
				},
			},
		})

		-- =====================
		-- GDScript LSP (Godot editor serves LSP on port 6005)
		-- =====================
		vim.lsp.config("gdscript", {
			cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			root_markers = { "project.godot" },
			filetypes = { "gd", "gdscript", "gdscript3" },
		})

		-- Enable both
		vim.lsp.enable({ "omnisharp", "gdscript" })

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buf, noremap = true, silent = true }
				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				-- Use omnisharp-extended for decompiled definitions
				if client and client.name == "omnisharp" then
					vim.keymap.set("n", "gd", require("omnisharp_extended").lsp_definition, opts)
					vim.keymap.set("n", "gr", require("omnisharp_extended").lsp_references, opts)
					vim.keymap.set("n", "gi", require("omnisharp_extended").lsp_implementation, opts)
				end

				-- 0.11: native completion (no nvim-cmp needed)
				if client and client:supports_method("textDocument/completion") then
					vim.lsp.completion.enable(true, client.id, ev.buf, {
						autotrigger = true,
					})
				end
			end,
		})
	end,
}
