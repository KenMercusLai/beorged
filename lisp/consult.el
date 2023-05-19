;; We replace some of emacs functions with their consult equivalent
(require 'consult)

(setq consult-preview-key nil) ; No live preview

(bind-key "C-x C-r" #'consult-recent-file)
(bind-key "C-x h"   #'consult-outline)
(bind-key "C-x b"   #'consult-buffer)
(bind-key "C-c h"   #'consult-history)
;; (bind-key "M-:"     #'consult-complex-command)


;; For the consult-goto-line and consult-line commands, we define our owns with live preview (independently of the consult-preview-key)
(defun beorged/consult-line ()
  "Consult line with live preview"
  
  (interactive)
  (let ((consult-preview-key 'any)
        (mini-frame-resize 'grow-only)) ;; !! Important
    (consult-line)))

(bind-key "C-s"   #'beorged/consult-line)


(defun beorged/consult-goto-line ()
  "Consult goto line with live preview"
  
  (interactive)
  (let ((consult-preview-key 'any))
    (consult-goto-line)))

(bind-key "M-g g"   #'beorged/consult-goto-line)
(bind-key "M-g M-g" #'beorged/consult-goto-line)
