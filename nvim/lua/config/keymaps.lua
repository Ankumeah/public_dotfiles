-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "h", "h", { desc = "Move left" })
vim.keymap.set("n", "j", "j", { desc = "Move down" })
vim.keymap.set("n", "k", "k", { desc = "Move up" })
vim.keymap.set("n", "l", "l", { desc = "Move right" })
vim.keymap.set("n", "<leader>t", function()
    vim.cmd("vs | terminal")
end, { desc = "Vertical split open a terminal" })

vim.keymap.set("n", "<A-Tab>", function()
    vim.cmd("bnext")
end, { desc = "Cycle through buffers" })
