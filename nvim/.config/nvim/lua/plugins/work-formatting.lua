return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.typescript = { "prettier" }
      opts.formatters_by_ft.typescriptreact = { "prettier" }
      opts.formatters_by_ft.javascript = { "prettier" }
      opts.formatters_by_ft.javascriptreact = { "prettier" }
      opts.formatters_by_ft.scala = { "scalafmt" }

      opts.formatters = opts.formatters or {}
      opts.formatters.scalafmt = {
        command = "scalafmt",
        args = { "--config", "/home/tblamires/lucid/main/scala/.scalafmt.conf", "--stdin" },
      }
      return opts
    end,
  },
}
