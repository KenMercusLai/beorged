;; The daily agenda

(add-to-list 'org-agenda-custom-commands
             '("a" "Agenda"
               ((agenda "Agenda"
                        ((org-agenda-todo-keyword-format "%s")
                         (org-agenda-skip-deadline-if-done nil)
                         (org-deadline-warning-days 3)
                         (org-agenda-overriding-header nil))))))

;; Some decorations for the agenda
(defun beorged/org-agenda-highlight-todo (x)
  (let* ((done (string-match-p (regexp-quote ":DONE:") x))
         (canceled (string-match-p (regexp-quote "~") x))
         (x (replace-regexp-in-string ":TODO:" "" x))
         (x (replace-regexp-in-string ":DONE:" "" x))
         (x (replace-regexp-in-string "~" "" x))
         (x (if (and (boundp 'org-agenda-dim) org-agenda-dim)
                (propertize x 'face 'nano-faded) x))
         (x (if done (propertize x 'face 'nano-faded) x))
         (x (if canceled (propertize x 'face 'nano-faded) x)))
    x))

(advice-add 'org-agenda-highlight-todo
            :filter-return #'beorged/org-agenda-highlight-todo)

;; Timestamp tags for the agenda (bold means inverse video below):
;; now -> now 9:00 -> 9h00 9:30-10:00 -> 9h30 | 30mn -> ANYTIME
(require 'svg-lib)
(require 'svg-tag-mode)
 
(defun beorged/svg-tag-timestamp (&rest args)
  "Create a timestamp SVG tag for the time at point."
  
  (interactive)
  (let ((inhibit-read-only t))

    (goto-char (point-min))
    (while (search-forward-regexp
            "\\(\([0-9]/[0-9]\):\\)" nil t)
              (set-text-properties (match-beginning 1) (match-end 1)
                             `(display ,(svg-tag-make "ANYTIME"
                                                      :face 'nano-faded
                                                      :inverse nil
                                                      :padding 3 :alignment 0))))

    (goto-char (point-min))
    (while (search-forward-regexp
            "\\([0-9]+:[0-9]+\\)\\(\\.+\\)" nil t)

              (set-text-properties (match-beginning 1) (match-end 2)
                             `(display ,(svg-tag-make (match-string 1)
                                                       :face 'nano-faded
                                                       :margin 4 :alignment 0))))

    (goto-char (point-min))
    (while (search-forward-regexp
            "\\([0-9]+:[0-9]+\\)\\(\\.*\\)" nil t)

              (set-text-properties (match-beginning 1) (match-end 2)
                             `(display ,(svg-tag-make (match-string 1)
                                                      :face 'nano-default
                                                      :inverse t
                                                      :margin 4 :alignment 0))))
    (goto-char (point-min))
    (while (search-forward-regexp
            "\\([0-9]+:[0-9]+\\)\\(-[0-9]+:[0-9]+\\)" nil t)
      (let* ((t1 (parse-time-string (match-string 1)))
             (t2 (parse-time-string (substring (match-string 2) 1)))
             (t1 (+ (* (nth 2 t1) 60) (nth 1 t1)))
             (t2 (+ (* (nth 2 t2) 60) (nth 1 t2)))
             (d  (- t2 t1)))

        (set-text-properties (match-beginning 1) (match-end 1)
                                `(display ,(svg-tag-make (match-string 1)
                                                         :face 'nano-faded
                                                         :crop-right t)))
        ;; 15m: ¼, 30m:½, 45m:¾
        (if (< d 60)
             (set-text-properties (match-beginning 2) (match-end 2)
                                  `(display ,(svg-tag-make (format "%2dm" d)
                                                           :face 'nano-faded
                                                           :crop-left t :inverse t)))
           (set-text-properties (match-beginning 2) (match-end 2)
                                `(display ,(svg-tag-make (format "%1dH" (/ d 60))
                                                         :face 'nano-faded
                                                         :crop-left t :inverse t
                                                         :padding 2 :alignment 0))))))))


(add-hook 'org-agenda-mode-hook #'beorged/svg-tag-timestamp)
(advice-add 'org-agenda-redo :after #'beorged/svg-tag-timestamp)
