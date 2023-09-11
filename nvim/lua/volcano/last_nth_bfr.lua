local splitString = function (inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local last_nth_buffer = function (n)
  return function()
    local sorted_bfrs_raw = (vim.api.nvim_exec2([[:ls sort]], {
      output = true
    })).output
    local sorted_bfrs_table = splitString(sorted_bfrs_raw, "\n")
    if #sorted_bfrs_table < n then
      print("Not enough buffers")
      return
    end
    local last_nth_bfr = splitString(sorted_bfrs_table[n])[1]
    vim.cmd(":b" .. last_nth_bfr)
  end
end

vim.keymap.set(
  'n', 'S', last_nth_buffer(3),
  { desc = 'last to last recent buffer' }
)
vim.keymap.set(
  'n', 'gs', last_nth_buffer(4),
  { desc = 'last to last to last recent buffer' }
)
vim.keymap.set(
  'n', 'gS', last_nth_buffer(5),
  { desc = 'last to last to last to last recent buffer' }
)
vim.keymap.set(
  'n', '<leader>gs', last_nth_buffer(6),
  { desc = 'last to last to last to last to last recent buffer' }
)
vim.keymap.set(
  'n', '<leader>gS', last_nth_buffer(7),
  { desc = 'last to last to last to last to last to last recent buffer' }
)
vim.keymap.set(
  'n', '<leader>GS', last_nth_buffer(8),
  { desc = 'last to last to last to last to last to last to last recent buffer' }
)
