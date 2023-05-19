;; We install a time to refresh the daily agenda (a) at regular intervals such that the current time is up to date.

(defvar beorged/org-agenda-update-delay 60)
(defvar beorged/org-agenda-update-timer nil)

(defun beorged/org-agenda-update ()
  "Refresh daily agenda view"
  
  (when beorged/org-agenda-update-timer
    (cancel-timer beorged/org-agenda-update-timer))
  
  (let ((window (get-buffer-window "*Org Agenda(a)*" t)))
    (when window
      (with-selected-window window
        (let ((inhibit-message t))
          (org-agenda-redo)))))

  (setq beorged/org-agenda-update-timer
    (run-with-idle-timer
     (time-add (current-idle-time) beorged/org-agenda-update-delay)
     nil
     'beorged/org-agenda-update)))

(run-with-idle-timer beorged/org-agenda-update-delay t 'beorged/org-agenda-update)
