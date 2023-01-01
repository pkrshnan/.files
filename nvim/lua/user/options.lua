local options = {
	backup = false,
	mouse = "a", -- allow mouse in neovim
	smartcase = true,
	showtabline = 1, -- show tabs
	splitbelow = true,
	splitright = true,
	undofile = true, -- persistent undo
	updatetime = 0,
	number = true, -- number lines
	showcmd = false,
	relativenumber = true, -- relative line numbers
	signcolumn = "yes", -- always show signs column
	expandtab = false,
	tabstop = 2, -- 2 spaces for a tab
	shiftwidth = 2, -- number of spaces for each indentation
	listchars = "tab:▸·", -- show tab indicators
	list = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.python_recommended_style = 0 -- disable python style

