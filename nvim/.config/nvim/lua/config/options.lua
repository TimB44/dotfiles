-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LazyVim disables clipboard syncing over SSH, but tmux forwards OSC 52
-- sequences through Mosh to the local terminal.
vim.opt.clipboard = "unnamedplus"
