(local log (hs.logger.new :gahan-init :info))
(local spoon-install (hs.loadSpoon :SpoonInstall))

(set spoon.SpoonInstall.repos.ShiftIt
     {:url "https://github.com/peterklijn/hammerspoon-shiftit"
      :desc "ShiftIt spoon repository"
      :branch :master})

(doto spoon-install
  (: :andUse :Seal)
  (: :andUse :EmmyLua)
  (: :andUse :TextClipboardHistory)
  (: :andUse :ShiftIt {:repo :ShiftIt}))

(doto spoon.Seal
  (: :loadPlugins [:apps :useractions :calc])
  (: :bindHotkeys {:toggle [[:cmd] :space]})
  (: :start))

(set spoon.TextClipboardHistory.show_in_menubar false)
(set spoon.TextClipboardHistory.paste_on_select true)
(doto spoon.TextClipboardHistory
  (: :bindHotkeys {:toggle_clipboard [[:cmd :shift] :v]})
  (: :start))

(doto spoon.ShiftIt
  (: :bindHotkeys {:left [[:ctrl :alt :cmd] :left]
                   :right [[:ctrl :alt :cmd] :right]
                   :up [[:ctrl :alt :cmd] :up]
                   :down [[:ctrl :alt :cmd] :down]
                   :maximize [[:ctrl :alt :cmd] :m]
                   :center [[:ctrl :alt :cmd] :c]
                   :resizeOut [[:ctrl :alt :cmd] "="]
                   :resizeIn [[:ctrl :alt :cmd] "-"]}))

;;;;;;;;;;;;; firefox shortcut ;;;;;;;;;;;;;;;;;;;

(fn tab-list-key-events []
  (: (hs.eventtap.event.newKeyEvent [:cmd] :l true) :post)
  (: (hs.eventtap.event.newKeyEvent hs.keycodes.map.delete true) :post)
  (: (hs.eventtap.event.newKeyEvent [:shift] :5 true) :post)
  (: (hs.eventtap.event.newKeyEvent hs.keycodes.map.space true) :post))

(let [tab-key (hs.hotkey.new [:ctrl] :t tab-list-key-events)]
  (doto (hs.window.filter.new :Firefox)
    (: :subscribe hs.window.filter.windowFocused #(tab-key:enable))
    (: :subscribe hs.window.filter.windowUnfocused #(tab-key:disable))))

;;;;;;;;;;;;;;;;;;; quake mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn quake-mode []
  (let [app (hs.application.get :alacritty)]
    (if (app:isFrontmost)
        (app:hide)
        (hs.application.launchOrFocus (app:name)))))

(hs.hotkey.bind [:ctrl] "`" quake-mode)
