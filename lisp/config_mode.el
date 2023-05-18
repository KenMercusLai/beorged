
(defun beorged/config-mode-prev-header ()
  "Move to previous header"
  
  (interactive)
  (with-current-buffer "*Ilist*"
    (search-backward-regexp "^  ")
    (imenu-list-display-dwim)))

(defun beorged/config-mode-next-header ()
  "Move to next header"
    
  (interactive)
  (with-current-buffer "*Ilist*"
    (forward-line)
    (search-forward-regexp "^  ")
    (imenu-list-display-dwim)))

(defun beorged/config-mode-prev-section ()
  "Move to previous section"
    
  (interactive)
  (with-current-buffer "*Ilist*"
    (search-backward-regexp "\\+ " nil nil 2)
    (forward-line)
    (imenu-list-display-dwim)))

(defun beorged/config-mode-next-section ()
  "Move to next section"
    
  (interactive)
  (with-current-buffer "*Ilist*"
    (previous-line)
    (search-forward-regexp "\\+ ")
    (forward-line)
    (imenu-list-display-dwim)))


(define-minor-mode beorged/config-mode
  "Configuration mode"
  
  :init-value nil
  :global nil
  :keymap (let* ((map (make-sparse-keymap)))
            (bind-key "C-c C-p"   #'beorged/config-mode-prev-header map)
            (bind-key "C-c C-n"   #'beorged/config-mode-next-header map)
            (bind-key "C-c C-S-p" #'beorged/config-mode-prev-section map)
            (bind-key "C-c C-S-n" #'beorged/config-mode-next-section map)
            (bind-key "C-`"       #'beorged/org-sidebar-toggle map)
            (bind-key "C-c C-v t" #'beorged/org-babel-tangle map)
            (bind-key "C-c t"     #'beorged/org-toggle-blocks map)
            map)

  (require 'org)
  (if beorged/config-mode
      (beorged/org-sidebar)))

(defun beorged/config ()
  "Create a new for editing configuration"
  
  (interactive)
  (select-frame (make-frame '((name . "beorged/config")
                              (width . 150)
                              (height . 45))))
  (find-file "~/Documents/GitHub/dotemacs/dotemacs.org")
  (beorged/config-mode))


(autoload 'beorged/config
  (expand-file-name "init.el" user-emacs-directory)
  "Autoloaded beorged/config command."
  t)
