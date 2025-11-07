-- Ensure lazy is installed
require("config.lazy")
-- To add new lsp: add them in lua/config/mason.lua ensure_installed.
-- All lsp are automatically enabled by mson-lspconfig.
-- If you need to override the lsp configuration, use the lsp folder with
-- the lsp ID as file name. E.g: lsp/lua_ls.lua
require("config.mason")
require("config.header")
require("config.indent-blankline")

require("core.config")
require("core.mappings")
require("core.hooks")
