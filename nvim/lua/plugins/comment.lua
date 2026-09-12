return {
	"numToStr/Comment.nvim",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			opts = { enable_autocmd = false },
		},
	},
	config = function()
		local status, comment = pcall(require, "Comment")
		if not status then
			return
		end

		local ts_ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")

		comment.setup({
			pre_hook = ts_ok and ts_context.create_pre_hook() or nil,
		})
	end,
}
