;; Deft setup
(setq deft-default-extension "org"
      deft-extensions '("org")
      deft-recursive nil
      deft-use-filename-as-title nil
      deft-use-filter-string-for-filename t
      deft-file-naming-rules '((noslash . "-")
                               (nospace . "-")
                               (case-fn . downcase))
      deft-separator " "
      deft-time-format " %d %b %Y")

;; Rewrite the deft-print-header function to get rid of “Deft\n”
(defun deft-print-header ()
  (force-mode-line-update))

;; Bug fix (see jrblevin/deft#73)
(defun org-open-file-with-emacs (path)
  (org-open-file path t))

;; A small bugfix for header that are too long by one character.
(defun deft-setup ()

  (face-remap-add-relative 'hl-line :inherit 'nano-salient-i)
  (set-window-fringes nil 0 1)
  (set-default 'truncate-lines t))

(add-hook 'deft-mode-hook #'deft-setup)
