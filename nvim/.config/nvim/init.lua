-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" }, -- Apply to all file types
  callback = function()
    -- Save cursor position to restore it after the operation
    local save_cursor = vim.fn.getpos(".")
    -- Remove trailing whitespace using a substitute command
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    -- Restore cursor position
    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Trim trailing whitespace on save",
})
