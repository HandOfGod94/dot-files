local log = hs.logger.new("gahan-init", "info")
local spoonInstall = hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.repos.ShiftIt = {
  url = "https://github.com/peterklijn/hammerspoon-shiftit",
  desc = "ShiftIt spoon repository",
  branch = "master",
}

spoonInstall:andUse("Seal")
spoonInstall:andUse("EmmyLua")
spoonInstall:andUse("TextClipboardHistory")
spoonInstall:andUse("ShiftIt", { repo = "ShiftIt" })

local seal = spoon.Seal
seal:loadPlugins({ "apps", "useractions", "calc" })
seal:bindHotkeys({ toggle = { { "cmd" }, "space" } })
seal:start()

local clipboardHistory = spoon.TextClipboardHistory
clipboardHistory.show_in_menubar = false
clipboardHistory.paste_on_select = true
clipboardHistory:bindHotkeys({
  toggle_clipboard = { { "cmd", "shift" }, "v" }
})
clipboardHistory:start()

local shiftit = spoon.ShiftIt
shiftit:bindHotkeys({
  left = { { "ctrl", "alt", "cmd" }, "left" },
  right = { { "ctrl", "alt", "cmd" }, "right" },
  up = { { "ctrl", "alt", "cmd" }, "up" },
  down = { { "ctrl", "alt", "cmd" }, "down" },
  maximum = { { "ctrl", "alt", "cmd" }, "m" },
  center = { { "ctrl", "alt", "cmd" }, "c" },
  resizeOut = { { "ctrl", "alt", "cmd" }, "=" },
  resizeIn = { { "ctrl", "alt", "cmd" }, "-" }
})

------------ firefox shortcuts ----------------

-- search tabs shortcut like arc
local tabsListKey = hs.hotkey.new({ "ctrl" }, "t", function()
  hs.eventtap.event.newKeyEvent({ "cmd" }, "l", true):post()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map.delete, true):post()
  hs.eventtap.event.newKeyEvent({ "shift" }, "5", true):post()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, true):post()
end)

hs.window.filter.new("Firefox")
    :subscribe(hs.window.filter.windowFocused, function() tabsListKey:enable() end)
    :subscribe(hs.window.filter.windowUnfocused, function() tabsListKey:disable() end)

------------- quake mode ----------------------
hs.hotkey.bind({ "ctrl" }, "`", function()
  local app = hs.application.get("alacritty")
  if (app:isFrontmost()) then app:hide() else hs.application.launchOrFocus(app:name()) end
end)

--------------- custom actions -----------------
seal.plugins.useractions.actions = {
}
