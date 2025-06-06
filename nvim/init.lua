local HOME = os.getenv("HOME")
require("config.lazy")

-- Use spaces instead of tabs
local set = vim.opt -- set options
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.autoindent = true

-- Note: <D- is mapped to cmd key
--
-- Mapping function
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Find files using Telescope command-line sugar.
map("n", "<D-f>", "<cmd>Telescope find_files<cr>")
map("n", "<D-g>", "<cmd>Telescope live_grep<cr>")
map("n", "<D-b>", "<cmd>Telescope buffers<cr>")
-- map('n', '<D-h>', '<cmd>Telescope help_tags<cr>')
map("n", "<S-k>", vim.lsp.buf.hover) -- display symbol doc on cursor
map("n", "E", vim.diagnostic.open_float) -- open diagnostic error
map("n", "gf", vim.lsp.buf.declaration) -- go to declaration
map("n", "gd", vim.lsp.buf.definition) -- go to definition

-- set color scheme
-- colorscheme catppuccin  catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
vim.cmd.colorscheme("catppuccin")

-- Escape to exit terminal
map("t", "<Esc>", "<C-\\><C-n>")

-- hybrid line number
vim.cmd.set("number", "relativenumber")
vim.cmd.set("nu", "rnu")

-- mason
require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = {
		"jdtls",
		"omnisharp",
		"pyright",
		"sqlls",
		"terraformls",
		"lua_ls",
		"denols",
		"ts_ls",
	},
})
require("mason-tool-installer").setup({
	-- a list of all tools you want to ensure are installed upon
	-- start
	ensure_installed = {
		"codelldb",
		"cpptools",
		"js-debug-adapter",
		"pyright",
		"pylint",
		"black",
		"csharpier",
		"netcoredbg",
		"omnisharp",
		"rust-analyzer",
		"csharpier",
		"jdtls",
		"kotlin-language-server",
		"sqlls",
		"terraformls",
		"stylua",
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	-- Default: false
	auto_update = false,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	-- Default: true
	run_on_start = true,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	-- Default: 0
	start_delay = 3000, -- 3 second delay

	-- Only attempt to install if 'debounce_hours' number of hours has
	-- elapsed since the last time Neovim was started. This stores a
	-- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
	-- This is only relevant when you are using 'run_on_start'. It has no
	-- effect when running manually via ':MasonToolsInstall' etc....
	-- Default: nil
	debounce_hours = 5, -- at least 5 hours between attempts to install/update

	-- By default all integrations are enabled. If you turn on an integration
	-- and you have the required module(s) installed this means you can use
	-- alternative names, supplied by the modules, for the thing that you want
	-- to install. If you turn off the integration (by setting it to false) you
	-- cannot use these alternative names. It also suppresses loading of those
	-- module(s) (assuming any are installed) which is sometimes wanted when
	-- doing lazy loading.
	integrations = {
		["mason-lspconfig"] = true,
		["mason-nvim-dap"] = true,
	},
})

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
)
equire("cmp_git").setup() ]]
--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- deno
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.g.markdown_fenced_languages = {
	"ts=typescript",
	"rs=rust",
}

local nvim_lsp = require("lspconfig")

if vim.fs.root(0, { "deno.json", "deno.jsonc" }) then
	nvim_lsp.denols.setup({
		on_attach = on_attach,
		root_dir = nvim_lsp.util.root_pattern({ "deno.json", "deno.jsonc" }),
		capabilities = capabilities,
	})
end

-- Rust
nvim_lsp.rust_analyzer.setup({
	root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json"),
	capabilities = capabilities,
})

-- Python
nvim_lsp.pyright.setup({})

-- Setup Commenter
map("n", "<D-/>", "<cmd>CommentToggle<cr>")

-- Format
map("n", "<Shift-f>", "<cmd>Neoformat<cr>")

-- C#
-- For future me: when opening a Godot project, make sure to first build it one time before doubting about the lsp.
nvim_lsp.omnisharp.setup({
	cmd = { "dotnet", HOME .. "/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
	},
	root_dir = nvim_lsp.util.root_pattern("*.csproj"),
	capabilities = capabilities,
	settings = {
		FormattingOptions = {
			-- Enables support for reading code style, naming convention and analyzer
			-- settings from .editorconfig.
			EnableEditorConfigSupport = true,
			-- Specifies whether 'using' directives should be grouped and sorted during
			-- document formatting.
			OrganizeImports = true,
		},
		MsBuild = {
			-- If true, MSBuild project system will only load projects for files that
			-- were opened in the editor. This setting is useful for big C# codebases
			-- and allows for faster initialization of code navigation features only
			-- for projects that are relevant to code that is being edited. With this
			-- setting enabled OmniSharp may load fewer projects and may thus display
			-- incomplete reference lists for symbols.
			LoadProjectsOnDemand = false,
		},
		RoslynExtensionsOptions = {
			-- Enables support for roslyn analyzers, code fixes and rulesets.
			EnableAnalyzersSupport = true,
			-- Enables support for showing unimported types and unimported extension
			-- methods in completion lists. When committed, the appropriate using
			-- directive will be added at the top of the current file. This option can
			-- have a negative impact on initial completion responsiveness,
			-- particularly for the first few completion sessions after opening a
			-- solution.
			EnableImportCompletion = true,
			-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
			-- true
			AnalyzeOpenDocumentsOnly = true,
		},
		Sdk = {
			-- Specifies whether to include preview versions of the .NET SDK when
			-- determining which version to use for project loading.
			IncludePrereleases = true,
		},
	},
})

-- Typescript
if not vim.fs.root(0, { "deno.json", "deno.jsonc" }) then
	nvim_lsp.ts_ls.setup({})
