local log = hs.logger.new("gahan-init", "info")
local spoon_install = hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.repos.ShiftIt = {url = "https://github.com/peterklijn/hammerspoon-shiftit", desc = "ShiftIt spoon repository", branch = "master"}
do
  spoon_install:andUse("Seal")
  spoon_install:andUse("TextClipboardHistory")
  spoon_install:andUse("ShiftIt", {repo = "ShiftIt"})
end
do
  local _1_ = spoon.Seal
  _1_:loadPlugins({"apps", "useractions", "calc", "filesearch"})
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
hs.loadSpoon("Pritunl")
local function _3_()
  return (spoon.Pritunl):showProfiles()
end
spoon.Seal.plugins.useractions.actions = {vpn = {description = "Connect to Pritunl VPN", icon = hs.image.imageFromPath("/Applications/Pritunl.app/Contents/Resources/electron.icns"), fn = _3_}}
do
  local _4_ = spoon.ShiftIt
  _4_:bindHotkeys({left = {{"ctrl", "alt", "cmd"}, "left"}, right = {{"ctrl", "alt", "cmd"}, "right"}, up = {{"ctrl", "alt", "cmd"}, "up"}, down = {{"ctrl", "alt", "cmd"}, "down"}, maximize = {{"ctrl", "alt", "cmd"}, "m"}, center = {{"ctrl", "alt", "cmd"}, "c"}, resizeOut = {{"ctrl", "alt", "cmd"}, "="}, resizeIn = {{"ctrl", "alt", "cmd"}, "-"}})
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
