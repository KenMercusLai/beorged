(require 'imenu)
(require 'imenu-list)

(defun beorged/org-tree-to-indirect-buffer ()
  "Create indirect buffer, narrow it to current subtree and unfold blocks"
  
  (org-tree-to-indirect-buffer)
  (org-show-block-all)
  (setq-local beorged/org-blocks-hidden nil))

(defun beorged/org-sidebar ()
  "Open an imenu list on the left that allow navigation."
  
  (interactive)
  (setq imenu-list-after-jump-hook #'beorged/org-tree-to-indirect-buffer
        imenu-list-position 'left
        imenu-list-size 36
        imenu-list-focus-after-activation t)

  (let ((heading (substring-no-properties (or (org-get-heading t t t t) ""))))
    (when (buffer-base-buffer)
      (switch-to-buffer (buffer-base-buffer)))
    (imenu-list-minor-mode)
    (imenu-list-stop-timer)
    (hl-line-mode)
    (face-remap-add-relative 'hl-line :inherit 'nano-subtle)
    (setq header-line-format
          '(:eval
            (nano-modeline-render nil
                                  (buffer-name imenu-list--displayed-buffer)
                                  "(outline)"
                                  "")))
    (setq-local cursor-type nil)
    (when (> (length heading) 0)
      (goto-char (point-min))
      (search-forward heading)
      (imenu-list-display-dwim))))

(defun beorged/org-sidebar-toggle ()
  "Toggle the org-sidebar"
  
  (interactive)
  (if (get-buffer-window "*Ilist*")
      (progn 
        (quit-window nil (get-buffer-window "*Ilist*"))
        (switch-to-buffer (buffer-base-buffer)))
    (beorged/org-sidebar)))

(defun beorged/org-babel-tangle ()
  "Write code blocks to source-specific files from the base buffer."

  (interactive)
  (with-current-buffer (or (buffer-base-buffer)
                           (current-buffer))
    (org-babel-tangle)))

(defvar beorged/org-blocks-hidden nil)

(defun beorged/org-toggle-blocks ()
  "Toggle code blocks folding."
  
  (interactive)
  (if beorged/org-blocks-hidden
      (org-show-block-all)
    (org-hide-block-all))
  (setq-local beorged/org-blocks-hidden (not beorged/org-blocks-hidden)))

(add-hook 'config-mode-hook #'beorged/org-toggle-blocks)

(defvar beorged/imenu-list-folding-status t
  "Folding status of the imenu-list")

(defun beorged/imenu-list-toggle-folding ()
  "Toggle top level nodes of the imenu-list buffer"
  
  (interactive)
  (with-current-buffer "*Ilist*"
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "^\\+ " nil t)
        (if beorged/imenu-list-folding-status
            (hs-hide-block)
          (hs-show-block)))
      (setq beorged/imenu-list-folding-status (not beorged/imenu-list-folding-status)))))

(bind-key "S-<tab>" #'beorged/imenu-list-toggle-folding imenu-list-major-mode-map)

(defun beorged/display-code-line-counts (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (overlay-put ov 'display
                 (propertize
                  (format " [%d sections] … "
                          (- (count-lines (overlay-start ov)
                                       (overlay-end ov)) 1))
                  'face 'nano-faded))))

(setq hs-set-up-overlay #'beorged/display-code-line-counts)

(defun beorged/imenu-list-display-dwim ()
  "Display or toggle the entry at `point'."
  (interactive)
  (save-selected-window
    (save-excursion
      (beorged/imenu-list-ret-dwim))))

(defun beorged/imenu-list-ret-dwim ()
  "Jump to or toggle the entry at `point'."
  (interactive)
  (save-excursion
    (let ((entry (imenu-list--find-entry)))
      (when (imenu--subalist-p entry)
        (setq entry (cons
                     (car entry)
                     (get-text-property 0 'marker (car entry)))))
      (imenu-list--goto-entry entry))))

(bind-key "<SPC>" #'beorged/imenu-list-display-dwim imenu-list-major-mode-map)
(bind-key "<return>" #'beorged/imenu-list-ret-dwim imenu-list-major-mode-map)
