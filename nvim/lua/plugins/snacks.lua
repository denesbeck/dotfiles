local vim = vim

local function getGreeting(name)
	local tableTime = os.date("*t")
	local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
	local hour = tableTime.hour
	local greetingsTable = {
		[1] = "  Sleep well",
		[2] = "  Good morning",
		[3] = "  Good afternoon",
		[4] = "  Good evening",
		[5] = "󰖔  Good night",
	}
	local greetingIndex = 0
	if hour == 23 or hour < 7 then
		greetingIndex = 1
	elseif hour < 12 then
		greetingIndex = 2
	elseif hour >= 12 and hour < 18 then
		greetingIndex = 3
	elseif hour >= 18 and hour < 21 then
		greetingIndex = 4
	elseif hour >= 21 then
		greetingIndex = 5
	end
	return datetime .. "\t" .. greetingsTable[greetingIndex] .. ", " .. name
end

local userName = os.getenv("USER") or vim.loop.os_get_passwd().username or "User"
local greeting = getGreeting(userName)

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dim = { enabled = true },
		explorer = { enabled = true },
		notifier = { enabled = true },
		picker = { enabled = true },
		bigfile = { enabled = true },
		dashboard = {
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
					{
						icon = "󰷾 ",
						key = "w",
						desc = "Find Text",
						action = ":lua Snacks.picker.grep()",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.picker.recent()",
					},
					{
						icon = " ",
						key = "t",
						desc = "Themes",
						action = ":lua Snacks.picker.colorschemes()",
					},
					{
						icon = " ",
						key = "e",
						desc = "Explore",
						action = ":lua Snacks.explorer({ hidden = true, ignored = true, jump = { close = true }, tree = true, layout = { preset = 'dropdown', preview = false }})",
					},
					{
						icon = "󰒲 ",
						key = "p",
						desc = "Lazy",
						action = ":Lazy",
					},
					{
						icon = " ",
						key = "m",
						desc = "Mason",
						action = ":Mason",
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},

			sections = {
				{ section = "header" },
				{ title = greeting, padding = 2, align = "center" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"\\\\",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer({
					hidden = true,
					ignored = true,
					jump = { close = true },
					tree = true,
					layout = { preset = "dropdown", preview = false },
				})
			end,
			desc = "File Explorer",
		},
		-- find
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fF",
			function()
				Snacks.picker.files({ hidden = true, ignored = true })
			end,
			desc = "Find All Files",
		},
		{
			"<leader>fw",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fW",
			function()
				Snacks.picker.grep({ hidden = true, ignored = true })
			end,
			desc = "Grep All",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			";;",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>ft",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
	},
}
