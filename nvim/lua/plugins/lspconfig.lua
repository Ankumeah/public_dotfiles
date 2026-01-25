return {
  "neovim/nvim-lspconfig",
  config = function()
    local lsps = {
      "lua_ls",
      "bashls",
      "pyright",
      "clangd",
      "dockerls",
      "yamlls",
      "ts_ls",
      "rust_analyzer",
      "html",
      "cssls",
      "gopls"
    }

    local schemas = vim.fn.stdpath("config") .. "/lua/schemas/"
    local yamlls_schemas = {
      [schemas .. "docker-compose.json"] = { "*docker-compose*.yaml", "*docker-compose*.yml" },
      [schemas .. "github-workflow.json"] = { "./.github/workflows/*.yaml", "./.github/workflows/*.yml" }
    }

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    for _, lsp in ipairs(lsps) do
      local opts = { capabilities = capabilities }

      if lsp == "yamlls" then
        opts.settings = { yaml = { schemas = yamlls_schemas } }
      elseif lsp == "lua_ls" then
        opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
      end

      vim.lsp.config(lsp, opts)
      vim.lsp.enable(lsp)
    end
  end
}
