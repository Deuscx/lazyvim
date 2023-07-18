-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {
        noremap = true,
        silent = true
    })
end

if vim.g.vscode then
    map("", "<Space>", "<Nop>", opts)
    -- map("", "/", "<Nop>", opts)
    -- Vim extension

    -- VSCode KeyMap
    map("n", "<Leader>o", "<Cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>")
    map("n", "<S-Tab>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")

    -- Copy in normal mode. when https://github.com/vscode-neovim/vscode-neovim/issues/1266 fixed. Remove it and use `y` to copy
    map("n", "<C-c>", "<Cmd>call VSCodeNotify('editor.action.clipboardCopyAction')<CR>")

    map("n", "za", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>")
    -- VsCode Extension
    map("n", "<Leader>i", "<Cmd>call VSCodeNotify('extension.toggleBool')<CR>")
else
    -- ordinary Neovim
end

-- Select All
map("n", "<C-a>", "ggVG")