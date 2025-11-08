return {
	{
		"windwp/nvim-autopairs",
		config = function()
			local ok, autopairs = pcall(require, "nvim-autopairs")
			if not ok then
				return
			end

			autopairs.setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		config = function()
			local ok, autotag = pcall(require, "nvim-ts-autotag")
			if not ok then
				return
			end

			autotag.setup({})
		end,
	},
}
