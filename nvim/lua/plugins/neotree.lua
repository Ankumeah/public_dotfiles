return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>E", ":Neotree reveal left<CR>")
    
    require("neo-tree").setup({
      window = {width = 25}
    })
  end
}
