vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

require("nvim-treesitter.configs").setup({ indent = { enable = false } })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true
vim.opt.cmdheight = 1
vim.opt.autoread = true

vim.opt.showtabline = 1
