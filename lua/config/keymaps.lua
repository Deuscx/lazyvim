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
    mode = mode,
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
  local vscode = require('vscode-neovim')

  map("", "<Space>", "<Nop>", opts)
  -- disable move paragraph
  map("", "(", "<Nop>", opts)
  -- map("", "/", "<Nop>", opts)
  -- Vim extension

  -- VSCode KeyMap
  map("n", "<Leader>o", "<Cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>")
  map("n", "gr", "<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>")

  -- Copy in normal mode. when https://github.com/vscode-neovim/vscode-neovim/issues/1266 fixed. Remove it and use `y` to copy
  map("n", "<C-c>", "<Cmd>call VSCodeNotify('editor.action.clipboardCopyAction')<CR>")

  map("n", "za", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>")

  -- map({"n", "v"}, "zr", "<Cmd>call VSCodeNotify('editor.action.refactor')<CR>")
  -- VsCode Extension
  map("n", "<Leader>i", "<Cmd>call VSCodeNotify('extension.toggleBool')<CR>")
  
  map("n", "<C-j>", function ()
    vscode.action('editor.action.marker.next')
  end)
else
  -- ordinary Neovim
  map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

  map("n", "<C-j>", function()
    vim.diagnostic.goto_next()
  end)
end

-- Select All
map("n", "<C-a>", "ggVG")

-- increase & decrease
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map("n", "<c-u>", "<c-u>zz")
map("n", "<c-d>", "<c-d>zz")
