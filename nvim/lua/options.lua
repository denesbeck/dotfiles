---@diagnostic disable-next-line: undefined-global
local vim = vim

vim.opt.breakindent = true -- Wrap indent to match  line start
vim.opt.clipboard = "unnamedplus" -- Connection to the system clipboard
vim.opt.cmdheight = 0 -- hide command line unless needed
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.expandtab = true -- Enable the use of space in tab
vim.opt.fileencoding = "utf-8" -- File content encoding for the buffer
vim.opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.infercase = true -- Infer cases in keyword completion
vim.opt.laststatus = 3 -- globalstatus
vim.opt.linebreak = true -- Wrap lines at 'breakat'
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.number = true -- Show numberline
vim.opt.preserveindent = true -- Preserve indent structure as much as possible
vim.opt.pumheight = 10 -- Height of the pop up menu
vim.opt.relativenumber = true -- Show relative numberline
vim.opt.scrolloff = 10 -- Number of lines to keep above and below the cursor
vim.opt.shiftwidth = 2 -- Number of space inserted for indentation
vim.opt.showmode = false -- Disable showing modes in command line
vim.opt.showtabline = 0 -- never display tabline
vim.opt.sidescrolloff = 10 -- Number of columns to keep at the sides of the cursor
vim.opt.smartcase = true -- Case sensitivie searching
vim.opt.smartindent = true -- Smarter autoindentation
vim.opt.tabstop = 2 -- Number of space in a tab
vim.opt.wrap = true -- Wrapping of lines longer than the width of window

vim.g.mapleader = ";" -- set leader key
vim.g.autoformat_enabled = true -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
vim.g.autopairs_enabled = true -- enable autopairs at start
vim.g.cmp_enabled = true -- enable completion at start

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"
