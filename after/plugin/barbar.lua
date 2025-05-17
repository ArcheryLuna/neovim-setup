local opts = { noremap = true, silent = true }

-- Move to previous/next

vim.keymap.set('n', '<leader>,', vim.cmd.BufferPrevious, opts)
vim.keymap.set('n', '<leader>.', vim.cmd.BufferNext, opts)

-- Re-order to previous/next

vim.keymap.set('n', '<leader><', vim.cmd.BufferMovePrevious, opts)
vim.keymap.set('n', '<leader>>', vim.cmd.BufferMoveNext, opts)

vim.keymap.set('n', '<leader>bp', vim.cmd.BufferPin, opts)

-- Close buffer

vim.keymap.set('n', '<leader>cl', vim.cmd.BufferClose, opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode

vim.keymap.set('n', '<C-s>', vim.cmd.BufferPick, opts)
-- Sort automatically by...

vim.keymap.set('n', '<Space>bd', vim.cmd.BufferOrderByDirectory, opts)
vim.keymap.set('n', '<Space>bl', vim.cmd.BufferOrderByLanguage, opts)
vim.keymap.set('n', '<Space>bw', vim.cmd.BufferOrderByWindowNumber, opts)
-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

local barbar = require('barbar')

barbar.setup {
    animation = true,
    auto_hide = false,
    clickable = true,
    sidebar_filetypes = {
        NvimTree = true,
        undotree = {
            text = 'undotree',
            align = 'center',
        }
    },
    sort = {
        ignore_case = true,
    }
}
