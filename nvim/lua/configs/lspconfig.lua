local mappings = require("mappings")

return function()
	local x = vim.diagnostic.severity

	vim.diagnostic.config({
		virtual_text = { prefix = "" },
		signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
		underline = true,
		float = { border = "single" },
	})
	local cmp_nvim_lsp = require("blink.cmp") --require("cmp_nvim_lsp")

	local lua_lsp_settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					"${3rd}/luv/library",
				},
			},
		},
	}

	local capabilities = cmp_nvim_lsp.get_lsp_capabilities() --.default_capabilities()
	local on_attach = require("configs.lsp_attatch")

	-- lua
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = {
						"vim",
					},
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
			settings = lua_lsp_settings,
		},
	})

	-- json, yes it uses _on_attach for some reason????????
	vim.lsp.config("jsonls", {
		capabilities = capabilities,
		_on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	-- python
	vim.lsp.config("pyright", {
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- bash
	vim.lsp.config("bashls", {
		capabilities = capabilities,
		_on_attach = on_attach,
		filetypes = { "sh" },
	})

	-- solidity
	vim.lsp.config("solidity", {
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "solidity" },
	})

	-- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
	vim.lsp.config("emmet_ls", {
		capabilities = capabilities,
		_on_attach = on_attach,
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"css",
			"sass",
			"scss",
			"less",
			"svelte",
			"vue",
		},
	})

	vim.lsp.config("clangd", {
		capabilities = capabilities,
		_on_attach = on_attach,
		filetypes = {
			"c",
			"cpp",
			"h",
		},
	})

	vim.lsp.config("toml", {
		capabilities = capabilities,
		_on_attach = on_attach,
		filetypes = {
			"toml",
		},
		root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
	})

	vim.lsp.config("rust-analyzer", {
		capabilities = capabilities,
		_on_attach = on_attach,
		filetypes = {
			"rs",
		},
	})

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local eslint = require("efmls-configs.linters.eslint")
	local fixjson = require("efmls-configs.formatters.fixjson")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local hadolint = require("efmls-configs.linters.hadolint")
	local cpplint = require("efmls-configs.linters.cpplint")
	local clangformat = require("efmls-configs.formatters.clang_format")

	-- configure efm server
	vim.lsp.config("efm", {
		filetypes = {
			"lua",
			"python",
			"json",
			"jsonc",
			"sh",
			"javascript",
			"javascriptreact",
			"svelte",
			"vue",
			"markdown",
			"docker",
			"html",
			"css",
			"c",
			"cpp",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, black },
				json = { eslint, fixjson },
				jsonc = { eslint, fixjson },
				sh = { shellcheck, shfmt },
				javascript = { eslint, prettier_d },
				javascriptreact = { eslint, prettier_d },
				svelte = { eslint, prettier_d },
				vue = { eslint, prettier_d },
				markdown = { prettier_d },
				docker = { hadolint, prettier_d },
				html = { prettier_d },
				css = { prettier_d },
				c = { clangformat, cpplint },
				cpp = { clangformat, cpplint },
			},
		},
	})

	-- local format = function(buf)
	-- 	require("conform").format({ bufnr = buf })
	-- end
	--
	-- -- Auto format
	-- vim.api.nvim_create_autocmd("BufWritePre", {
	-- 	pattern = "*",
	-- 	callback = function(args)
	-- 		format(args.buf)
	-- 	end,
	-- })

	mappings.noremap("n", "gd", mappings.cmd_callback("Lspsaga peek_definition")) -- peak definition
	mappings.noremap("n", "<M-CR>", mappings.cmd_callback("Lspsaga code_action"))
	mappings.noremap("ni", "<F2>", mappings.cmd_callback("Lspsaga rename"))

	mappings.noremap("n", "fd", mappings.cmd_callback("Lspsaga finder")) -- go to definition
	mappings.noremap("n", "gD", mappings.cmd_callback("Lspsaga goto_definition"))
	mappings.noremap("n", "td", mappings.cmd_callback("Lspsaga goto_type_definition"))
	mappings.noremap("n", "<leader>g", mappings.cmd_callback("vsplit | Lspsaga goto_definition")) -- go to definition
	mappings.noremap("n", "ld", mappings.cmd_callback("Lspsaga show_line_diagnostics")) -- show  diagnostics for line
	mappings.noremap("n", "cd", mappings.cmd_callback("Lspsaga show_cursor_diagnostics")) -- show diagnostics for cursor
	mappings.noremap("n", "pd", mappings.cmd_callback("Lspsaga diagnostic_jump_prev")) -- jump to prev diagnostic in buffer
	mappings.noremap("n", "jd", mappings.cmd_callback("Lspsaga diagnostic_jump_next")) -- jump to next diagnostic in buffer
	mappings.noremap("n", "gi", mappings.cmd_callback("Lspsaga finder imp")) -- implementation

	mappings.noremap("n", "hd", mappings.cmd_callback("Lspsaga hover_doc")) -- show documentation for what is under cursor
end
