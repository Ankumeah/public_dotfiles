return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {"lua", "bash", "cpp", "c"},
      highlight = {enable = true},
      indent = {enable = true}
    })
  end
}

