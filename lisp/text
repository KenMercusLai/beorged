
(setq-default use-short-answers t                     ; Replace yes/no prompts with y/n
              confirm-nonexistent-file-or-buffer nil) ; Ok to visit non existent files

(delete-selection-mode 1)

(defun beorged/fill-unfill ()
  "Like `fill-paragraph', but unfill if used twice."
  
  (interactive)
  (let ((fill-column
         (if (eq last-command #'beorged/fill-unfill)
             (progn (setq this-command nil)
                    (point-max))
           fill-column)))
    (call-interactively #'fill-paragraph)))

(bind-key "M-q"  #'beorged/fill-unfill)
;; (bind-key [remap fill-paragraph]  #'beorged/fill-unfill)
