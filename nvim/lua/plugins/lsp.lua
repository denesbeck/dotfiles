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
		config = function()
			local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
			if not mason_lsp_ok then
				return
			end

			mason_lspconfig.setup({
				ensure_installed = {
					"ansiblels",
					"bashls",
					"biome",
					"cssls",
					"dockerls",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"pyright",
					"sqlls",
					"tailwindcss",
					"terraformls",
					"ts_ls",
					"yamlls",
				},
			})
		end,
	},

	-- LSP Config
	"neovim/nvim-lspconfig",

	-- LSP Saga
	{
		"glepnir/lspsaga.nvim",
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
