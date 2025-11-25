local mappings = require("mappings")

return {
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.sonokai_style = "atlantis"
			vim.cmd.colorscheme("sonokai")
		end,
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts = function()
			return {}
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons", "nvimdev/lspsaga.nvim" },
		config = function()
			require("lualine").setup({
				options = {
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "lsp_status" },
					lualine_z = { "location" },
				},
				tabline = {
					lualine_a = {},
					lualine_b = { "buffers" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				extensions = { "mason" },
			})
		end,
	},
	-- {
	-- 	"romgrk/barbar.nvim",
	-- 	dependencies = {
	-- 		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
	-- 		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	-- 	},
	-- 	lazy = false,
	-- 	init = function()
	-- 		vim.g.barbar_auto_setup = false
	-- 	end,
	-- 	opts = function()
	-- 		mappings.noremap("n", "<leader><Left>", mappings.cmd_callback("BufferPrevious"))
	-- 		mappings.noremap("n", "<leader><Right>", mappings.cmd_callback("BufferNext"))
	-- 		mappings.noremap("n", "cb", mappings.cmd_callback("BufferClose"))
	-- 		return {}
	-- 	end,
	-- }
	-- {
	-- 	"nanozuki/tabby.nvim",
	-- 	config = function()
	-- 		-- configs...
	-- 	end,
	-- 	lazy = false,
	-- },
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = function()
			return {
				signs = {
					delete = { text = "󰍵" },
					changedelete = { text = "󱕖" },
				},
			}
		end,
	}, -- lsp stuff
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		lazy = false,
		opts = function()
			return {
				ui = {
					icons = {
						package_pending = " ",
						package_installed = " ",
						package_uninstalled = " ",
					},
				},
				max_concurrent_installers = 10,
			}
		end,
	},
	{
		"onsails/lspkind.nvim",
		config = {
			mode = "symbol",
			symbol_map = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			},
		},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets", "onsails/lspkind.nvim" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',
		opts = function()
			return require("configs.blink")
		end,
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		lazy = false,
		config = function()
			require("mini.pairs").setup({
				modes = { insert = true, command = false, terminal = true },
				mappings = {
					["<"] = { action = "open", pair = "<>", neigh_pattern = "\r." },
					[">"] = { action = "close", pair = "<>", neigh_pattern = "\r." },
				},
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = false,
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{ "vimwiki/vimwiki", lazy = false },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		-- opts = {
		-- 	indent = { char = "│", highlight = "IblChar" },
		-- 	scope = { char = "│", highlight = "IblScopeChar" },
		-- },
		config = function(_, opts)
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},
	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",
		config = function()
			require("configs.lspconfig")()
		end,
		dependencies = {
			-- "windwp/nvim-autopairs",
			"mason-org/mason.nvim",
			"creativenull/efmls-configs-nvim",
			-- "hrsh7th/cmp-buffer",
			-- "hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPre",
		opts = {
			render = "virtual",
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_hsl_without_function = true,
			enable_ansi = true,
			enable_var_usage = true,
			enable_tailwind = true,
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"efm",
				"lua_ls",
				"bashls",
				"pyright",
				-- "black",
				-- "clang-format",
				"clangd",
				-- "cpplint",
				"emmet_ls",
				-- "eslint_d",
				-- "fixjson",
				-- "flake8",
				-- "hadolint",
				"jsonls",
				-- "luacheck",
				-- "prettierd",
				-- "shellcheck",
				-- "stylua",
				"taplo",
				"rust_analyzer",
			},
			automatic_installation = true,
		},
		event = "BufReadPre",
		dependencies = {
			"mason-org/mason.nvim",
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
		lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"markdown",
				"json",
				"yaml",
				"toml",
				"javascript",
				"bash",
				"lua",
				"python",
				"java",
				"kotlin",
				"cpp",
				"c",
				"rust",
				"vim",
				"vimdoc",
				"printf",
			},
			highlight = {
				enable = true,
				use_languagetree = true,
			},

			indent = { enable = true },
		},
	},

	-- If your opts uses a function call ex: require*, then make opts spec a function
	-- Then modify the opts arg
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "TelescopeResults",
				callback = function(ctx)
					vim.api.nvim_buf_call(ctx.buf, function()
						vim.fn.matchadd("TelescopeParent", "\t\t.*$")
						vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
					end)
				end,
			})

			local function filenameFirst(_, path)
				local tail = vim.fs.basename(path)
				local parent = vim.fs.dirname(path)
				if parent == "." then
					return tail
				end
				return string.format("%s\t\t%s", tail, parent)
			end

			local telescope = require("telescope")
			telescope.setup({
				pickers = {
					find_files = {
						hidden = false,
						previewer = true,
						path_display = filenameFirst,
					},
					live_grep = {
						previewer = true,
						path_display = filenameFirst,
					},
					buffers = {
						previewer = true,
						path_display = filenameFirst,
					},
					git_files = {
						previewer = true,
						path_display = filenameFirst,
					},
				},
			})
			mappings.noremap("n", "<M-n>", mappings.cmd_callback("Telescope find_files"))
			mappings.noremap("n", "<M-b>", mappings.cmd_callback("Telescope buffers"))
			mappings.noremap("n", "<M-g>", mappings.cmd_callback("Telescope git_files"))
			mappings.noremap("n", "<M-l>", mappings.cmd_callback("Telescope live_grep"))
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				-- add any options here
				toggler = {
					line = "<C-/>",
					block = "<M-/>",
				},
				opleader = {
					line = "<C-/>",
					block = "<M-/>",
				},
			})
			-- local noremap = require("noremap")
			local api = require("Comment.api")
			mappings.noremap("i", "<C-/>", api.toggle.linewise.current)
			mappings.noremap("i", "<M-/>", api.toggle.blockwise.current)
		end,
		lazy = false,
	},
	{
		"rcarriga/nvim-notify",
		config = {
			fps = 120,
			render = "wrapped-compact",
			timeout = 1,
		},
		version = "3.15.0",
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
		},
		lazy = false,
		config = function()
			require("neogit").setup({
				integrations = {
					telescope = require("telescope"),
					diffview = require("diffview"),
				},
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			mappings.noremap("n", "D", mappings.cmd_callback("DiffviewOpen"))
			mappings.noremap("n", "<M-d>", mappings.cmd_callback("DiffviewClose"))
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
			lsp = {
				signature = {
					enabled = false,
				},
			},
		},
		lazy = true,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",

			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"Civitasv/cmake-tools.nvim",
	},
	{
		"machakann/vim-highlightedyank",
		lazy = false,
	},
	{
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require("illuminate").configure({
				under_cursor = true,
			})
			vim.cmd("hi IlluminatedWordText gui=underline")
			vim.cmd("hi IlluminatedWordRead gui=underline")
			vim.cmd("hi IlluminatedWordWrite gui=underline")
		end,
	},
	{
		"fei6409/log-highlight.nvim",
		lazy = false,
	},
	{
		"nmac427/guess-indent.nvim",
		lazy = false,
	},
	{
		"willothy/flatten.nvim",
		config = true,
		-- or pass configuration with
		-- opts = {  }
		-- Ensure that it runs first to minimize delay when opening file from terminal
		lazy = false,
		priority = 1001,
	},

	{
		"mikavilpas/yazi.nvim",
		version = "*", -- use the latest stable version
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- mark netrw as loaded so it's not loaded at all.
			--
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvimtools/hydra.nvim",
		},
		lazy = false,
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	{
		"lambdalisue/vim-suda",
		cmd = { "SudaRead", "SudaWrite" },
	},
}
