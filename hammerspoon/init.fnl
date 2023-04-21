(let [spoonInstall (hs.loadSpoon :SpoonInstall)]
  (set spoon.SpoonInstall.repos.ShiftIt
     {:url "https://github.com/peterklijn/hammerspoon-shiftit"
      :desc "ShiftIt spoon repository"
      :branch :master})
  (doto spoonInstall
    (: :andUse :Seal)
    (: :andUse :ShiftIt {:repo :ShiftIt})))

(let [seal spoon.Seal]
  (doto seal
    (: :loadPlugins [:apps :useractions :calc :pasteboard])
    (: :bindHotkeys {:toggle [[:cmd] :space]})
    (: :start))
  (hs.hotkey.bind [:cmd :shift] :v #(seal:toggle :pb))
  (set seal.plugins.pasteboard.historySize 1000))

(doto spoon.ShiftIt
  (: :bindHotkeys {:left      [[:ctrl :alt :cmd] :left]
                   :down      [[:ctrl :alt :cmd] :down]
                   :up        [[:ctrl :alt :cmd] :up]
                   :right     [[:ctrl :alt :cmd] :right]
                   :maximum   [[:ctrl :alt :cmd] :m]
                   :center    [[:ctrl :alt :cmd] :c]
                   :resizeOut [[:ctrl :alt :cmd] "="]
                   :resizeIn  [[:ctrl :alt :cmd] "-"]}))

(fn quake-mode []
  "quake mode for alacritty"
  (let [app (hs.application.get :alacritty)]
    (if (app:isFrontmost) (app:hide) 
        (hs.application.launchOrFocus (app:name)))))

(hs.hotkey.bind [:ctrl] "`" #(quake-mode))
