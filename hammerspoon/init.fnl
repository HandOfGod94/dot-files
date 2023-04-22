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
  (: :bindHotkeys {:left [[:ctrl :alt :cmd] :left]
                   :down [[:ctrl :alt :cmd] :down]
                   :up [[:ctrl :alt :cmd] :up]
                   :right [[:ctrl :alt :cmd] :right]
                   :maximum [[:ctrl :alt :cmd] :m]
                   :center [[:ctrl :alt :cmd] :c]
                   :resizeOut [[:ctrl :alt :cmd] "="]
                   :resizeIn [[:ctrl :alt :cmd] "-"]}))

;;;;;;;;;;;;;;;;;;;;;;;;; quake mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fn quake-mode []
  "quake mode for alacritty"
  (let [app (hs.application.get :alacritty)]
    (if (app:isFrontmost) (app:hide) (hs.application.launchOrFocus (app:name)))))

(hs.hotkey.bind [:ctrl] "`" #(quake-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;; gcloud helpers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fn extract-gcloud-projects [output-str]
  (accumulate [projects [] line (output-str:gmatch "([^\r\n]+)")]
    (let [(id _ _) (line:match "(%S+)%s*(%S+)%s*(%S+)")]
      (if (not= :PROJECT_ID id)
          (do
            (table.insert projects id)
            projects)
          projects))))

(fn current-project []
  (let [(output _ _ _) (hs.execute "gcloud config configurations list | tail -n +2"
                                   true)
        current-project (output:match "%S+%s*%S+%s*%S+%s*(%S+)[\r\n]")]
    current-project))

(fn on-project-changed [_ {:title project}]
  (doto (hs.task.new :/opt/homebrew/share/google-cloud-sdk/bin/gcloud
                     #(print "project sucessfully set " project)
                     [:config :set :project project])
    (: :start)))

(fn gcloud-projects-list [output-str menu]
  (let [projects (extract-gcloud-projects output-str)
        current-project (current-project)]
    (->> (icollect [_ project (ipairs projects)]
           {:title project
            :checked (= project current-project)
            :fn on-project-changed})
         (menu:setMenu))))

(fn async-set-menu-items [menu]
  "fetches gcloud asyncronously and sets menubar value"
  (doto (hs.task.new :/opt/homebrew/share/google-cloud-sdk/bin/gcloud
                     #(gcloud-projects-list $2 menu) [:projects :list])
    (: :start)))

(let [menubar (hs.menubar.new)]
  (doto menubar
    (: :setTitle "☁")
    (: :setTooltip :gcloud)
    (: :setMenu [{:title "Loading ..." :checked false :disabled true}])
    (async-set-menu-items)))
