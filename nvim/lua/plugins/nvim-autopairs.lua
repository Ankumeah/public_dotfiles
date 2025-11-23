return {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup({
      map_cr = true,
      event = "InsertEnter",
      config = true
    })
  end
}
