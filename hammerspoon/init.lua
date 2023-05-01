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

----------------------------- kubernetes ---------------------
local function changeNamespace(namespace)
  log.d("setting namespace", namespace)
  local changer = hs.task.new("/bin/zsh", function(exitCode, _, _)
    if (exitCode == 0) then
      hs.notify.new({
        title = "Kubernetes namespace changed",
        subTitle = "Successfully changed kubernetes namespace to \"" .. namespace .. "\""
      }):send()
    end
  end, { "-c", "kubectl config set-context --current --namespace=" .. namespace })
  changer:start()
end

local function changeContext(context)
  log.d("setting context", context)
  hs.task.new("/bin/zsh", function(exitCode, stdout, stderr)
    if (exitCode ~= 0) then
      log.e("failed to change context ", stderr)
      return
    end

    hs.notify.new({
      title = "Kubernetes context changed",
      subTitle = "Successfully changed kubernetes context to \"" .. context .. "\""
    }):send()
  end, { "-c", "kubectl config use-context " .. context }):start()
end

local function chooseNamespace()
  local chooser = hs.chooser.new(function(chosen) changeNamespace(chosen.text) end)

  hs.task.new("/bin/zsh", function(exitCode, output, stderr)
    if (exitCode ~= 0) then
      log.e("failed get namespaces ", stderr)
      return
    end

    local namespaceChoices = {}
    for line in output:gmatch("([^\r\n]+)") do
      local namespace = line:match("(%S+).*")
      table.insert(namespaceChoices, { text = namespace, uuid = namespace })
    end
    table.remove(namespaceChoices, 1)

    chooser:choices(namespaceChoices)
    chooser:show()
  end, { "-c", "kubectl get namespaces" }):start()
end

local function chooseContext()
  local chooser = hs.chooser.new(function(chosen) changeContext(chosen.text) end)

  hs.task.new("/bin/zsh", function(exitCode, output, stderr)
    if (exitCode ~= 0) then
      log.e("failed get contexts ", stderr)
      return
    end

    local contextChoices = {}
    for line in output:gmatch("([^\r\n]+)") do
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
    hs.execute("echo " .. chosen.subText .. " | pbcopy", true)
    hs.alert("copied " .. chosen.subText .. " to clipboard")
  end)

  hs.task.new("/bin/zsh", function(exitCode, output, stderr)
    if (exitCode ~= 0) then
      log.e("failed get apps ", stderr)
      return
    end

    local configmap = hs.json.decode(output)
    local configEntries = {}
    for key, val in pairs(configmap) do
      table.insert(configEntries, { text = key, subText = val, uuid = key })
    end

    log.d("contexts ", hs.inspect(configEntries))
    chooser:choices(configEntries)
    chooser:show()
  end, { "-c", "kubectl get configmap -o jsonpath='{.data}' " .. appName }):start()
end

local function chooseConfigmapFromApp()
  local chooser = hs.chooser.new(function(chosen)
    log.i("searching configmap for " .. chosen.text)
    viewConfigmap(chosen.text)
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
  end, { "-c", "kubectl get configmaps -o jsonpath='{.items..name}'" }):start()
end


seal.plugins.useractions.actions = {
  ["Kubernetes set namespace"] = {
    keyword = "kns",
    fn = function(str)
      if (str == nil or str == "") then
        chooseNamespace()
      else
        changeNamespace(str)
      end
    end,
  },
  ["Kubernetes set context"] = {
    keyword = "kctx",
    fn = function(str)
      if (str == nil or str == "") then
        chooseContext()
      else
        changeContext(str)
      end
    end
  },
  ["Kubernetes search configmap"] = {
    keyword = "kconf",
    fn = function(appName)
      if (appName == nil or appName == "") then
        chooseConfigmapFromApp()
      else
        viewConfigmap(appName)
      end
    end
  }
}

------------ widgets ---------------
local kubeCanvas = hs.canvas.new({ x = 1200, y = 100, h = 60, w = 250 })
kubeCanvas[1] = {
  id = "background",
  type = "rectangle",
  action = "fill",
  fillColor = { red = 0, green = 0, blue = 0, alpha = 0.8 },
  roundedRectRadii = {xRadius = 10, yRadius = 10},
}

kubeCanvas[2] = {
  id = "kubernetes_icon",
  type = "text",
  text = hs.styledtext.new("⎈ ", { font = { size = 32 }, color = hs.drawing.color.x11.royalblue }),
  padding = 10,
  frame = { x = "0%", y = "0%", h = "100%", w = "100%" }
}

kubeCanvas[3] = {
  id = "kubernetes",
  type = "text",
  text = "namespace: dev-somethinenv",
  textLineBreak = "truncateMiddle",
  textSize = 12,
  padding = 10,
  frame = { x = "20%", y = "0%", h = "100%", w = "80%" }
}

kubeCanvas[4] = {
  id = "kubernetes",
  type = "text",
  text = "context: non-prod",
  textSize = 12,
  padding = 10,
  frame = { x = "20%", y = "50%", h = "100%", w = "80%" }
}


hs.hotkey.bind({ "ctrl" }, "`", function()
  if (kubeCanvas:isVisible()) then
    kubeCanvas:hide()
  else
    kubeCanvas:show()
  end
end)


