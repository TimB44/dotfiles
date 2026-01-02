return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      on_colors = function(colors)
        colors.bg = "#121a21" -- Your original background
        colors.bg_statusline = "NONE" -- Seamless flow
        colors.fg = "#e5e1d0" -- Your original foreground
      end,
      on_highlights = function(hl, c)
        -- PURPLE THEME: No more blue blocks
        local soft_purple = "#bb9af7" -- The main purple
        local deep_purple = "#9d7cd8" -- A slightly deeper purple
        local branch_grey = "#787c99" -- Muted color for the branch info

        hl.LualineNormal = { bg = "NONE", fg = soft_purple } -- Normal mode is now Purple
        hl.LualineInsert = { bg = "NONE", fg = "#c3e88d" } -- Insert stays a chill green
        hl.LualineVisual = { bg = "NONE", fg = "#ff9e64" } -- Visual is a soft orange

        -- The Branch and Icon color
        hl.LualineBranch = { bg = "NONE", fg = deep_purple }
      end,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.globalstatus = true
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "│", right = "│" }

      opts.sections.lualine_a = {
        { "mode", fmt = string.lower, icon = nil, color = { gui = "bold" } },
      }
      opts.sections.lualine_b = {
        -- Icon is back, color is set to the Purple highlight we made
        { "branch", icon = "", color = { fg = "#9d7cd8" } },
      }
      opts.sections.lualine_c = { { "filename", path = 1 } }
      opts.sections.lualine_x = {}
      opts.sections.lualine_y = {}
      opts.sections.lualine_z = {}
    end,
  },
}
