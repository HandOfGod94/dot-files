local log = hs.logger.new("gahan-init", "info")
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
hs.hotkey.bind({ "cmd", "shift" }, "v", function()
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

--------------- gcloud ------------------------
local gcloudEnv = {
  staging = "jiva-services",
  prod = "production-jiva-services"
}
local currentGcloudProject = hs.execute("gcloud config configurations list | tail -n +2", true)
currentGcloudProject = currentGcloudProject:match("%S+%s*%S+%s*%S+%s*(%S+)[\r\n]")
log.i("Current gcloud project", currentGcloudProject)

local currentGcloudProjectLabel = ""
if (currentGcloudProject == "jiva-services")
then
  currentGcloudProjectLabel = "staging"
else
  currentGcloudProjectLabel = "prod"
end

local gcloudMenubar = hs.menubar.new()
gcloudMenubar:setTitle("☁ " .. currentGcloudProjectLabel)
gcloudMenubar:setTooltip(currentGcloudProject)
gcloudMenubar:setMenu({
  {
    title = "staging",
    fn = function(_, menuItem)
      local changeProjectTask = hs.task.new("/opt/homebrew/share/google-cloud-sdk/bin/gcloud",
        function(_, _, _)
          local notification = hs.notify.new(nil, {
            title = "Gcloud project changed",
            subTitle = "Successfully changed gcloud project to \"" .. gcloudEnv[menuItem.title] .. "\""
          })
          notification:send()
          log.i("set gcloud to ", gcloudEnv[menuItem.title])
          gcloudMenubar:setTitle("☁ staging")
          gcloudMenubar:setTooltip(gcloudEnv[menuItem.title])
        end, { "config", "set", "project", gcloudEnv[menuItem.title] })
      changeProjectTask:start()
    end
  },
  {
    title = "prod",
    fn = function(_, menuItem)
      local changeProjectTask = hs.task.new("/opt/homebrew/share/google-cloud-sdk/bin/gcloud",
        function(_, _, _)
          local notification = hs.notify.new(nil, {
            title = "Gcloud project changed",
            subTitle = "Successfully changed gcloud project to \"" .. gcloudEnv[menuItem.title] .. "\""
          })
          notification:send()
          log.i("set gcloud to ", gcloudEnv[menuItem.title])
          gcloudMenubar:setTitle("☁ prod")
          gcloudMenubar:setTooltip(gcloudEnv[menuItem.title])
        end, { "config", "set", "project", gcloudEnv[menuItem.title] })
      changeProjectTask:start()
    end
  }
})
