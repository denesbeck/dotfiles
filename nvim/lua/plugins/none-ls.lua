return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"williamboman/mason.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local ok, null_ls = pcall(require, "null-ls")
		if not ok then
			return
		end

		local sources = {
			null_ls.builtins.formatting.biome,
			null_ls.builtins.formatting.goimports_reviser,
			null_ls.builtins.formatting.nginx_beautifier,
			null_ls.builtins.formatting.prettier.with({
				filetypes = { "yaml", "markdown", "markdown.mdx", "html" },
			}),
			null_ls.builtins.formatting.rustywind,
			null_ls.builtins.formatting.shfmt.with({
				extra_args = { "-i", "2", "-ci" },
			}),
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.terraform_fmt,
		}

		null_ls.setup({
			sources = sources,
		})

		-- Auto-install the external tools the sources above rely on.
		local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
		if mason_null_ls_ok then
			mason_null_ls.setup({
				ensure_installed = nil, -- install whatever the configured null-ls sources need
				automatic_installation = {
					exclude = { "goimports_reviser", "terraform_fmt", "nginx_beautifier" },
				},
			})
		end
	end,
}
