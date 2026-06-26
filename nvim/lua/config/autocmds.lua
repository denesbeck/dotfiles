---@diagnostic disable-next-line: undefined-global
local vim = vim

-- highlight yanked text for 100ms using the "Visual" highlight group
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})
