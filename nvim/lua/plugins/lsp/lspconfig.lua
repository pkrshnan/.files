local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
	return
end

local whichkey_status_ok, whichkey = pcall(require, "which-key")
if not whichkey_status_ok then
	return
end

-- enable keybinds only for when lsp server available
local on_attach = function(_, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- set keybinds
	whichkey.register({
		["gf"] = { "<cmd>Lspsaga lsp_finder<CR>", "Show definition and references", opts },
		["gD"] = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration", opts },
		["gd"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition", opts },
		["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementaton", opts },
		["gl"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "See diagnostics", opts },
		["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "Code actions", opts },
		["<leader>rn"] = { "<cmd>Lspsaga rename<CR>", "Refactor", opts },
		["<leader>d"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "See diagnostics for line", opts },
		["<leader>dd"] = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "See diagnostics for cursor", opts },
		["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous diagnostic", opts },
		["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic", opts },
		["K"] = { "<cmd>Lspsaga hover_doc<CR>", "See signature", opts },
		["<leader>o"] = { "<cmd>LSoutlineToggle<CR>", "Open outline", opts },
	})
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- configure pyright server
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["tsserver"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["texlab"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
