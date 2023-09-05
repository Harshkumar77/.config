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
