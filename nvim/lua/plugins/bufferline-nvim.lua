return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        numbers = function(opts)
          return string.format("%s", opts.raise(opts.ordinal))
        end
      }
    })

    for i = 1, 9 do
      vim.keymap.set( 'n', string.format('<leader><C-%d>', i), function()
        vim.cmd('BufferLineGoToBuffer ' .. i)
      end, { desc = 'Go to buffer ' .. i })
    end
  end
}
