
(setq org-capture-templates
      '(("j" "Journal"  entry   (file default_journal)
         "* TODO %?Task :INBOX:\n")

        ("m" "Meeting" entry  (file+headline "agenda.org" "Future")
         "* %?Meeting   <%<%Y-%m-%d %a 12:00-13:00>>"
         :empty-lines-after 1)))
      
;; Assign key
(bind-key "C-c c" #'org-capture)

(defun beorged/org-capture-meeting ()
  (interactive)
  (org-capture nil "m"))

(bind-key "C-c m" #'beorged/org-capture-meeting)

(defun beorged/org-capture-journal ()
  (interactive)
  (org-capture nil "j"))

(bind-key "C-c j" #'beorged/org-capture-journal)

;; Here we orverwrite the org-capture-place-template to have the capture window below the current one. There must be a better way to do that but I did not find it yet. Since we are in org-agenda deferred mode, we need to cancel epiloque/prologue.
(with-eval-after-load 'org-capture

  (defun org-capture-place-template (&optional inhibit-wconf-store)
    "Insert the template at the target location, and display the buffer.
when `inhibit-wconf-store', don't store the window configuration, as it
may have been stored before."
    (unless inhibit-wconf-store
      (org-capture-put :return-to-wconf (current-window-configuration)))
    ;; (delete-other-windows)
    ;; (org-switch-to-buffer-other-window
    ;;  (org-capture-get-indirect-buffer (org-capture-get :buffer) "CAPTURE"))
    (select-window (split-window-below -6))
    (switch-to-buffer
     (org-capture-get-indirect-buffer (org-capture-get :buffer) "CAPTURE"))
    (widen)
    (org-show-all)
    (goto-char (org-capture-get :pos))
    (setq-local outline-level 'org-outline-level)
    (pcase (org-capture-get :type)
      ((or `nil `entry) (org-capture-place-entry))
      (`table-line (org-capture-place-table-line))
      (`plain (org-capture-place-plain-text))
      (`item (org-capture-place-item))
      (`checkitem (org-capture-place-item)))
    (setq-local org-capture-current-plist org-capture-plist)
    (org-capture-mode 1)))


(defun beorged/org-capture-frame (orig-fun &optional goto keys)
  (if (not (org-capture-get :description))
      (funcall orig-fun goto keys))
  (progn
    (select-frame (beorged/mini-frame 8))
    (let ((split-width-threshold nil)
          (split-height-threshold 0))
      (funcall orig-fun goto keys))
    (delete-other-windows)
    (setq word-wrap nil)
    (setq truncate-lines nil)
    (nano-modeline--update-selected-window)
    (let* ((left (concat (propertize " "
                                     'face '(nano-subtle)
                                     'display '(raise +0.20))
                         (propertize " Capture"
                                     'face '(nano-strong nano-subtle))
                         (propertize " "
                                     'face 'nano-subtle
                                     'display '(raise -0.30))
                         (propertize (org-capture-get :description)
                                     'face 'nano-default)))
                 (right (propertize "C-c C-c: capture, C-c C-k: abort "
                                    'face '(:inherit (nano-faded nano-subtle)
                                            :weight light)))
         (spacer (propertize (make-string (- (window-width)
                                             (length left)
                                             (length right)
                                             0) ?\ )
                             'face 'nano-subtle))
         (header (concat left spacer right " ")))
    (setq-local header-line-format header))
    
    (set-window-dedicated-p nil t)
    (set-frame-parameter (selected-frame) 'height 5)
    (face-remap-add-relative 'mode-line :background (face-background 'highlight))
    (save-excursion
      (goto-char (point-min))
      (let ((overlay (make-overlay
                      (line-beginning-position) (line-end-position))))
        (overlay-put overlay 'display '(raise -0.5))))))


(defun beorged/org-capture (goto key)
  (interactive)
  (unwind-protect
      (progn
        (advice-add 'org-capture :around #'beorged/org-capture-frame)
        (org-capture goto key))
    (advice-remove 'org-capture #'beorged/org-capture-frame)))

(require 'org-capture)
  
;; (bind-key "C-c m" #'(lambda ()
;;                       (interactive)
;;                       (beorged/org-capture nil "m")))

;; (bind-key "C-c i" #'(lambda ()
;;                       (interactive)
;;                       (beorged/org-capture nil "i")))

;; (bind-key "C-g" #'org-capture-kill 'org-capture-mode-map)
