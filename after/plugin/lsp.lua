-- LSP & Mason setup
local lsp = require("lsp-zero")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- null-ls setup
local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

-- Completion
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- Basic Mason config
mason.setup()

-- Install and configure language servers
mason_lspconfig.setup({
    ensure_installed = {
        "pyright",       -- Python
        "lua_ls",        -- Lua
        "ts_ls",         -- TypeScript/JavaScript
        "html",          -- HTML
        "cssls",         -- CSS
        "clangd",        -- C/C++
        "cmake",         -- CMake
        "eslint",        -- JavaScript Linting
        "tailwindcss",   -- Tailwind CSS
        "rust_analyzer", -- Rust
    },
})

-- Extend lspconfig with lsp-zero defaults
lsp.extend_lspconfig()
lsp.set_sign_icons({})

-- Global on_attach function
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

-- Setup nvim-cmp
cmp.setup({
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
})

-- Capabilities for LSP + cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua language server (special config)
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- Custom setup for other servers
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = lsp.on_attach,
    filetypes = { "lua" },
})
lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = lsp.on_attach,
    filetypes = { "python" },
})

-- Setup mason-null-ls
mason_null_ls.setup({
    ensure_installed = { "black", "mypy", "ruff", "prettier", "debugpy" },
    automatic_installation = true,
})

-- Setup null-ls
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black, -- Python formatter
        null_ls.builtins.diagnostics.mypy.with({
            extra_args = { "--ignore-missing-imports" },
        }),
        null_ls.builtins.diagnostics.ruff,    -- Python linter
        null_ls.builtins.formatting.prettier, -- JS/HTML formatter
    },
    on_attach = lsp.on_attach,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
