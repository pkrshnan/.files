local fn = vim.fn

local plugins = {
	-- Plugin manager
	["wbthomason/packer.nvim"] = {},
	
	-- Theme
	-- ["sam4llis/nvim-tundra"] = {
	-- 	config = function()
	-- 		require("plugins.tundra")
	-- 	end,
	-- },
	["catppuccin/nvim"] = {
		as = 'catppuccin',
		config = function()
			require("plugins.catppuccin")
		end,
	},

	-- Assorted lua functions
	["nvim-lua/plenary.nvim"] = {},

	-- Help with keymappings
	["folke/which-key.nvim"] = {
		config = function()
			require("plugins.whichkey")
		end,
	},

	-- Icons
	["kyazdani42/nvim-web-devicons"] = {},

	-- Finding and grepping
	["nvim-telescope/telescope.nvim"] = {
		config = function()
			require("plugins.telescope")
		end,
	},

	-- Autocomplete
	["hrsh7th/cmp-buffer"] = {}, -- buffer completions
	["hrsh7th/cmp-path"] = {}, -- path completions
	["hrsh7th/cmp-cmdline"] = {}, -- cmdline completions
	["hrsh7th/cmp-nvim-lsp"] = {},
	["hrsh7th/cmp-emoji"] = {},
	["hrsh7th/cmp-nvim-lua"] = {},
	["hrsh7th/nvim-cmp"] = {
		config = function()
		 	require("plugins.cmp")
		end,
	},

	-- Tabs
	["akinsho/bufferline.nvim"] = {
		config = function()
			require("plugins.bufferline")
		end,
	},
	["tiagovla/scope.nvim"] = {
		config = function()
			require("scope").setup()
		end,
	},

	-- Commenting
	["numToStr/Comment.nvim"] = {
		config = function()
		 	require("plugins.comment")
		 end,
	},

	-- LSP Configuration
	["williamboman/mason-lspconfig"] = {},
	["williamboman/mason.nvim"] = {
		config = function()
		 	require("plugins.lsp.mason")
		end,
	},

	-- Config for LSP Servers
	["glepnir/lspsaga.nvim"] = {
		config = function()
		 	require("plugins.lsp.lspsaga")
		end,
	},
	["onsails/lspkind.nvim"] = {},
	["neovim/nvim-lspconfig"] = {
		config = function()
		 	require("plugins.lsp.lspconfig")
		end,
	},

	-- 	Treesitter
	["nvim-treesitter/nvim-treesitter"] = {
		config = function()
			require("plugins.treesitter")
		end,
	},

	-- Git integration
	["lewis6991/gitsigns.nvim"] = {
		config = function()
		 	require("plugins.gitsigns")
		end,
	},

	-- Impatient optimize the startup time
	["lewis6991/impatient.nvim"] = {},

	-- For latex editing
	["lervag/vimtex"] = {
		config = function()
			require("plugins.vimtex")
		end,
	},

	-- Snippets
	["L3MON4D3/LuaSnip"] = {},
	["saadparwaiz1/cmp_luasnip"] = {},
	["rafamadriz/friendly-snippets"] = {},

	-- Todo Comments
	["folke/todo-comments.nvim"] = {
		config = function()
			require("plugins.todo")
		end,
	}
}

-- Parts below taken from: https://github.com/arturgoms/nvim/blob/main/lua/user/plugins.lua
-- Install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local status_ok, packer = pcall(require, "packer")
if status_ok then
	packer.startup({
		function(use)
			for key, plugin in pairs(plugins) do
				if type(key) == "string" and not plugin[1] then
					plugin[1] = key
				end
				use(plugin)
			end
		end,
		config = {
			display = {
				open_fn = function()
					return require("packer.util").float({ border = "rounded" })
				end,
			},
			profile = {
				enable = true,
				threshold = 0.0001,
			},
			git = {
				clone_timeout = 300,
				subcommands = {
					update = "pull --rebase",
				},
			},
			auto_clean = true,
			compile_on_sync = true,
		},
	})
end