end

-- Gradle and shit
nvim_lsp.jdtls.setup({})

-- Terraform
nvim_lsp.terraformls.setup({})

-- Treesitter
local configs = require("nvim-treesitter.configs")

configs.setup({
	-- Add a language of your choice
	ensure_installed = {
		"lua",
		"javascript",
		"typescript",
		"rust",
		"go",
		"terraform",
		"json",
		"c_sharp",
		"dart",
		"sql",
	},
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
	pattern = {
		"*.ts",
		"*.rs",
		"*.py",
		"*.js",
		"*.json",
		"*.yaml",
		"*.yml",
		"*.lua",
		"*.dart",
		"*.sql",
		"*.lua",
		"*.tf",
		"*.tfvars",
	},
	command = "silent Neoformat",
})

-- nvim-dap
-- Note: something is broken...
-- local dap, dapui = require("dap"), require("dapui")
--
-- dap.listeners.before.attach.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.launch.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end
--
-- map('n', '<C-b>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
-- map('n', '<C-d>', "<cmd>lua require'dap'.continue()<cr>")
-- map('n', '<C-n>', "<cmd>lua require'dap'.step_over()<cr>")
-- map('n', '<C-m>', "<cmd>lua require'dap'.step_into()<cr>")
-- map('n', '<C-i>', "<cmd>lua require'dap'.repl.open()<cr>")

-- nvim-dap rust
-- Use mason to install codelldb and cpptools (:MasonInstall codelldb cpptools)
local dap = require("dap")
dap.adapters.lldb = {
	id = "lldb",
	type = "server",
	port = "${port}",
	executable = {
		command = HOME .. "/.local/share/nvim/mason/bin/codelldb",
		args = { "--port", "${port}" },
		detached = vim.loop.os_uname().sysname ~= "Windows",
	},
}
dap.configurations.rust = {
	{
		name = "Launch file",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
		initCommands = function()
			-- Find out where to look for the pretty printer Python module
			local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

			local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
			local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

			local commands = {}
			local file = io.open(commands_file, "r")
			if file then
				for line in file:lines() do
					table.insert(commands, line)
				end
				file:close()
			end
			table.insert(commands, 1, script_import)

			return commands
		end,
	},
}

-- nvim-dap js/deno
-- Use mason to install js-debug-adapter (:MasonInstall js-debug-adapter)
require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = HOME .. "/.local/share/nvim/mason/bin/js-debug-adapter",
		-- 💀 Make sure to update this path to point to your installation
		args = { "${port}" },
	},
}
dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		runtimeExecutable = "deno",
		runtimeArgs = {
			"run",
			"--inspect-wait",
			"--allow-all",
		},
		program = "${file}",
		cwd = "${workspaceFolder}",
		attachSimplePort = 9229,
	},
}

-- nvim-dap godot
-- Use mason to install netcoredbg

local dap_utils = require("dap.utils")

--- Attempts to pick a process smartly.
---
--- Does the following:
--- 1. Gets all project files
--- 2. Build filter
--- 2a. If a single project is found then will filter for processes ending with project name.
--- 2b. If multiple projects found then will filter for processes ending with any of the project file names.
--- 2c. If no project files found then will filter for processes starting with "dotnet"
--- 3. If a single process matches then auto selects it. If multiple found then displays it user for selection.
local smart_pick_process = function(dap_utils, project_path)
	local filter = function(proc)
		if string.find(proc.name, "Godot") then
			-- matches Godot process names
			if string.find(proc.name, "--remote") then
				-- matches program ran in debug from the editor
				return true
			end
		end

		return false
	end

	local processes = dap_utils.get_processes()
	processes = vim.tbl_filter(filter, processes)

	if #processes == 0 then
		print("No dotnet processes could be found automatically. Try 'Attach' instead")
		return
	end

	return processes[1].pid
end

dap.adapters.coreclr = {
	type = "executable",
	command = HOME .. "/.local/share/nvim/mason/bin/netcoredbg",
	args = { "--interpreter=vscode" },
}
dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Attach (Smart)",
		request = "attach",
		-- processId = 18706
		-- processId = require('dap.utils').pick_process
		processId = function()
			local current_working_dir = vim.fn.getcwd()
			return smart_pick_process(dap_utils, current_working_dir) or dap.ABORT
		end,
	},
}

-- dart / flutter
nvim_lsp.dartls.setup({
	on_attach = on_attach,
	settings = {
		dart = {
			analysisExcludedFolders = {
				vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
				vim.fn.expand("$HOME/.pub-cache"),
				vim.fn.expand("/opt/homebrew"),
				vim.fn.expand("$HOME/.flutter/flutter"),
			},
		},
	},
})

-- nvim-dap-projects
-- Setup nvim-dap per project using root/.nvim-dap.lua
require("nvim-dap-projects").search_project_config()

-- Header generation
require("header").setup({
	file_name = true,
	author = "Guillaume Robin (contact@gdream.dev)",
	project = nil,
	date_created = true,
	date_created_fmt = "%Y-%m-%d %H:%M:%S",
	date_modified = true,
	date_modified_fmt = "%Y-%m-%d %H:%M:%S",
	line_separator = "------",
	copyright_text = nil,
})

-- Auto add header when saving file
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("AddHeader", { clear = true })

autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local header = require("header")
		if header and header.update_date_modified then
			header.update_date_modified()
		else
			vim.notify_once("header.update_date_modified is not available", vim.log.levels.WARN)
		end
	end,
	group = "AddHeader",
	desc = "Update header's date modified",
})

map("n", "X", "<cmd>AddHeader<cr>")
