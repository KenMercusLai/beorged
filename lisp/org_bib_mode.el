;; Dedicated header line for org-bib-mode
(defun beorged/org-bib-mode-hook ()

  (with-current-buffer "*Ilist*"
    (setq header-line-format
        '(:eval
          (nano-modeline-render nil
                                (buffer-name imenu-list--displayed-buffer)
                                (format "(view mode: %s, filter: %s)"
                                        (if (eq org-bib--view-mode-current 'none)
                                            "-"
                                          org-bib--view-mode-current)
                                        (if (eq org-imenu-filter-string "*")
                                            "-"
                                          org-imenu-filter-string))
                                "")))
    (face-remap-add-relative 'hl-line :inherit 'nano-strong-i)))

(add-hook 'org-bib-mode-hook #'beorged/org-bib-mode-hook)

;; A shortcut to edit bibliography
(defun beorged/biblio ()
  "Create a new frame for editing bibliography"
  
  (interactive)
  (require 'org-bib)
  (setq imenu-list-position 'left
        imenu-list-size 100
        org-imenu-depth 2)

  (select-frame (make-frame '((name . "beorged/biblio")
                              (width . 180)
                              (height . 45))))
  (find-file "~/Documents/Papers/papers.org")
  (org-bib-mode))

;; An autoload function for beorged/config (that will load org mode).
(autoload 'beorged/biblio
  (expand-file-name "init.el" user-emacs-directory)
  "Autoloaded beorged/config command."
  t)
