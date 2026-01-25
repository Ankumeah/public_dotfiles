vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy"
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline"
  }
}

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

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*docker-compose*.yaml",
    "*docker-compose*.yml"
  },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*Dockerfile*" },
  callback = function()
    vim.bo.filetype = "dockerfile"
  end
})

vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#553333" })
vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])

