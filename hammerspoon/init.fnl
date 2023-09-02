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
  (: :loadPlugins [:apps :useractions :calc :filesearch])
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

;;;;;;;;;;;;;;;;;;; quake mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn quake-mode []
  (let [app (hs.application.get :alacritty)]
    (if (app:isFrontmost)
        (app:hide)
        (hs.application.launchOrFocus (app:name)))))

(hs.hotkey.bind [:ctrl] "`" quake-mode)
