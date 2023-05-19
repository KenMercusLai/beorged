;;The default org-agenda-goto, which is used when tab key is pressed or when follow mode (F) is active open a window at a non specific place. Here, we make sure the window is opened where we want. In this case, this is below the agenda window.

(defun beorged/org-agenda-goto (buffer args)
  "Open a headline in a window below the current window"
  
  (setq-local mode-line-format nil)
  (select-window (or (window-in-direction 'below (selected-window))
                     (split-window nil -6 'below)))
  (switch-to-buffer buffer)
  (setq-local header-line-format
              '((:eval
                 (let ((nano-modeline-prefix 'none)
                       (nano-modeline-prefix-padding 0)
                       (outline-path (org-with-point-at (org-get-at-bol'org-marker)
                                       (org-display-outline-path nil nil " » " t))))
                   (nano-modeline-render
                    ""
                    (file-name-nondirectory
                     (buffer-file-name (buffer-base-buffer)))
                    (format "/ %s" (substring-no-properties outline-path))
                    "")))))
  (selected-window))

;; Install the new function as an advice around org-agenda-goto and apply a narrow to subtree after

(define-advice org-agenda-goto (:around (orig-fn &rest args) "beorged/org-agenda-goto")
  (let ((display-buffer-overriding-action '(beorged/org-agenda-goto)))
    (apply orig-fn args)
    (org-narrow-to-subtree)))

;; Finally, we disable org-agenda-show-outline-path since this is now redundant with the header line.

(setq org-agenda-show-outline-path nil)
