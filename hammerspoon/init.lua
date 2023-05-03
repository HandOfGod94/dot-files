local log = hs.logger.new("gahan-init", "info")
local spoon_install = hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.repos.ShiftIt = {url = "https://github.com/peterklijn/hammerspoon-shiftit", desc = "ShiftIt spoon repository", branch = "master"}
do
  spoon_install:andUse("Seal")
  spoon_install:andUse("EmmyLua")
  spoon_install:andUse("TextClipboardHistory")
  spoon_install:andUse("ShiftIt", {repo = "ShiftIt"})
end
do
  local _1_ = spoon.Seal
  _1_:loadPlugins({"apps", "useractions", "calc"})
  _1_:bindHotkeys({toggle = {{"cmd"}, "space"}})
  _1_:start()
end
spoon.TextClipboardHistory.show_in_menubar = false
spoon.TextClipboardHistory.paste_on_select = true
do
  local _2_ = spoon.TextClipboardHistory
  _2_:bindHotkeys({toggle_clipboard = {{"cmd", "shift"}, "v"}})
  _2_:start()
end
do
  local _3_ = spoon.ShiftIt
  _3_:bindHotkeys({left = {{"ctrl", "alt", "cmd"}, "left"}, right = {{"ctrl", "alt", "cmd"}, "right"}, up = {{"ctrl", "alt", "cmd"}, "up"}, down = {{"ctrl", "alt", "cmd"}, "down"}, maximize = {{"ctrl", "alt", "cmd"}, "m"}, center = {{"ctrl", "alt", "cmd"}, "c"}, resizeOut = {{"ctrl", "alt", "cmd"}, "="}, resizeIn = {{"ctrl", "alt", "cmd"}, "-"}})
end
local function tab_list_key_events()
  hs.eventtap.event.newKeyEvent({"cmd"}, "l", true):post()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map.delete, true):post()
  hs.eventtap.event.newKeyEvent({"shift"}, "5", true):post()
  return hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, true):post()
end
do
  local tab_key = hs.hotkey.new({"ctrl"}, "t", tab_list_key_events)
  local _4_ = hs.window.filter.new("Firefox")
  local function _5_()
    return tab_key:enable()
  end
  _4_:subscribe(hs.window.filter.windowFocused, _5_)
  local function _6_()
    return tab_key:disable()
  end
  _4_:subscribe(hs.window.filter.windowUnfocused, _6_)
end
local function quake_mode()
  local app = hs.application.get("alacritty")
  if app:isFrontmost() then
    return app:hide()
  else
    return hs.application.launchOrFocus(app:name())
  end
end
return hs.hotkey.bind({"ctrl"}, "`", quake_mode)
