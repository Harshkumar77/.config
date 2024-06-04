require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        -- ["<cr>"] = require('telescope.actions').file_tab,
      },
      n = {
        -- ["<cr>"] = require('telescope.actions').file_tab,
      }
    },
  },
  pickers = {
    'ivy',
    buffers = {
      theme = 'ivy',
    },
    find_files = {
      theme = 'ivy',
    },
    git_files = {
      theme = 'ivy',
      previewer = false,
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

local M = {}

function M.toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do

    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

return M
