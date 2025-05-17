local lsp = require("lsp-zero")
local mason = require('mason')
local masonLspConf = require('mason-lspconfig')
local lspConf = require('lspconfig')
local cmp = require('cmp')

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)end)

-- Lsp keymappings

local cmp_select = { behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  	['<C-y>'] = cmp.mapping.confirm({ select = true }),
  	["<C-Space>"] = cmp.mapping.complete(),
})
cmp.setup({
    sources = {
        { name = "nvim_lsp" }
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    cmp_mappings,
    cmp_select
})

lsp.set_preferences({
	sign_icons = {},
})

mason.setup({
    ensure_installed = {"mypy"}
})
masonLspConf.setup({
	ensure_installed = {'ts_ls', 'rust_analyzer','pyright', 'ruff', 'eslint', 'lua_ls', "tailwindcss", "cssls", "clangd", "cmake", "html" },
	handlers = {
		lsp.default_setup,
		lua_ls = function()
			local lua_opts = lsp.nvim_lua_ls()
			lspConf.lua_ls.setup(lua_opts)
		end,
	},
})

lspConf.pyright.setup({
    on_attach = lsp.on_attach,
    capabilities = capabilities,
    filetypes = {"python"}
})

