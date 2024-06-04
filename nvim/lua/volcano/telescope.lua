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

    diagnostics = {
      theme = 'ivy'
    },
    live_grep = {
      theme = 'ivy'
    },
    grep_string = {
      theme = 'ivy'
    },
    help_tags = {
      theme = 'ivy'
    },
    find_files = {
      theme = 'ivy'
    },
    git_files = {
      theme = 'ivy'
    },
    buffers = {
      theme = 'ivy'
    },
    oldfiles = {
      theme = 'ivy'
    },
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
