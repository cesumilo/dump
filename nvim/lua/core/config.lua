-- Use spaces instead of tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- set color scheme
-- colorscheme catppuccin  catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
vim.cmd.colorscheme("catppuccin")

-- hybrid line number
vim.cmd.set("number", "relativenumber")
vim.cmd.set("nu", "rnu")

-- Don't diplay .uid files
vim.opt.wildignore:append("*.uid")
vim.g.netrw_list_hide = ".*\\.uid$"
vim.g.netrw_hide = 1 -- 1 = hide files matching netrw_list_hide
