return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig'},
    opts = {
      settings = {
        tsserver_path = '/var/lucid/main/node_modules/typescript/lib/tsserver.js',
        tsserver_max_memory = 100000,
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
      },
    },
  },
}
