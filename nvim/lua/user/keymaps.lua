local Remap = require("plugins.keymaps")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal Mode --
-- Better window navigation 
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Open whichkey
keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)

-- Better copy paste to clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nmap("<leader>Y", '"+Y')

-- Navigate buffers
-- keymap("n", "<C-j>", ":bnext<CR>", opts)
-- keymap("n", "<C-k>", ":bprevious<CR>", opts)
keymap("n", "<leader>d", ":bdelete<CR>", opts)

-- We use whichkey to define keybinds
local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
  return
end

whichkey.register({
	f = {
		name = "file", -- optional group name
		-- Find files with 
		f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Find File" },
		o = { "<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Open Recent File" },
		['/'] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Open Recent File" },
  },
}, { prefix = "<leader>" })
