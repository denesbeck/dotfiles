return {
	-- Tailwind CSS Colors for CMP
	{
		"js-everts/cmp-tailwind-colors",
		config = function()
			local ok, tailwind = pcall(require, "cmp-tailwind-colors")
			if not ok then
				return
			end

			tailwind.setup({})
		end,
	},

	-- CMP
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			local ok, cmp = pcall(require, "cmp")
			if not ok then
				return
			end

			local luasnip_ok, luasnip = pcall(require, "luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						if luasnip_ok then
							luasnip.lsp_expand(args.body)
						end
					end,
				},
				formatting = {
					format = require("cmp-tailwind-colors").format,
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
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
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

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = require("config.servers")

			for _, lsp in ipairs(servers) do
				vim.lsp.config(lsp, { capabilities = capabilities })
				vim.lsp.enable(lsp)
			end

			-- terraform-ls's semantic-token response sends Neovim's semantic-token
			-- highlighter into a 100% CPU loop on some buffers (freezes on open).
			-- Disable semantic tokens for this server only; everything else keeps them.
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "terraformls" then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})
		end,
	},
}
