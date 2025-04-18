local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then
  return
end

local dashboard_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not dashboard_ok then
  return
end

local logo = [[





  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

]]

local function getGreeting(name)
  local tableTime = os.date("*t")
  local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
  local hour = tableTime.hour
  local greetingsTable = {
    [1] = "  Sleep well",
    [2] = "  Good morning",
    [3] = "  Good afternoon",
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
  return "\t" .. datetime .. "\t" .. greetingsTable[greetingIndex] .. ", " .. name
end

local userName = "Denes"
local greeting = getGreeting(userName)
dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")

dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  dashboard.button("w", "󰷾  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("r", "  Recents", ":Telescope oldfiles<CR>"),
  dashboard.button("t", "  Themes", ":Telescope colorscheme<CR>"),
  dashboard.button("e", "  Explore", ":BrowseFiles<CR>"),
  dashboard.button("p", "󰏗  Lazy", ":Lazy<CR>"),
  dashboard.button("m", "  Mason", ":Mason<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    local version = "  󰥱 v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
    local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    local footer = version .. "\t" .. plugins .. "\n"
    dashboard.section.footer.val = footer
    pcall(vim.cmd.AlphaRedraw)
  end,
})
