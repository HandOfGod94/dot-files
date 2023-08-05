local M = {}

local function buf_vtext()
  local a_orig = vim.fn.getreg('a')
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    vim.cmd([[normal! gv]])
  end
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg('a')
  vim.fn.setreg('a', a_orig)
  return text
end

local function visual_or_cword()
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' then
    return buf_vtext()
  end
  return vim.fn.expand('<cword>')
end

local function more_than_one_tag(cword)
  -- Run the readtags command for the given word
  local command = 'readtags -e -t tags - ' .. cword
  local file = io.popen(command)
  local count = 0
  for line in file:lines() do
    count = count + 1
    if count > 1 then
      file:close()
      return true
    end
  end
  file:close()
  return false
end

M.custom_tag_jump = function(opts)
  opts = opts or {}
  -- Get the current word under the cursor
  local cword = visual_or_cword()

  if more_than_one_tag(cword) then
    require('nvim_telescope_ctags_plus').jump_to_tag(opts)
    return
  end

  -- if there is only 1 tag, directly jump to that tag instead of listing
  vim.cmd([[execute "normal! g\<C-]>"]])
end

return M
