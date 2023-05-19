;; Set refile targets according to my setup
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path nil)
(setq org-refile-targets
      '(
        ("~/Documents/org/agenda.org"    :maxlevel . 2)
        ("~/Documents/org/inbox.org"     :maxlevel . 1)
;;        ("~/Documents/org/organizer.org" :tag      . "tasks")
;;        ("~/Documents/org/organizer.org" :tag      . "notes")
;;        ("~/Documents/org/organizer.org" :tag      . "mails")
;;        ("~/Documents/org/organizer.org" :tag      . "meetings")
        ;;("~/Documents/org/archives.org" :maxlevel . 1)
        ))
