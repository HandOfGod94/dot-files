local M = {}

function M.change_style(style)
  if style == "light" then
    M.switch_light()
  end

  if style == "dark" then
    M.switch_dark()
  end
end

function M.switch_dark()
  vim.cmd('colorscheme tokyonight-night')
end

function M.switch_light()
  vim.cmd('colorscheme tokyonight-day')
end

function M.day_night_setup()
  local today_date = os.date('*t', os.time())
  local current_year = today_date.year
  local current_day = today_date.day
  local current_month = today_date.month

  local evening_6_pm = os.time({ year = current_year, day = current_day, month = current_month, hour = 18, sec = 0 })
  local morning_8_am = os.time({ year = current_year, day = current_day, month = current_month, hour = 8, sec = 0 })
  -- 8am < time(light) < 6pm
  -- time(light), 8am > 0
  -- time(light), 6pm < 0
  local teen_pahar = os.difftime(os.time(), evening_6_pm) < 0
  local do_pahar = os.difftime(os.time(), morning_8_am) > 0
  if teen_pahar and do_pahar then
    M.switch_light()
  else
    M.switch_dark()
  end
end

return M
