local spoonInstall = hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.repos.ShiftIt = {
  url = "https://github.com/peterklijn/hammerspoon-shiftit",
  desc = "ShiftIt spoon repository",
  branch = "master",
}

spoonInstall:andUse("Seal")
spoonInstall:andUse("ShiftIt", { repo = "ShiftIt" })

local seal = spoon.Seal
seal:loadPlugins({ "apps", "useractions", "calc", "pasteboard" })
seal:bindHotkeys({ toggle = { { "cmd" }, "space" } })
seal.plugins.pasteboard.historySize = 1000
seal:start()
hs.hotkey.bind({"cmd", "shift"}, "v", function ()
  seal:toggle("pb")
end)

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


------------- quake mode ----------------------
hs.hotkey.bind({ "ctrl" }, "`", function()
  local app = hs.application.get("alacritty")
  if (app:isFrontmost()) then app:hide() else hs.application.launchOrFocus(app:name()) end
end)
