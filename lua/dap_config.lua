--
-- this is the debugging plugin config.
--

-- auto installer https://github.com/Pocco81/DAPInstall.nvim
local dap_install = require'dap-install'
dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

-- setsup the debuggers with the default settings.
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

