return {
	{
		"echasnovski/mini.bracketed",
		version = "*",
		config = function()
			local mini_bracketed = require("mini.bracketed")
			mini_bracketed.setup()
		end,
	},

	{
		"echasnovski/mini.indentscope",
		version = "*",
		config = function()
			local mini_indentscope = require("mini.indentscope")
			mini_indentscope.setup()
		end,
	},

	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			local mini_surround = require("mini.surround")
			mini_surround.setup({
				options = {
					add_spaces = false, -- Disable adding spaces
				},
			})
		end,
	},
}
