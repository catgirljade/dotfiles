vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
	{ import = "plugins" },
}, lazy_config)

-- toggle term
require("toggleterm").setup({})

require("options")
require("autocmds")

vim.cmd([[
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_disable_italic_comment = 1
]])

-- vim.cmd.colorscheme("palenightfall")
vim.schedule(function()
	require("mappings")
end)
