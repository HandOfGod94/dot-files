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
hs.hotkey.bind({"ctrl"}, "`", quake_mode)
local function notify_namespace_changed(exit_code, namespace)
  if (exit_code == 0) then
    return hs.notify.new({title = "Kubernetes namespace changed", subTitle = ("Successfully changed namespace " .. namespace)}):send()
  else
    return nil
  end
end
local function namespace_changer(namespace)
  local function _9_(_241)
    return notify_namespace_changed(_241, namespace)
  end
  return hs.task.new("/bin/zsh", _9_, {"-c", ("kubectl config set-context --current --namespace=" .. namespace)}):start()
end
local function namespace_chooser(exit_code, namespaces_stdout, chooser)
  if (exit_code == 0) then
    local namespaces
    do
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for line in namespaces_stdout:gmatch("([^\13\n]+)") do
        local val_19_auto
        do
          local namespace = line:match("(%S+).*")
          if ("NAME" ~= namespace) then
            val_19_auto = {text = namespace, uuid = namespace}
          else
            val_19_auto = nil
          end
        end
        if (nil ~= val_19_auto) then
          i_18_auto = (i_18_auto + 1)
          do end (tbl_17_auto)[i_18_auto] = val_19_auto
        else
        end
      end
      namespaces = tbl_17_auto
    end
    chooser:choices(namespaces)
    chooser:show()
    return chooser
  else
    return nil
  end
end
local function choose_namespace()
  local chooser
  local function _13_(_241)
    return namespace_changer(_241.text)
  end
  chooser = hs.chooser.new(_13_)
  local function _14_(_241, _242)
    return namespace_chooser(_241, _242, chooser)
  end
  return hs.task.new("/bin/zsh", _14_, {"-c", "kubectl get namespaces"}):start()
end
local function set_namespace(namespace)
  log.d("Setting namespace", namespace)
  if ((nil ~= namespace) and ("" ~= namespace)) then
    return namespace_changer(namespace)
  else
    return choose_namespace()
  end
end
local function _16_(_241)
  return set_namespace(_241)
end
spoon.Seal.plugins.useractions.actions = {["Kubernetes set namespace"] = {keyword = "kns", fn = _16_}}
return nil
