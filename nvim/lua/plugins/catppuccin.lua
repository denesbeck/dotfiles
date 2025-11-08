return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local ok, catppuccin = pcall(require, "catppuccin")
		if not ok then
			return
		end

		catppuccin.setup({
			flavour = "frappe",
			background = {
				dark = "frappe",
			},
			transparent_background = false, -- disables setting the background color.
			float = {
				transparent = false, -- enable transparent floating windows
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		})

		-- Apply colorscheme
		vim.cmd.colorscheme("catppuccin")

		-- Set transparent background
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	end,
}
