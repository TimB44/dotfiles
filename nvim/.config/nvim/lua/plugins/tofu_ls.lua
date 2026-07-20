return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers.terraformls = {
      cmd = { "terraform-ls", "serve" },
      filetypes = { "terraform", "terraform-vars" },
      root_dir = require("lspconfig.util").root_pattern(".terraform", ".git"),
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    }
  end,
}
