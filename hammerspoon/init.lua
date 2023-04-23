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
  nonprod = "jiva-services",
  prod = "production-jiva-services"
}

local gcloudEnvLabel = {
  ["jiva-services"] = "nonprod",
  ["production-jiva-services"] = "prod"
}

local currentGcloudProject = hs.execute("gcloud config configurations list | tail -n +2", true)
currentGcloudProject = currentGcloudProject:match("%S+%s*%S+%s*%S+%s*(%S+)[\r\n]")
log.i("Current gcloud project", currentGcloudProject)

local gcloudMenubar = hs.menubar.new()
gcloudMenubar:setTitle("☁ " .. gcloudEnvLabel[currentGcloudProject])
gcloudMenubar:setTooltip(currentGcloudProject)

local function onGcloudItemClicked(_, menuItem)
  local changeProjectTask = hs.task.new("/opt/homebrew/share/google-cloud-sdk/bin/gcloud",
    function(_, _, _)
      local notification = hs.notify.new(nil, {
        title = "Gcloud project changed",
        subTitle = "Successfully changed gcloud project to \"" .. gcloudEnv[menuItem.title] .. "\""
      })
      notification:send()
      log.i("set gcloud to ", gcloudEnv[menuItem.title])
      gcloudMenubar:setTitle("☁ " .. menuItem.title)
      gcloudMenubar:setTooltip(gcloudEnv[menuItem.title])
    end, { "config", "set", "project", gcloudEnv[menuItem.title] })
  changeProjectTask:start()
end

gcloudMenubar:setMenu({
  {
    title = "nonprod",
    fn = onGcloudItemClicked
  },
  {
    title = "prod",
    fn = onGcloudItemClicked
  }
})

----------------------------- kubernetes ---------------------
local kubeMenubar = hs.menubar.new()

local function setKubeMenu()
  local currentContext = hs.execute("kubectl config current-context", true)
  currentContext = currentContext:match("(%S+)%s*")
  local contextLabel = ""
  if (currentContext == "nonprod")
  then
    contextLabel = "N"
  else
    contextLabel = "P"
  end

  local currentNamespace = hs.execute("kubectl config view --minify -o jsonpath='{..namespace}'", true)
  kubeMenubar:setTitle("⎈ " .. currentNamespace .. "[" .. contextLabel .. "]")
end

setKubeMenu()
hs.timer.doEvery(10, setKubeMenu)

local function changeNamespace(namespace)
  log.d("setting namespace", namespace)
  local changer = hs.task.new("/opt/homebrew/bin/kubectl", function(exitCode, _, _)
    if (exitCode == 0)
    then
      local notification = hs.notify.new(nil, {
        title = "Kubernetes namespace changed",
        subTitle = "Successfully changed kubernetes namespace to \"" .. namespace .. "\""
      })
      notification:send()
      setKubeMenu()
    end
  end, { "config", "set-context", "--current", "--namespace=" .. namespace })
  changer:start()
end

local function changeContext(context)
  log.d("setting context", context)
  local changer = hs.task.new("/bin/zsh", function()
    local notification = hs.notify.new(nil, {
      title = "Kubernetes context changed",
      subTitle = "Successfully changed kubernetes context to \"" .. context .. "\""
    })
    notification:send()
    setKubeMenu()
  end, { "-c", "kubectl config use-context " .. context })
  changer:start()
end

local function chooseNamespace()
  local chooser = hs.chooser.new(function(chosen)
    if (chosen) then
      changeNamespace(chosen.text)
    end
  end)

  hs.task.new("/bin/zsh", function(exitCode, output, stderr)
    if (exitCode ~= 0) then
      log.e("failed get namespaces ", stderr)
      return
    end

    local namespaceChoices = {}
    for line in output:gmatch("([^\r\n]+)")
    do
      local namespace = line:match("(%S+).*")
      table.insert(namespaceChoices, { text = namespace, uuid = namespace })
    end
    table.remove(namespaceChoices, 1)

    chooser:choices(namespaceChoices)
    chooser:show()
  end, { "-c", "kubectl get namespaces" })
      :start()
end

local function chooseContext()
  local chooser = hs.chooser.new(function(chosen)
    if (chosen) then
      changeContext(chosen.text)
    end
  end)

  hs.task.new("/bin/zsh", function(exitCode, output, stderr)
    if (exitCode ~= 0) then
      log.e("failed get contexts ", stderr)
      return
    end

    local contextChoices = {}
    for line in output:gmatch("([^\r\n]+)")
    do
      local name, cluster = line:match("%S*%s+(%S+)%s+(%S+).*")
      table.insert(contextChoices, { text = name, subText = cluster, uuid = name })
    end
    table.remove(contextChoices, 1)

    log.d("contexts ", hs.inspect(contextChoices))
    chooser:choices(contextChoices)
    chooser:show()
  end, { "-c", "kubectl config get-contexts" }):start()
end

local function viewConfigmap(appName)
  local chooser = hs.chooser.new(function(chosen)
    if (chosen) then
      hs.execute("echo " .. chosen.subText .. " | pbcopy", true)
      hs.alert("copied " .. chosen.subText .. " to clipboard")
    end
  end)

  hs.task.new("/bin/zsh", function(exitCode, output, stderr)
    if (exitCode ~= 0) then
      log.e("failed get apps ", stderr)
      return
    end

    local configmap = hs.json.decode(output)
    local configEntries = {}
    for key, val in pairs(configmap)
    do
      table.insert(configEntries, { text = key, subText = val, uuid = key })
    end

    log.d("contexts ", hs.inspect(configEntries))
    chooser:choices(configEntries)
    chooser:show()
  end, { "-c", "kubectl get configmap -o jsonpath='{.data}' " .. appName }):start()
end

local function chooseConfigmapFromApp()
  local chooser = hs.chooser.new(function(chosen)
    if (chosen) then
      log.i("searching configmap for " .. chosen.text)
      viewConfigmap(chosen.text)
    end
  end)

  hs.task.new("/bin/zsh", function(exitCode, stdout, stderr)
    if (exitCode ~= 0) then
      log.e("failed get apps ", stderr)
      return
    end

    local appChoices = {}
    for app in stdout:gmatch("%S+") do
      table.insert(appChoices, { text = app, uuid = app })
    end

    log.d("apps ", hs.inspect(appChoices))
    chooser:choices(appChoices)
    chooser:show()
  end, { "-c", "kubectl get configmaps -o jsonpath='{.items..name}'"}):start()
end


seal.plugins.useractions.actions = {
  ["Kubernetes set namespace"] = {
    keyword = "kns",
    fn = function(str)
      if (str == nil or str == "")
      then
        str = chooseNamespace()
      else
        changeNamespace(str)
      end
    end,
  },
  ["Kubernetes set context"] = {
    keyword = "kctx",
    fn = function(str)
      if (str == nil or str == "")
      then
        chooseContext()
      else
        changeContext(str)
      end
    end
  },
  ["Kubernetes search configmap"] = {
    keyword = "kconf",
    fn = function(appName)
      if (appName == nil or appName == "")
      then
        chooseConfigmapFromApp()
      else
        viewConfigmap(appName)
      end
    end
  }
}
