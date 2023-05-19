;; Load libraries.
(require 'org-agenda)
(require 'org-agenda-property)
;; Open agenda(s)
(bind-key "C-c a" #'org-agenda)
;; files
(setq org-agenda-files (list "~/Documents/org/agenda.org"
                             "~/Documents/org/students.org"
                             "~/Documents/org/todo.org"
                             "~/Documents/org/inbox.org")
      org-agenda-diary-file (expand-file-name "diary" user-emacs-directory))
;; Settings
(setq org-agenda-window-setup 'current-window
      org-agenda-restore-windows-after-quit t
      org-agenda-show-all-dates nil
      org-agenda-time-in-grid t
      org-agenda-show-current-time-in-grid t
      org-agenda-start-on-weekday 1
      org-agenda-span 7
      org-agenda-hide-tags-regexp "." ; No tags
    ; org-agenda-hide-tags-regexp nil) ; All tags
      org-agenda-tags-column 0
    ; org-agenda-tags-column -79)      ; Left aling
      org-agenda-block-separator nil
      org-agenda-category-icon-alist nil
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t
      org-agenda-sticky t)
;; Prefix format
(setq org-agenda-prefix-format
      '((agenda . "%i %?-12t%s")
        (todo .   "%i")
        (tags .   "%i")
        (search . "%i")))
;; Sorting strategy

(setq org-agenda-sorting-strategy
      '((agenda deadline-down scheduled-down todo-state-up time-up
                habit-down priority-down category-keep)
        (todo   priority-down category-keep)
        (tags   timestamp-up priority-down category-keep)
        (search category-keep)))

;; Minimal time grid
(setq org-agenda-time-grid
      '((daily today require-timed)
        ()
        "......" "----------------"))

(setq org-agenda-current-time-string "   now")

;; A small function to cancel a meeting

(defun beorged/org-cancel-meeting ()
  (interactive)
  (org-entry-put (point) "CATEGORY" "cancelled")
  (org-entry-put (point) "NOTE" "Cancelled")
  (org-set-tags ":CANCELLED:"))
