-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({
        lhs,
        mode = mode
    }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            opts.remap = nil
        end
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

if vim.g.vscode then
    map("", "<Space>", "<Nop>", opts)
    -- map("", "/", "<Nop>", opts)
    -- Vim extension

    -- VSCode KeyMap
    map("n", "<Leader>o", "<Cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>")
    map("n", "<S-Tab>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
    map("n", "gr", "<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>")

    map("n", "g[", "<Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>")
    map("n", "g]", "<Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>")
    -- Copy in normal mode. when https://github.com/vscode-neovim/vscode-neovim/issues/1266 fixed. Remove it and use `y` to copy
    map("n", "<C-c>", "<Cmd>call VSCodeNotify('editor.action.clipboardCopyAction')<CR>")

    map("n", "za", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>")

    -- map({"n", "v"}, "zr", "<Cmd>call VSCodeNotify('editor.action.refactor')<CR>")
    -- VsCode Extension
    map("n", "<Leader>i", "<Cmd>call VSCodeNotify('extension.toggleBool')<CR>")
else
    -- ordinary Neovim
    map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
end

-- Select All
map("n", "<C-a>", "ggVG")

-- increase & decrease
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

map("n", "<c-u>", "<c-u>zz")
map("n", "<c-d>", "<c-d>zz")
