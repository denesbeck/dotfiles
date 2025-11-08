return {
	"nvimtools/none-ls.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local ok, null_ls = pcall(require, "null-ls")
		if not ok then
			return
		end

		local sources = {
			null_ls.builtins.formatting.gofumpt,
			null_ls.builtins.formatting.goimports_reviser,
			null_ls.builtins.formatting.nginx_beautifier,
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.rustywind,
			null_ls.builtins.formatting.shfmt.with({
				extra_args = { "-i", "2", "-ci" },
			}),
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.terraform_fmt,
		}

		---@diagnostic disable-next-line: undefined-global
		local vim = vim

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
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
	end,
}
