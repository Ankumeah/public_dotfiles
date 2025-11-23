return {
  "neovim/nvim-lspconfig",
  config = function()
    local lsps = { "lua_ls", "bash_ls", "pyright", "clangd", "dockerfile_ls", "kotlin_ls" }
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    for _, lsp in ipairs(lsps) do
      local opts = { capabilities = capabilities }

      if lsp == "dockerfile_ls" then
        opts.filetypes = { "dockerfile" }
        opts.cmd = { "docker-langserver", "--stdio" }
      end
      if lsp == "bash_ls" then
        opts.filetypes = { "sh", "bash", "zsh" }
        opts.cmd = { "bash-language-server", "start" }
      end
      if lsp == "kotlin_ls" then
        opts.filetypes = { "kotlin" }
      end

      vim.lsp.config(lsp, opts)
      vim.lsp.enable(lsp)
    end
  end
}
