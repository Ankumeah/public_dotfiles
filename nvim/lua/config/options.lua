vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = false

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.clipboard = "unnamedplus"
vim.o.incsearch = true
vim.o.cmdheight = 1
vim.o.autoread = true

vim.o.showtabline = 1

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})
