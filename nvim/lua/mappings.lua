--- @param modes string
--- @param lhs string
--- @param rhs string|function
--- @param opts table|nil
local map_multimode = function(modes, lhs, rhs, opts)
	if modes:len() == 0 then
		vim.keymap.set("", lhs, rhs, opts)
		return
	end

	for mode in modes:gmatch(".") do
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

local cmd_callback = function(command)
	return function()
		vim.api.nvim_command(command)
	end
end
local inject_keys = function(keys, mode)
	return function()
		return vim.cmd("normal " .. keys) --[[
            return vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(
                    keys,
                    true,
                    false,
                    true
                ),
                mode,
                true
            );]]
	end
end
local noremap = function(modes, lhs, rhs)
	map_multimode(modes, lhs, rhs, { remap = false })
end
local merge_tab = function(a, b)
	local c = {}
	for k, v in pairs(a) do
		c[k] = v
	end
	for k, v in pairs(b) do
		c[k] = v
	end
	return c
end

-- add yours here

local map = function(modes, lhs, rhs)
	map_multimode(modes, lhs, rhs, { remap = true, silent = true })
end

map("n", "<Esc>", cmd_callback("noh"))
-- Directory
-- set(Mode: "n" = normal, keybind, command)
noremap("n", "F", cmd_callback("Yazi"))
-- noremap("n", "<M->f", utils.cmd_callback("NvimTreeToggle"))

noremap("n", "X", cmd_callback("bd"))
noremap("ni", "<C-Q>", cmd_callback("qa"))
noremap("n", "<leader><C-Q>", cmd_callback("qa!"))

-- edititing
noremap("in", "<C-Z>", cmd_callback("undo"))
noremap("in", "<C-Y>", cmd_callback("redo"))
noremap("nicosx", "<C-A>", "<Esc>ggVG")
noremap("in", "<S-Up>", "<Esc>v<Up>")
noremap("in", "<S-Down>", "<Esc>v<Down>")
noremap("in", "<S-Left>", "<Esc>v<Left>")
noremap("in", "<S-Right>", "<Esc>v<Right>")
noremap("nv", "<Backspace>", "<Delete>")

noremap("niv", "<M-Down>", cmd_callback(":m +1"))
noremap("niv", "<M-Up>", cmd_callback(":m -2"))

local save_notif
noremap("niv", "<C-S>", function()
	cmd_callback("update")()
	save_notif = vim.notify("file saved", "info", {
		title = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"),
		replace = save_notif,
		on_close = function()
			save_notif = nil
		end,
	})
end)
-- cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit
noremap("n", "s<C-S>", cmd_callback("SudaWrite"))
noremap("n", "<leader><Left>", cmd_callback("bprev"))
noremap("n", "<leader><Right>", cmd_callback("bnext"))
noremap("n", "cb", cmd_callback("bdelete"))

if vim.fn.has("clipboard") then
	noremap("v", "<C-X>", '"+x')
	noremap("v", "<C-C>", '"+y')
	noremap("v", "c", '"+y')
	map("n", "<C-V>", '"+gP')
	map("c", "<C-V>", "<C-R>+")
	noremap("i", "<C-V>", '<Esc>"+pi')
end

noremap("v", "<C-r>", '"1y:%s/<C-r>1//gc<left><left><left>')
noremap("n", "<C-Left>", "b")
noremap("n", "<C-Right>", "w")
vim.cmd([[
set whichwrap+=<,h
set whichwrap+=>,l
set whichwrap+=[,]
]])

noremap("v", "<tab>", ">")
noremap("i", "<C-BS>", "<C-W>")
map("v", "<leader>n", "<C-n>")
map("n", "<C-L>", "V")
map("i", "<C-L>", "<Esc>V")
noremap("nicosx", "<C-H>", cmd_callback("noh"))
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

noremap("ni", "<C-M-T>", cmd_callback("ToggleTerm"))

noremap("n", "tn", cmd_callback("tabnext"))

return {
	cmd_callback = cmd_callback,
	inject_keys = inject_keys,
	noremap = noremap,
	map = map,
	merge_tab = merge_tab,
}
