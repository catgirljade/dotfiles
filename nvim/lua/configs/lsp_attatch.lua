local mappings = require("mappings")
local M = {}

M.on_attach = function(client)
	if client.name == "pyright" then
		mappings.noremap("n", "<leader>oi", mappings.cmd_callback("PyrightOrganizeImports")) -- organise imports
		mappings.noremap("n", "<leader>db", mappings.cmd_callback("DapToggleBreakpoint")) -- toggle breakpoint
		mappings.noremap("n", "<leader>dr", mappings.cmd_callback("DapContinue")) -- continue/invoke debugger
		mappings.noremap("n", "<leader>dt", mappings.cmd_callback("lua require('dap-python').test_method()")) -- run tests
	end
end

return M
