return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gh_actions_ls = {
          filetypes = { "yaml", "yaml.github" },
          root_dir = function(fname)
            local lspconfig_util = require("lspconfig.util")
            -- Only activate if the file is within a .github directory
            return fname:match("%.github/") and lspconfig_util.find_git_ancestor(fname)
          end,
        },
      },
    },
  },
}
