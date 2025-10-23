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

vim.lsp.config("ansiblels", {
	capabilities = capabilities,
})
vim.lsp.enable("ansiblels")

vim.lsp.config("bashls", {
	capabilities = capabilities,
})
vim.lsp.enable("bashls")

vim.lsp.config("cssls", {
	capabilities = capabilities,
})
vim.lsp.enable("cssls")

vim.lsp.config("dockerls", {
	capabilities = capabilities,
})
vim.lsp.enable("dockerls")

vim.lsp.config("eslint", {
	capabilities = capabilities,
})
vim.lsp.enable("eslint")

vim.lsp.config("gopls", {
	capabilities = capabilities,
})
vim.lsp.enable("gopls")

vim.lsp.config("html", {
	capabilities = capabilities,
})
vim.lsp.enable("html")

vim.lsp.config("jsonls", {
	capabilities = capabilities,
})
vim.lsp.enable("jsonls")

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
})
vim.lsp.enable("lua_ls")

vim.lsp.config("pyright", {
	capabilities = capabilities,
})
vim.lsp.enable("pyright")

vim.lsp.config("sqlls", {
	capabilities = capabilities,
})
vim.lsp.enable("sqlls")

vim.lsp.config("tailwindcss", {
	capabilities = capabilities,
})
vim.lsp.enable("tailwindcss")

vim.lsp.config("terraformls", {
	capabilities = capabilities,
})
vim.lsp.enable("terraformls")

vim.lsp.config("ts_ls", {
	capabilities = capabilities,
})
vim.lsp.enable("ts_ls")

vim.lsp.config("yamlls", {
	capabilities = capabilities,
})
vim.lsp.enable("yamlls")
