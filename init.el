;; -*- lexical-binding: t -*-
(defvar beorged/init-start-time (current-time) "Time when init.el was started")
(defvar beorged/section-start-time (current-time) "Time when section was started")
(defun beorged/report-time (section)
  (message "%-36s %.2fs"
           (concat section " " "section time: ")
           (float-time (time-subtract (current-time) beorged/section-start-time))))
(message "---------------------------------------------------------------")

(add-to-list 'load-path "~/.emacs.d/lisp")


(load "package_mgt")
(load "package_installation")
(load "startup")
(load "path")
(load "recovery")
(load "backups")
(load "bookmarks")
(load "recent_files")
(load "history_config")

(load "cursor")
(load "customization")

(require 'server)

(unless (server-running-p)
  (server-start))
(beorged/report-time "Core")


(setq beorged/section-start-time (current-time))
(load "custom_modules")

;; Configuration
(load "sidebar")
(load "filter")
(load "config_mode")

;; Auto-tangle
;; Automatically tangle org-mode files with the option #+auto_tangle: t
(add-hook 'org-mode-hook 'org-auto-tangle-mode)
(beorged/report-time "custom_modules")


(setq beorged/section-start-time (current-time))
(load "frame")
(load "window")
(load "buffer")

;; File
;; Follow symlinks without prompt
(setq vc-follow-symlinks t)

(load "dialogs")

(load "keyboard")
(load "display_cursor")
(load "text")
(load "sound")
(load "mouse")
(load "scroll")
;; (load "clipboard")
(load "help")
(beorged/report-time "Interface")


(setq beorged/section-start-time (current-time))
(load "colors")
(load "fonts")
(load "typography")
(beorged/report-time "Visual")


(setq beorged/section-start-time (current-time))
(load "default_mode")
(load "tabulations")
(load "parenthesis")
(load "imenu_list")
(load "highlighting")
(load "pdf_tools")
(beorged/report-time "Editing")


(setq beorged/section-start-time (current-time))
(load "corfu")
(load "orderless")
(beorged/report-time "Completion")


(setq beorged/section-start-time (current-time))
(load "consult")
(load "vertico")
(load "marginalia")
(load "modeline")
(load "minibuffer")
(load "miniframe")
(beorged/report-time "Minibuffer/Modeline")


(setq beorged/section-start-time (current-time))
(load "bibtex")
(load "org_bib_mode")
(beorged/report-time "Bibliography")


(setq beorged/section-start-time (current-time))
(load "org_general")
(load "babel")
(beorged/report-time "Org")


(setq beorged/section-start-time (current-time))
(load "agenda_general")
(load "agenda_holidays")
(load "daily_agenda")
(load "tasks_agenda")
(load "agenda_update")
(load "agenda_refile")
(load "capture")
(load "navigation")
(bind-key "C-c n" #'nano-agenda)
(beorged/report-time "Agenda")


(setq beorged/section-start-time (current-time))
;; Prevent magit from writing in the header line.
(advice-add 'magit-set-header-line-format :override #'ignore)
;; Add fringe on the left side of magit windows such that we can highlight region using the fringe.
(add-hook 'magit-mode-setup-hook
          #'(lambda ()
              (interactive)
              (set-window-fringes nil (* 2 (window-font-width)) 0)))
(beorged/report-time "Versioning")


(setq beorged/section-start-time (current-time))
;; (load "notes_config")
(load "notes_read")
(load "notes_write")
(beorged/report-time "Notes")

;; ;; org mode
;; ;;(use-package org
;; ;;  :ensure t
;; ;;  :defer t
;; ;;  :config
;; ;;    (setq org-directory "/home/ken/PycharmProjects/second_brain"
;; ;;          org-adapt-indentation t
;; ;;          org-return-follows-link t
;; ;;          
;; ;;    )

;; ;;    (add-hook 'org-mode-hook 'visual-line-mode)
;; ;;    (add-hook 'org-mode-hook 'org-indent-mode)
;; ;;)

;; ;;(use-package org-bullets
;; ;;  :ensure t
;; ;;  :config
;; ;;    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; ;;)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("de8f2d8b64627535871495d6fe65b7d0070c4a1eb51550ce258cd240ff9394b0" default))
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
