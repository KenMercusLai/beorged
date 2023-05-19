
(defun beorged/deft-parse-summary (orig-fun contents title)
  "Filter deft summary in order to extract the first dot
terminated sentence and add tags if any."

  (let ((summary (apply orig-fun (list contents title)))
        (tags nil))
    (when (and (stringp contents)
               (string-match "#\\+TAGS:\\(.*\\)$" contents))
      (setq tags (split-string (string-trim (match-string 1 contents))
                                 "[ ,]")))
    (if (and (stringp summary)
             (string-match "\\(.*?\\)\\. " summary))
        (concat
         (when tags
           (concat (propertize (car tags)
                               'display (svg-tag-make (car tags)
                                                      :face 'nano-popout
                                                      :inverse t))
                   " "))
         (match-string 1 summary))
      summary)))

(advice-add 'deft-parse-summary :around #'beorged/deft-parse-summary)


(defun deft-note-toggle-keywords ()
  "Toggle visibility of all keywords."
  
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "^\\(#\\+.*\\)$" nil t)
    (if (get-text-property (match-beginning 1) 'display)
        (deft-note-show-keywords)
      (deft-note-hide-keywords))))
        
(defun deft-note-hide-keywords ()
  "Hide all keywords."
  
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^\\(#\\+.*\\)$" nil t)
      ;; (message (format "Hiding keyword %s" (match-string 1)))
      (put-text-property
        (match-beginning 1) (+ (match-end 1) 1) 'display ""))))

(defun deft-note-show-keywords ()
  "Show all keywords."
  
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^\\(#\\+.*\\)$" nil t)
      ;; (message (format "Showing keyword %s" (match-string 1)))
      (remove-text-properties
        (match-beginning 1) (+ (match-end 1) 1) '(display)))))

(defun deft-note-get-keyword (keyword)
  "Get the value of a KEYWORD"
  
  (interactive)
  (let ((case-fold-search t)
        (re (format "^#\\+%s:[ \t]+\\([^\t\n]+\\)" keyword)))
    (if (save-excursion (or (re-search-forward re nil t)
                            (re-search-backward re nil t)))
        (substring-no-properties (match-string 1)))))

(defun deft-note-set-keyword (keyword value)
  "Set the VALUE of KEYWORD, creates it if absent."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (deft-note-get-keyword keyword)
        (replace-match value t nil nil 1)
      (insert (format "#+%s: %s\n" keyword value)))))
