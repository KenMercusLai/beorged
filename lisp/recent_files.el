(require 'recentf)

(setq recentf-max-menu-items 10
      recentf-max-saved-items 100
    ;;   recentf-exclude '("/Users/rougier/Documents/Mail.+"
    ;;                     "/Users/rougier/Documents/Notes.+"
    ;;                     )
)

(let (message-log-max)
  (recentf-mode 1))
