return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          init_options = {
            tsserver = {
              path = "/home/tblamires/lucid/main/cake/node_modules/typescript/lib/",
            },
            maxTsServerMemory = 10000,
          },
        },
      },
    },
  },
}
