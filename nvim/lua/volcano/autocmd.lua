
-- https://raw.githubusercontent.com/brainfucksec/neovim-lua/main/nvim/lua/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- spell check on vimwiki files
augroup('spellCheck', { clear = true })
autocmd('Filetype', {
  group = 'spellCheck',
  pattern = { 'vimwiki' },
  command = 'set spell'
})

-- dont spell check on vimwiki diary files
augroup('noSpellDiary', { clear = true })
autocmd('BufWinEnter', {
  group = 'noSpellDiary',
  pattern = { '*diary/*.md' },
  command = 'set nospell'
})

autocmd({'BufWritePost'} , {
  pattern = {'*notes/*'},
  callback = function ()
    vim.cmd[[!sh ~/.config/backup.sh]]
  end
})

-- fold commands
-- augroup('foldOnNewWindow', { clear = true })
-- autocmd({'BufEnter','BufWinEnter'}, {
--   group = 'foldOnNewWindow',
--   pattern = {"*.*"},
--   command = 'Fold'
-- })

augroup('foldOnSave', { clear = true })
autocmd({'BufWritePost'} , {
  group = 'foldOnSave',
  command = 'Fold'
})
-- start buffer from the point it was leaved
-- augroup('lastPosition', { clear = true })
-- autocmd('Filetype', {
--   group = 'lastPosition',
--   pattern = { '*' },
--   command = [[normal '"zz]]
-- })
