
(defun beorged/make-frame ()
  "Create a new frame and switch to *scratch* buffer."

  (interactive)
  (select-frame (make-frame))
  (switch-to-buffer "*scratch*"))


(defun beorged/kill-emacs ()
  "Delete frame or kill Emacs if there is only one frame."
  
  (interactive)
  (condition-case nil
      (delete-frame)
    (error (save-buffers-kill-terminal))))

(require 'frame)

;; Default frame settings
(setq default-frame-alist '((min-height . 1)  '(height . 45)
                            (min-width  . 1)  '(width  . 81)
                            (vertical-scroll-bars . nil)
                            (internal-border-width . 24)
                            (left-fringe . 0)
                            (right-fringe . 0)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 1)))

;; Default frame settings
(setq initial-frame-alist default-frame-alist)


(bind-key "M-n"        #'beorged/make-frame)
(bind-key "C-x C-c"    #'beorged/kill-emacs)
(bind-key "M-`"        #'other-frame)
(bind-key "C-z"        nil)
(bind-key "<M-return>" #'toggle-frame-maximized)

(bind-key "M-n"        #'beorged/make-frame)
(bind-key "C-x C-c"    #'beorged/kill-emacs)
(bind-key "M-`"        #'other-frame)
(bind-key "C-z"        nil)
(bind-key "<M-return>" #'toggle-frame-maximized)
