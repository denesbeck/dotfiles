return {
	"romus204/tree-sitter-manager.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("tree-sitter-manager").setup({
			auto_install = true,
			highlight = true,
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"ruby",
				"sql",
				"terraform",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
		})
	end,
}
