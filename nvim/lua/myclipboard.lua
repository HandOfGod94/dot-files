local M = {}

local function get_git_root()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if handle then
    local result = handle:read("*l")
    handle:close()
    return result
  end
  return nil
end

local function get_relative_path()
  local filepath = vim.fn.expand("%:p")
  local git_root = get_git_root()
  if git_root and filepath:sub(1, #git_root) == git_root then
    return filepath:sub(#git_root + 2)
  end
  return filepath
end

local function copy_to_clipboard(text, message)
  vim.fn.setreg("+", text)
  vim.fn.setreg("*", text)
  vim.notify(message or ("Copied: " .. text), vim.log.levels.INFO)
end

M.copy_filepath = function()
  local filepath = get_relative_path()
  copy_to_clipboard(filepath, "Copied: " .. filepath)
end

M.copy_filepath_with_line = function()
  local filepath = get_relative_path()
  local line = vim.fn.line(".")
  local ref = filepath .. ":" .. line
  copy_to_clipboard(ref, "Copied: " .. ref)
end

M.copy_filepath_with_lines = function()
  local filepath = get_relative_path()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local ref = start_line == end_line
    and (filepath .. ":" .. start_line)
    or (filepath .. ":" .. start_line .. "-" .. end_line)
  copy_to_clipboard(ref, "Copied: " .. ref)
end

M.copy_file_diff = function()
  local filepath = get_relative_path()
  local handle = io.popen("git diff -- " .. vim.fn.shellescape(filepath) .. " 2>/dev/null")
  if handle then
    local diff = handle:read("*a")
    handle:close()
    if diff and diff ~= "" then
      copy_to_clipboard(diff, "Copied git diff for " .. filepath)
    else
      vim.notify("No diff for current file", vim.log.levels.WARN)
    end
  end
end

return M
