require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set


map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "go to left tmux pane"})
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "go to right tmux pane"})

map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "go to up tmux pane"})
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "go to down tmux pane"})

map("n", ";", ":Telescope cmdline<CR>", { desc = "CMD enter command mode" })
map("n", ":", ":Telescope cmdline<CR>", { noremap = true, desc = "cmdline"})
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
