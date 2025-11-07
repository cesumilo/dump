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
		"*.sql",
		"*.lua",
		"*.tf",
		"*.tfvars",
	},
	command = "silent Neoformat",
})

-- Auto add header when saving file
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local header = require("header")
		if header and header.update_date_modified then
			header.update_date_modified()
		else
			vim.notify_once("header.update_date_modified is not available", vim.log.levels.WARN)
		end
	end,
	group = vim.api.nvim_create_augroup("AddHeader", { clear = true }),
	desc = "Update header's date modified",
})
