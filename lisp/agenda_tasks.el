;; A custom date format function using svg tags (progress pies) for the task agenda.
(defun beorged/org-agenda-custom-date ()
  (interactive)
  (let* ((timestamp (org-entry-get nil "TIMESTAMP"))
         (timestamp (or timestamp (org-entry-get nil "DEADLINE"))))
    (if timestamp
        (let* ((delta (- (org-time-string-to-absolute (org-read-date nil nil timestamp))
                         (org-time-string-to-absolute (org-read-date nil nil ""))))
               (delta (/ (+ 1 delta) 30.0))
               (face (cond ;; ((< delta 0.25) 'nano-popout)
                           ;; ((< delta 0.50) 'nano-salient)
                           ((< delta 1.00) 'nano-default)
                           (t 'nano-faded))))
          (concat
           (propertize " " 'face nil
                       'display (svg-lib-progress-pie
                                 delta nil
                                 :background (face-background face nil 'default)
                                 :foreground (face-foreground face)
                                 :margin 0 :stroke 2 :padding 1))
           " "
           (propertize
            (format-time-string "%d/%m" (org-time-string-to-time timestamp))
            'face 'nano-popout)))
      "     ")))

;; The task agenda
(add-to-list 'org-agenda-custom-commands
        '("x" "Tasks"
          ((todo "TODO" ;; "PROJECT"
                 ( (org-agenda-todo-keyword-format ":%s:")
                   (org-agenda-prefix-format '((todo   . " ")))
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp))
                   (org-agenda-overriding-header (propertize " Todo \n" 'face 'nano-strong))))

           (tags "+TALK+TIMESTAMP>=\"<now>\""
                 ((org-agenda-span 90)
                  (org-agenda-max-tags 5)
                  (org-agenda-prefix-format '((tags   . " %(beorged/org-agenda-custom-date) ")))
                  (org-agenda-overriding-header "\n Upcoming talks\n")))

           (tags "TEACHING+TIMESTAMP>=\"<now>\""
                 ((org-agenda-span 90)
                  (org-agenda-max-tags 5)
                  (org-agenda-prefix-format '((tags   . " %(beorged/org-agenda-custom-date) ")))
                  (org-agenda-overriding-header "\n Upcoming lessons\n")))

           (tags "TRAVEL+TIMESTAMP>=\"<now>\""
                 ((org-agenda-span 90)
                  (org-agenda-max-tags 5)
                  (org-agenda-prefix-format '((tags .  " %(beorged/org-agenda-custom-date) ")))
                  (org-agenda-overriding-header "\n Upcoming travels\n")))

           (tags "DEADLINE>=\"<today>\""
                  ((org-agenda-span 90)
                   (org-agenda-max-tags 5)
                   (org-agenda-prefix-format '((tags .  " %(beorged/org-agenda-custom-date) ")))
                   (org-agenda-overriding-header "\n Upcoming deadlines\n"))))))
