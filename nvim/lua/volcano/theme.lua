local theme = 'monokai_soda'
require 'synthwave84'.setup({
  glow = {
    error_msg = true,
    type2 = true,
    func = true,
    keyword = true,
    operator = false,
    buffer_current_target = true,
    buffer_visible_target = true,
    buffer_inactive_target = true,
  }
})

require 'onedark'.setup {
  style = 'deep'
}


require('monokai').setup {}
require('monokai').setup { palette = require('monokai').pro }
require('monokai').setup { palette = require('monokai').soda }
require('monokai').setup { palette = require('monokai').ristretto }


vim.cmd('colorscheme ' .. theme)

-- Toggle transparent
local transparent = false

vim.api.nvim_create_user_command("GlassToggle", function()
  if (transparent == false) then
    vim.cmd [[
      highlight Normal guibg=none
      highlight NonText guibg=none
      highlight Normal ctermbg=none
      highlight NonText ctermbg=none
    ]]
    transparent = true
    return
  end
  vim.cmd('colorscheme ' .. theme)
  transparent = false
end, {})

-- Super Zen 
local superZen = false

vim.api.nvim_create_user_command("SuperZen", function()
  if (superZen == false) then
    vim.cmd [[
      set noshowmode
      set laststatus=0
      set noshowcmd
      set showtabline=0
      set nonumber norelativenumber
      set cmdheight=0
    ]]
    superZen = true
    return
  end
  vim.cmd [[
      set showmode
      set laststatus=3
      set showcmd
      set showtabline=2
      set number relativenumber
      set cmdheight=1
  ]]
  superZen = false
end, {})
