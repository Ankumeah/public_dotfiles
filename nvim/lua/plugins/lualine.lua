return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        disabled_filetypes = {
          statusline = { "neo-tree" }, -- disables lualine in Neo-tree window
          winbar = {}
        }
      }
    })
  end
}
