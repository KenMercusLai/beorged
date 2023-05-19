;; Setup note modes and ask for a title if the file does not exist
(defun beorged/deft-open-file ()
  "Setup note modes and ask for a title if the file does not exist."
  
  (when (= (buffer-size (current-buffer)) 0)
    (setq title (read-from-minibuffer "Note title: "))
    (deft-note-set-keyword "DATE" (format-time-string "[%Y-%m-%d %a]"))
    (deft-note-set-keyword "TITLE" (if (> (length title) 0)
                                       title
                                     "New note"))
    (org-mode)
    (org-indent-mode)
    (visual-line-mode)))

(add-hook 'deft-open-file-hook 'beorged/deft-open-file)
