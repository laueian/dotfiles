-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Fuzzy Finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- LSP
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		-- Dep to highlight matching words under cursor
		"RRethy/vim-illuminate",
	})

	-- Parses files for support of LSP, plugins, tools, highlighting, etc...
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	-- use("nvim-treesitter/playground")
	use("theprimeagen/harpoon")
	-- use("mbbill/undotree")

	use({
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({})
		end,
	})

	-- LSP and tooling Manager
	use({
		"williamboman/mason.nvim",
		run = ":MasonUpdate",
	})

	-- LSP Adapter for Neovim
	use({
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		-- Autocompletion
		"hrsh7th/nvim-cmp", -- Required
		"hrsh7th/cmp-nvim-lsp", -- Required
		-- Rust
		-- "simrat39/rust-tools.nvim",
		-- Useful completion sources:
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/vim-vsnip",
	})

	-- Neovim Theme
	use({
		"ellisonleao/gruvbox.nvim",
		as = "gruvbox",
		config = function()
			vim.cmd("colorscheme gruvbox")
		end,
		-- Support Neovim Theme
		"nvim-lualine/lualine.nvim",
		"nvim-tree/nvim-web-devicons",
		-- Because why not ¯\_(ツ)_/¯
		"eandrju/cellular-automaton.nvim",
	})

	-- Code Folding
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

	-- File Explorer
	use({
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	-- Vim plugin for Git (Git Wrapper)
	-- use({ "tpope/vim-fugitive" })

	-- Debugger Adapter
	use({ "mfussenegger/nvim-dap" })

	use({
		"rcarriga/nvim-dap-ui",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			print("Setting up DAPUI")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
		requires = { "mfussenegger/nvim-dap" },
	})

	use({
		"rcarriga/nvim-dap-python",
		ft = "python",
		config = function()
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
		requires = { "mfussenegger/nvim-dap" },
	})

	-- use({
	--     "folke/trouble.nvim",
	--     config = function()
	--         require("trouble").setup({
	--             icons = false,
	--             -- your configuration comes here
	--             -- or leave it empty to use the default settings
	--             -- refer to the configuration section below
	--         })
	--     end,
	-- })

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- use({
	--     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	--     config = function()
	--         require("lsp_lines").setup()
	--     end,
	-- })

	-- Open File IN Github
	use("almo7aya/openingh.nvim")

	-- Multi-line select
	use("mg979/vim-visual-multi")

	-- Smart commenting
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- use({
	--     "RRethy/vim-illuminate",
	-- })

	-- use({
	--     "HampusHauffman/block.nvim",
	--     config = function()
	--         require("block").setup({})
	--     end,
	-- })
	--
	-- use({ "theHamsta/nvim-dap-virtual-text" })

	-- Markdown Preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({
		"aspeddro/pandoc.nvim",
		config = function()
			require("pandoc").setup()
		end,
	})
end)
