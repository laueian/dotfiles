-- require("mason").setup({
-- 	ensure_installed = {
-- 		"isort",
-- 		"pylint",
-- 		"black",
-- 		"mypy",
-- 		"ruff",
-- 	},
-- })
-- require("mason-lspconfig").setup({
-- 	ensure_installed = {
-- 		-- "isort",
-- 		-- "pylint",
-- 		-- "black",
-- 		-- "mypy",
-- 		-- "ruff",
--         "clangd",
-- 		"rust_analyzer",
-- 		"lua_ls",
-- 		"pyright",
-- 		"clangd",
-- 	},
-- })
--
-- -- Setup completion for all installed LSPs
-- require("mason-lspconfig").setup_handlers({
-- 	function(lsp)
-- 		require("lspconfig")[lsp].setup({
-- 			capabilities = require("cmp_nvim_lsp").default_capabilities(),
-- 		})
-- 	end,
-- })
