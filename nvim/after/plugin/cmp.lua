local ok, cmp = pcall(require, "cmp")
if not ok then
	return
end

cmp.setup({
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
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
local lspconfig = require("lspconfig")

lspconfig["ansiblels"].setup({
	capabilities = capabilities,
})
lspconfig["bashls"].setup({
	capabilities = capabilities,
})
lspconfig["cssls"].setup({
	capabilities = capabilities,
})
lspconfig["dockerls"].setup({
	capabilities = capabilities,
})
lspconfig["eslint"].setup({
	capabilities = capabilities,
})
lspconfig["gopls"].setup({
	capabilities = capabilities,
})
lspconfig["html"].setup({
	capabilities = capabilities,
})
lspconfig["jsonls"].setup({
	capabilities = capabilities,
})
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
})
lspconfig["pyright"].setup({
	capabilities = capabilities,
})
lspconfig["sqlls"].setup({
	capabilities = capabilities,
})
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
})
lspconfig["terraformls"].setup({
	capabilities = capabilities,
})
lspconfig["ts_ls"].setup({
	capabilities = capabilities,
})
