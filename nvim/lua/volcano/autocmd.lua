
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

autocmd({'BufWritePost'} , {
  pattern = {'*notes/*'},
  callback = function ()
    vim.cmd[[~/.config/backup.sh]]
  end
})

     -- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
     --   pattern = {"*.c", "*.h"},
     --   callback = function(ev)
     --     print(string.format('event fired: s', vim.inspect(ev)))
     --   end
     -- })

-- start buffer from the point it was leaved
-- augroup('lastPosition', { clear = true })
-- autocmd('Filetype', {
--   group = 'lastPosition',
--   pattern = { '*' },
--   command = [[normal '"zz]]
-- })
