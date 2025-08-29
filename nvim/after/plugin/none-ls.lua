local ok, none_ls = pcall(require, "null-ls")
if not ok then
	return
end

local sources = {
	none_ls.builtins.formatting.gofumpt,
	none_ls.builtins.formatting.goimports_reviser,
	none_ls.builtins.formatting.prettierd,
	none_ls.builtins.formatting.rubocop,
	none_ls.builtins.formatting.rustywind,
	none_ls.builtins.formatting.shfmt.with({
		extra_args = { "-i", "2", "-ci" },
	}),
	none_ls.builtins.formatting.stylua,
	none_ls.builtins.formatting.terraform_fmt,
}

---@diagnostic disable-next-line: undefined-global
local vim = vim

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
none_ls.setup({
	sources = sources,
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						async = false,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
require("lspconfig").eslint.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})
