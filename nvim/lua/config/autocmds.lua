---@diagnostic disable-next-line: undefined-global
local vim = vim

-- highlight yanked text for 100ms using the "Visual" highlight group
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})

local format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

local function format_buffer(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/formatting" })
	local has_null_ls = vim.iter(clients):any(function(client)
		return client.name == "null-ls"
	end)

	vim.lsp.buf.format({
		bufnr = bufnr,
		async = false,
		filter = function(client)
			if has_null_ls then
				return client.name == "null-ls"
			end
			return true
		end,
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or not client:supports_method("textDocument/formatting") then
			return
		end

		vim.api.nvim_clear_autocmds({ group = format_group, buffer = args.buf })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = format_group,
			buffer = args.buf,
			callback = function()
				format_buffer(args.buf)
			end,
		})
	end,
})
