return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          init_options = {
            tsserver = {
<<<<<<< Updated upstream
              path = "/home/tblamires/lucid/main/cake/node_modules/typescript/lib/",
||||||| Stash base
=======
              path = "/var/lucid/main/cake/node_modules/typescript/lib/",
>>>>>>> Stashed changes
            },
            maxTsServerMemory = 10000,
          },
        },
      },
    },
  },
}
