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
			transparent_background = true, -- don't set a background color (let the terminal show through)
			float = {
				transparent = true, -- transparent floating windows
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
	end,
}
