return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local ok, lualine = pcall(require, "lualine")
		if not ok then
			return
		end

		lualine.setup({})
	end,
}
