return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gh_actions_ls = {
          filetypes = { "yaml", "yaml.github" },
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if not (fname:match("%.github/") or fname:match("workflows/")) then
              return
            end
            local git_root = vim.fs.root(bufnr, ".git")
            if git_root then
              on_dir(git_root)
            end
          end,
        },
      },
    },
  },
}
