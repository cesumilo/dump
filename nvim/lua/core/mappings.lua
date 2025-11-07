-- Note: <D- is mapped to cmd key
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

-- LSP
map("n", "<S-k>", vim.lsp.buf.hover) -- display symbol doc on cursor
map("n", "E", vim.diagnostic.open_float) -- open diagnostic error
map("n", "gf", vim.lsp.buf.declaration) -- go to declaration
map("n", "gd", vim.lsp.buf.definition) -- go to definition

-- Escape to exit terminal
map("t", "<Esc>", "<C-\\><C-n>")

-- Setup Commenter
map("n", "<D-/>", "<cmd>CommentToggle<cr>")

-- Format
map("n", "<Shift-f>", "<cmd>Neoformat<cr>")

-- Header
map("n", "X", "<cmd>AddHeader<cr>")
