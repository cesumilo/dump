-- Ensure lazy is installed
require("config.lazy")
-- To add new lsp: add them in lua/config/mason.lua ensure_installed.
-- All lsp are automatically enabled by mson-lspconfig.
require("config.mason")
require("config.header")
require("config.indent-blankline")

require("core.config")
require("core.mappings")
require("core.hooks")

-- If you need to override the lsp configuration, use the lua/lsp folder with
-- the lsp ID as file name. E.g: lua/lsp/lua_ls.lua
-- and require it. Take as example lua/lsp/ts_ls.lua
require("lsp.ts_ls")
require("lsp.denols")
