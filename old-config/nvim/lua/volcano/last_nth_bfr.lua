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

local M = {}

function M.last_nth_buffer (n)
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

return M
