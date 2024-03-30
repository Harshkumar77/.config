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
