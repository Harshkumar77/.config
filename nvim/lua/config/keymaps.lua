-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.set("n", "<leader>,", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })

vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

-- insert mode escape
vim.keymap.set("i", "kj", "<Esc>")

-- file ops
vim.keymap.set("n", "<leader>x", ":wa<CR>")
vim.keymap.set("n", "<leader>X", ":wqa<CR>")
vim.keymap.set("n", "<leader>Q", ":qa!<CR>")

-- window nav
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- insert lines
vim.keymap.set("n", "<leader>o", "i<Esc>O<Esc>o")

-- delete shortcuts
vim.keymap.set("n", "ds", "0D")
vim.keymap.set("n", "dA", "gg0dG")

-- semi + line below
vim.keymap.set("", "<leader>;", "A;<Esc>o")

-- move lines
vim.keymap.set("", "<leader>j", "Vxp")
vim.keymap.set("", "<leader>k", "VxkP")

-- yank to system clipboard
vim.keymap.set("v", "Y", '"+y')
vim.keymap.set("n", "Y", '"+y')
vim.keymap.set("n", "<leader>y", "ggVGy<C-o>zz")
vim.keymap.set("n", "<leader>Y", 'ggVG"+y<C-o>zz')

vim.keymap.set("n", ";", ":")
vim.keymap.set("v", ";", ":")
vim.keymap.set("n", ":", ";")
vim.keymap.set("v", ":", ";")
