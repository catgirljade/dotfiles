local o = vim.o
o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"

local opt = vim.opt

-- Indentations
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = false
opt.autoindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Appearance
opt.number = true
opt.termguicolors = true
opt.background = "dark"
opt.colorcolumn = "120"
opt.signcolumn = "yes"
opt.cmdheight = 1
-- opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.cursorlineopt = "screenline,number"
opt.completeopt = "menuone,noinsert,noselect"

-- Behavour
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undos")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.mouse:append("a")
opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "UTF-8"
vim.cmd("syntax on")
vim.cmd("set nocompatible")
vim.cmd("filetype plugin on")
--
-- vim.cmd([[
-- let g:python_recommended_style = 0
-- autocmd FileType python setlocal noexpandtab
-- ]])
