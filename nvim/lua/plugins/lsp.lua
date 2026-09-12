return {
	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			local mason_ok, mason = pcall(require, "mason")
			if not mason_ok then
				return
			end

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Mason LSP Config
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
			if not mason_lsp_ok then
				return
			end

			mason_lspconfig.setup({
				ensure_installed = require("config.servers"),
				automatic_enable = false,
			})
		end,
	},

	-- LSP servers
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim" },
		config = function()
			---@diagnostic disable: undefined-global
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if cmp_lsp_ok then
				capabilities = cmp_lsp.default_capabilities()
			end

			vim.lsp.config("*", { capabilities = capabilities })

			for _, server in ipairs(require("config.servers")) do
				vim.lsp.enable(server)
			end

			-- terraform-ls's semantic-token response sends Neovim's semantic-token
			-- highlighter into a 100% CPU loop on some buffers (freezes on open).
			-- Disable semantic tokens for this server only; everything else keeps them.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("terraformls_no_semantic_tokens", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "terraformls" then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})
		end,
	},

	-- LSP Saga
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			---@diagnostic disable: undefined-global
			local ok, lspsaga = pcall(require, "lspsaga")
			if not ok then
				return
			end

			lspsaga.setup({
				symbol_in_winbar = {
					folder_level = 3,
				},
			})

			local opts = { noremap = true, silent = true }

			vim.keymap.set("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)
			vim.keymap.set("n", "<leader>pd", "<Cmd>Lspsaga peek_definition<CR>", opts)
			vim.keymap.set("n", "<leader>cd", "<Cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
			vim.keymap.set("n", "<leader>ld", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
			vim.keymap.set("n", "<leader>bd", "<Cmd>Lspsaga show_buf_diagnostics<CR>", opts)
			vim.keymap.set("n", "<leader>wd", "<Cmd>Lspsaga show_workspace_diagnostics<CR>", opts)
			vim.keymap.set("n", "<leader>jn", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			vim.keymap.set("n", "<leader>jp", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
			vim.keymap.set("n", "<leader>fd", "<Cmd>Lspsaga finder<CR>", opts)
			vim.keymap.set("n", "<leader>tt", "<Cmd>Lspsaga term_toggle<CR>", opts)
			vim.keymap.set("n", "<leader>hd", "<Cmd>Lspsaga hover_doc<CR>", opts)
			vim.keymap.set("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
		end,
	},
}
