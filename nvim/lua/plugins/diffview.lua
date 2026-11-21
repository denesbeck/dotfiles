return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
	init = function()
		vim.opt.diffopt:append({ "algorithm:histogram", "indent-heuristic", "linematch:60" })
	end,
	keys = {
		{ "<leader>dv", "<cmd>DiffviewOpen<CR>", desc = "Diff: working tree vs HEAD" },
		{ "<leader>dm", "<cmd>DiffviewOpen origin/HEAD...HEAD<CR>", desc = "Diff: branch vs default branch" },
		{ "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diff: current file history" },
		{ "<leader>dH", "<cmd>DiffviewFileHistory<CR>", desc = "Diff: repo history" },
		{ "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Diff: close" },
	},
	opts = {
		enhanced_diff_hl = true,
		view = {
			merge_tool = { layout = "diff3_mixed" },
		},
	},
}
