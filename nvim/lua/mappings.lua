require "nvchad.mappings"

-- require "telescope"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "kj", "<ESC>")
vim.cmd("source ~/.config/.vimrc")



map("n", "<Space>fk", "<cmd> Telescope keymaps<cr>", {desc = "Telescope find keymaps"})
map("n", "<Space><Space>", "<cmd> Telescope buffers<cr>", {desc = "Telescope opened buffers"})
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
