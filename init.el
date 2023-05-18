;; -*- lexical-binding: t -*-
(defvar beorged/init-start-time (current-time) "Time when init.el was started")
(defvar beorged/section-start-time (current-time) "Time when section was started")
(defun beorged/report-time (section)
  (message "%-36s %.2fs"
           (concat section " " "section time: ")
           (float-time (time-subtract (current-time) beorged/section-start-time))))
(message "---------------------------------------------------------------")

(setq
 site-run-file nil                         ; No site-wide run-time initializations. 
 inhibit-default-init t                    ; No site-wide default library
 gc-cons-threshold most-positive-fixnum    ; Very large threshold for garbage
                                           ; collector during init
 package-enable-at-startup nil)            ; We'll use straight.el

(setq native-comp-eln-load-path
      (list (expand-file-name "eln-cache" user-emacs-directory)))

;; Reset garbage collector limit after init process has ended (8Mo)
(add-hook 'after-init-hook
          #'(lambda () (setq gc-cons-threshold (* 8 1024 1024))))

(add-to-list 'load-path "~/.emacs.d/")

(load "package_mgt")
(load "package_installation")
(load "startup")
(load "path")
(load "recovery")
(load "backups")
(load "bookmarks")
(load "recent_files")
(load "history")
(load "cursor")
(load "customization")

(require 'server)

(unless (server-running-p)
  (server-start))

(load "custom_modules")
(load "sidebar")

;; string related
;; (setq beorged/section-start-time (current-time))
;; (defun beorged/string-pad-right (len s)
;;   "If S is shorter than LEN, pad it on the right,
;;    if S is longer than LEN, truncate it on the right."

;;   (if (> (length s) len)
;;       (concat (substring s 0 (- len 1)) "…")
;;     (concat s (make-string (max 0 (- len (length s))) ?\ ))))


;; (defun beorged/string-pad-left (len s)
;;   "If S is shorter than LEN, pad it on the left,
;;    if S is longer than LEN, truncate it on the left."
  
;;   (if (> (length s) len)
;;       (concat  "…" (substring s (- (length s) len -1)))
;;     (concat (make-string (max 0 (- len (length s))) ?\ ) s)))

;; (defun beorged/string-join (len left right &optional spacing)
;;   "Join LEFT and RIGHT strings to fit LEN characters with at least SPACING characters 
;; between them. If len is negative, it is retrieved from current window width."

;;     (let* ((spacing (or spacing 3))
;;            (len (or len (window-body-width)))
;;            (len (if (< len 0)
;;                    (+ (window-body-width) len)
;;                   len)))
;;       (cond ((> (length right) len)
;;              (beorged/string-pad-left len right))

;;             ((> (length right) (- len spacing))
;;              (beorged/string-pad-left len (concat (make-string spacing ?\ )
;;                                         right)))

;;             ((> (length left) (- len spacing (length right)))
;;              (concat (beorged/string-pad-right (- len spacing (length right)) left)
;;                      (concat (make-string spacing ?\ )
;;                              right)))
;;             (t
;;              (concat left
;;                      (make-string (- len (length right) (length left)) ?\ )
;;                      right)))))

;; ;; Date related
;; (setq beorged/section-start-time (current-time))
;; (defun beorged/date-day (date)
;;   "Return DATE day of month (1-31)."

;;   (nth 3 (decode-time date)))

;; (defun beorged/date-month (date)
;;   "Return DATE month number (1-12)."
  
;;   (nth 4 (decode-time date)))

;; (defun beorged/date-year (date)
;;   "Return DATE year."

;;   (nth 5 (decode-time date)))

;; (defun beorged/date-equal (date1 date2)
;;   "Check if DATE1 is equal to DATE2."
  
;;   (and (eq (beorged/date-day date1)
;;            (beorged/date-day date2))
;;        (eq (beorged/date-month date1)
;;            (beorged/date-month date2))
;;        (eq (beorged/date-year date1)
;;            (beorged/date-year date2))))

;; (defun beorged/date-inc (date &optional days months years)
;;   "Return DATE + DAYS day & MONTH months & YEARS years"

;;   (let ((days (or days 0))
;;         (months (or months 0))
;;         (years (or years 0))
;;         (day (beorged/date-day date))
;;         (month (beorged/date-month date))
;;         (year (beorged/date-year date)))
;;     (encode-time 0 0 0 (+ day days) (+ month months) (+ year years))))


;; (defun beorged/date-dec (date &optional days months years)
;;   "Return DATE - DAYS day & MONTH months & YEARS years"
  
;;   (let ((days (or days 0))
;;         (months (or months 0))
;;         (years (or years 0)))
;;     (beorged/date-inc date (- days) (- months) (- years))))


;; (defun beorged/date-today ()
;;   "Return today date."
  
;;   (current-time))


;; (defun beorged/date-is-today (date)
;;   "Check if DATE is today."
  
;;   (beorged/date-equal (current-time) date))


;; (defun beorged/date-is-yesterday (date)
;;   "Check if DATE is yesterday."
  
;;   (beorged/date-equal (beorged/date-dec (beorged/date-today) 1) date))


;; (defun beorged/date-relative (date)
;;   "Return a string with a relative date format."

;;   (let* ((now (current-time))
;;          (delta (float-time (time-subtract now date)))
;;          (days (ceiling (/ (float-time (time-subtract now date)) (* 60 60 24)))))
;;     (cond ((< delta (*       3 60))     "now")
;;           ((< delta (*      60 60))     (format "%d minutes ago" (/ delta   60)))
;;           ;;  ((< delta (*    6 60 60))     (format "%d hours ago"   (/ delta 3600)))
;;           ((beorged/date-is-today date)      (format-time-string "%H:%M" date))
;;           ((beorged/date-is-yesterday date)  (format "Yesterday"))
;;           ((< delta (* 4 24 60 60))     (format "%d days ago" (+ days 1)))
;;           (t                            (format-time-string "%d %b %Y" date)))))


;; ;; Mini frame
;; (setq beorged/section-start-time (current-time))
;; (defun beorged/mini-frame (&optional height foreground background border)
;;   "Create a child frame positionned over the header line whose
;; width corresponds to the width of the current selected window.

;; The HEIGHT in lines can be specified, as well as the BACKGROUND
;; color of the frame. BORDER width (pixels) and color (FOREGROUND)
;; can be also specified."
  
;;   (interactive)
;;   (let* ((foreground (or foreground
;;                          (face-foreground 'font-lock-comment-face nil t)))
;;          (background (or background (face-background 'highlight nil t)))
;;          (border (or border 1))
;;          (height (round (* (or height 8) (window-font-height))))
;;          (edges (window-pixel-edges))
;;          (body-edges (window-body-pixel-edges))
;;          (top (nth 1 edges))
;;          (bottom (nth 3 body-edges))
;;          (left (- (nth 0 edges) (or left-fringe-width 0)))
;;          (right (+ (nth 2 edges) (or right-fringe-width 0)))
;;          (width (- right left))

;;          ;; Window divider mode
;;          (width (- width (if (and (bound-and-true-p window-divider-mode)
;;                                   (or (eq window-divider-default-places 'right-only)
;;                                       (eq window-divider-default-places t))
;;                                 (window-in-direction 'right (selected-window)))
;;                              window-divider-default-right-width
;;                            0)))
;;          (y (- top border))
;;          (child-frame-border (face-attribute 'child-frame-border :background)))
;;     (set-face-attribute 'child-frame-border t :background foreground)
;;     (let ((frame (make-frame
;;                   `((parent-frame . ,(window-frame))
;;                     (delete-before . ,(window-frame))
;;                     (minibuffer . nil)
;;                     (modeline . nil)
;;                     (left . ,(- left border))
;;                     (top . ,y)
;;                     (width . (text-pixels . ,width))
;;                     (height . (text-pixels . ,height))
;;                     ;; (height . ,height)
;;                     (child-frame-border-width . ,border)
;;                     (internal-border-width . ,border)
;;                     (background-color . ,background)
;;                     (horizontal-scroll-bars . nil)
;;                     (menu-bar-lines . 0)
;;                     (tool-bar-lines . 0)
;;                     (desktop-dont-save . t)
;;                     (unsplittable . nil)
;;                     (no-other-frame . t)
;;                     (undecorated . t)
;;                     (pixelwise . t)
;;                     (visibility . t)))))
;;       (set-face-attribute 'child-frame-border t :background child-frame-border)
;;       frame)))


;; (defun beorged/mini-frame-reset (frame)
;;   "Reset FRAME size and position.

;;   Move frame at the top of parent frame and resize it
;;   horizontally to fit the width of current selected window."
  
;;   (interactive)
;;   (let* ((border (frame-parameter frame 'internal-border-width))
;;          (height (frame-parameter frame 'height)))
;;     (with-selected-frame (frame-parent frame)
;;       (let* ((edges (window-pixel-edges))
;;              (body-edges (window-body-pixel-edges))
;;              (top (nth 1 edges))
;;              (bottom (nth 3 body-edges))
;;              (left (- (nth 0 edges) (or left-fringe-width 0)))
;;              (right (+ (nth 2 edges) (or right-fringe-width 0)))
;;              (width (- right left))
;;              (y (- top border)))
;;         (set-frame-width frame width nil t)
;;         (set-frame-height frame height)
;;         (set-frame-position frame (- left border) y)))))


;; (defun beorged/mini-frame-shrink (frame &optional delta)
;;   "Make the FRAME DELTA lines smaller.

;;   If no argument is given, make the frame one line smaller. If
;;   DELTA is negative, enlarge frame by -DELTA lines."

;;   (interactive)
;;   (let ((delta (or delta -1)))
;;     (when (and (framep frame)
;;                (frame-live-p frame)
;;                (frame-visible-p frame))
;;       (set-frame-parameter frame 'height
;;                            (+ (frame-parameter frame 'height) delta)))))

;; (setq straight-check-for-modifications nil) ;;disable checking (for speedup)
;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 6))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))

;; (setq package-list
;;       '(cape                ; Completion At Point Extensions
;;         orderless           ; Completion style for matching regexps in any order
;;         vertico             ; VERTical Interactive COmpletion
;;         marginalia          ; Enrich existing commands with completion annotations
;;         consult             ; Consulting completing-read
;;         corfu               ; Completion Overlay Region FUnction
;;         deft                ; Quickly browse, filter, and edit plain text notes
;;         elpher              ; A friendly gopher and gemini client 
;;         f                   ; Modern API for working with files and directories
;;         citar               ; Citation-related commands for org, latex, markdown
;;         citeproc            ; A CSL 1.0.2 Citation Processor
;;         flyspell-correct-popup ; Correcting words with flyspell via popup interface
;;         flyspell-popup      ; Correcting words with Flyspell in popup menus
;;         guess-language      ; Robust automatic language detection
;;         helpful             ; A better help buffer
;;         htmlize             ; Convert buffer text and decorations to HTML
;;         mini-frame          ; Show minibuffer in child frame on read-from-minibuffer
;;         imenu-list          ; Show imenu entries in a separate buffer
;;         magit               ; A Git porcelain inside Emacs.
;;         markdown-mode       ; Major mode for Markdown-formatted text
;;         multi-term          ; Managing multiple terminal buffers in Emacs.
;;         pinentry            ; GnuPG Pinentry server implementation
;;         use-package         ; A configuration macro for simplifying your .emacs
;;         vc-backup           ; VC backend for versioned backups
;;         yaml-mode           ; YAML mode
;;         consult-recoll      ; Consult interface for recoll query
;;         org-auto-tangle     ; Tangle org file when it is saved
;;         exec-path-from-shell; Get environment variables such as $PATH from the shell 
;;         which-key))         ; Display available keybindings in popup

;; ;; Install packages that are not yet installed
;; (dolist (package package-list)
;;   (straight-use-package package))

;; ;; Special case for pdf-tools that has recently (2022) changed maintainer
;; ;;(straight-use-package
;; ;; '(pdf-tools :type git :host github :repo "vedang/pdf-tools"))

;; ;; Denote not yet on ELPA (2022-06-19)
;; ;;(straight-use-package
;; ;; '(denote :type git :host github :repo "protesilaos/denote"))

;; ;; Display org properties in the agenda buffer (modified version)
;; (straight-use-package
;;  '(org-agenda-property :type git :host github :repo "Malabarba/org-agenda-property"
;;                        :fork (:host github :repo "rougier/org-agenda-property")))

;; ;; NANO splash
;; (straight-use-package
;;  '(nano-splash :type git :host github :repo "rougier/nano-splash"))

;; ;; NANO theme
;; (straight-use-package
;;  '(nano-theme :type git :host github :repo "rougier/nano-theme"))

;; ;; NANO modeline
;; (straight-use-package
;;  '(nano-modeline :type git :host github :repo "rougier/nano-modeline"))

;; ;; NANO agenda
;; (straight-use-package
;;  '(nano-agenda :type git :host github :repo "rougier/nano-agenda"))

;; ;; NANO agenda
;; (straight-use-package
;;  '(minibuffer-header :type git :host github :repo "rougier/minibuffer-header"))

;; ;; SVG tags, progress bars & icons
;; (straight-use-package
;;  '(svg-lib :type git :host github :repo "rougier/svg-lib"))

;; ;; Replace keywords with SVG tags
;; (straight-use-package
;;  '(svg-tag-mode :type git :host github :repo "rougier/svg-tag-mode"))

;; ;; Relative date formatting
;; (straight-use-package
;;  '(relative-date :type git :host github :repo "rougier/relative-date"))

;; ;; org imenu
;; (straight-use-package
;;  '(org-imenu :type git :host github :repo "rougier/org-imenu"))

;; ;; pdf-drop-mode
;; (straight-use-package
;;  '(pdf-drop-mode :type git :host github :repo "rougier/pdf-drop-mode"))


;; ;; Bilbliography manager in org mode
;; (straight-use-package
;;   '(org-bib :type git :host github :branch "org-imenu" :repo "rougier/org-bib-mode"))



;; ;; sidebar
;; (require 'imenu)
;; (require 'imenu-list)

;; (defun beorged/org-tree-to-indirect-buffer ()
;;   "Create indirect buffer, narrow it to current subtree and unfold blocks"
  
;;   (org-tree-to-indirect-buffer)
;;   (org-show-block-all)
;;   (setq-local beorged/org-blocks-hidden nil))

;; (defun beorged/org-sidebar ()
;;   "Open an imenu list on the left that allow navigation."
  
;;   (interactive)
;;   (setq imenu-list-after-jump-hook #'beorged/org-tree-to-indirect-buffer
;;         imenu-list-position 'left
;;         imenu-list-size 36
;;         imenu-list-focus-after-activation t)

;;   (let ((heading (substring-no-properties (or (org-get-heading t t t t) ""))))
;;     (when (buffer-base-buffer)
;;       (switch-to-buffer (buffer-base-buffer)))
;;     (imenu-list-minor-mode)
;;     (imenu-list-stop-timer)
;;     (hl-line-mode)
;;     (face-remap-add-relative 'hl-line :inherit 'nano-subtle)
;;     (setq header-line-format
;;           '(:eval
;;             (nano-modeline-render nil
;;                                   (buffer-name imenu-list--displayed-buffer)
;;                                   "(outline)"
;;                                   "")))
;;     (setq-local cursor-type nil)
;;     (when (> (length heading) 0)
;;       (goto-char (point-min))
;;       (search-forward heading)
;;       (imenu-list-display-dwim))))


;; (defun beorged/org-sidebar-toggle ()
;;   "Toggle the org-sidebar"
  
;;   (interactive)
;;   (if (get-buffer-window "*Ilist*")
;;       (progn 
;;         (quit-window nil (get-buffer-window "*Ilist*"))
;;         (switch-to-buffer (buffer-base-buffer)))
;;     (beorged/org-sidebar)))


;; (defun beorged/org-babel-tangle ()
;;   "Write code blocks to source-specific files from the base buffer."

;;   (interactive)
;;   (with-current-buffer (or (buffer-base-buffer)
;;                            (current-buffer))
;;     (org-babel-tangle)))

;; (defvar beorged/org-blocks-hidden nil)

;; (defun beorged/org-toggle-blocks ()
;;   "Toggle code blocks folding."
  
;;   (interactive)
;;   (if beorged/org-blocks-hidden
;;       (org-show-block-all)
;;     (org-hide-block-all))
;;   (setq-local beorged/org-blocks-hidden (not beorged/org-blocks-hidden)))

;; (add-hook 'config-mode-hook #'beorged/org-toggle-blocks)


;; (defvar beorged/imenu-list-folding-status t
;;   "Folding status of the imenu-list")

;; (defun beorged/imenu-list-toggle-folding ()
;;   "Toggle top level nodes of the imenu-list buffer"
  
;;   (interactive)
;;   (with-current-buffer "*Ilist*"
;;     (save-excursion
;;       (goto-char (point-min))
;;       (while (re-search-forward "^\\+ " nil t)
;;         (if beorged/imenu-list-folding-status
;;             (hs-hide-block)
;;           (hs-show-block)))
;;       (setq beorged/imenu-list-folding-status (not beorged/imenu-list-folding-status)))))

;; (bind-key "S-<tab>" #'beorged/imenu-list-toggle-folding imenu-list-major-mode-map)


;; (defun beorged/display-code-line-counts (ov)
;;   (when (eq 'code (overlay-get ov 'hs))
;;     (overlay-put ov 'display
;;                  (propertize
;;                   (format " [%d sections] … "
;;                           (- (count-lines (overlay-start ov)
;;                                        (overlay-end ov)) 1))
;;                   'face 'nano-faded))))

;; (setq hs-set-up-overlay #'beorged/display-code-line-counts)


;; (defun beorged/imenu-list-display-dwim ()
;;   "Display or toggle the entry at `point'."
;;   (interactive)
;;   (save-selected-window
;;     (save-excursion
;;       (beorged/imenu-list-ret-dwim))))

;; (defun beorged/imenu-list-ret-dwim ()
;;   "Jump to or toggle the entry at `point'."
;;   (interactive)
;;   (save-excursion
;;     (let ((entry (imenu-list--find-entry)))
;;       (when (imenu--subalist-p entry)
;;         (setq entry (cons
;;                      (car entry)
;;                      (get-text-property 0 'marker (car entry)))))
;;       (imenu-list--goto-entry entry))))

;; (bind-key "<SPC>" #'beorged/imenu-list-display-dwim imenu-list-major-mode-map)
;; (bind-key "<return>" #'beorged/imenu-list-ret-dwim imenu-list-major-mode-map)

;; ;; filter
;; (bind-key "C-c f" #'beorged/org-imenu-filter)
;; (bind-key "f" #'beorged/org-imenu-filter imenu-list-major-mode-map)
;; (bind-key "U" #'imenu-list-refresh imenu-list-major-mode-map)

;; (setq org-imenu-depth 3)

;; (require 'org)
;; (require 'svg-tag-mode)

;; (defvar beorged/org-imenu-filter-history
;;   '("BINDING" "HOOK" "ADVICE" "FACE" "MODE" "DEFER"
;;     "PERSONAL" "INACTIVE" "BUGFIX" "OTHER" "TIMER" "OS")
;;   "Filter history list.")

;; (defvar beorged/org-imenu-filter-function
;;   (cdr (org-make-tags-matcher "*"))
;;   "Filter function to decide if a headline is kept")

;; (defun beorged/org-imenu-filter ()
;;   "Define and apply a new filter"
  
;;   (interactive)
;;   (let* ((match (completing-read-multiple
;;                  "FILTER: "
;;                  beorged/org-imenu-filter-history
;;                  nil nil nil
;;                  'beorged/org-imenu-filter-history))
;;          (match (mapconcat #'identity match " ")))
;;     (when (string= "" match)
;;       (setq match "*"))
;;     (setq beorged/org-imenu-filter-function
;;           (cdr (org-make-tags-matcher match)))
;;     (imenu-list-refresh)))


;; (defun beorged/org-imenu-filter-tree (&optional bound parent-match)
;;   "Build a imenu list using current filter function"
  
;;   (let* ((headlines '()))
;;     (save-excursion
;;       (org-with-wide-buffer
;;        (unless bound
;;          (setq bound (point-max))
;;          (goto-char (point-min)))
;;        (while (re-search-forward org-heading-regexp bound t)
;;          (let* ((element (org-element-at-point))
;;                 (begin (org-element-property :begin element))
;;                 (end (org-element-property :end element))
;;                 (marker (copy-marker begin))
;;                 (level (org-element-property :level element))
;;                 (tags (save-excursion
;;                          (goto-char begin)
;;                           (org-get-tags)))
;;                 (match (save-excursion
;;                          (goto-char begin)
;;                          (funcall beorged/org-imenu-filter-function
;;                                   nil (org-get-tags) level)))
                
;;                 (title (org-element-property :raw-value element))
;;                 (title (org-link-display-format
;;                         (substring-no-properties title)))
;;                 (title (propertize title 'org-imenu-marker marker
;;                                          'org-imenu t))
;;                 (title (if (member "INACTIVE" tags)
;;                            (propertize title 'face 'nano-faded)
;;                          title))
;;                 (svg-tags (mapconcat #'(lambda (tag)
;;                                      (propertize tag 'display (svg-tag-make tag :face 'nano-faded)))
;;                                  tags " "))
;;                 (title (if tags (format "%s %s" title svg-tags) title))
;;                 (title (propertize title 'marker marker))
;;                 (children (beorged/org-imenu-filter-tree end match)))
;;            (goto-char end)

;;            (cond ((> level org-imenu-depth)
;;                   nil)
;;                  ((> (length children) 0)
;;                   (add-to-list 'headlines (append (list title) children) t))
;;                  ((or match parent-match)
;;                   (add-to-list 'headlines (cons title marker) t)))))))
;;     headlines))

;; (advice-add #'org-imenu-get-tree :override #'beorged/org-imenu-filter-tree)


;; (add-hook 'org-mode-hook 'org-auto-tangle-mode)




;; ;; Startup
;; (setq-default
;;  inhibit-startup-screen t               ; Disable start-up screen
;;  inhibit-startup-message t              ; Disable startup message
;;  inhibit-startup-echo-area-message t    ; Disable initial echo message
;;  initial-scratch-message ""             ; Empty the initial *scratch* buffer
;;  initial-buffer-choice t)               ; Open *scratch* buffer at init

;; ;; Encoding
;; (set-default-coding-systems 'utf-8)     ; Default to utf-8 encoding
;; (prefer-coding-system       'utf-8)     ; Add utf-8 at the front for automatic detection.
;; (set-terminal-coding-system 'utf-8)     ; Set coding system of terminal output
;; (set-keyboard-coding-system 'utf-8)     ; Set coding system for keyboard input on TERMINAL
;; (set-language-environment "English")    ; Set up multilingual environment

;; ;; Recovery
;; (setq auto-save-list-file-prefix ; Prefix for generating auto-save-list-file-name
;;       (expand-file-name ".auto-save-list/.saves-" user-emacs-directory)
;;       auto-save-default t        ; Auto-save every buffer that visits a file
;;       auto-save-timeout 20       ; Number of seconds between auto-save
;;       auto-save-interval 200)    ; Number of keystrokes between auto-saves


;; ;; backups
;; (setq backup-directory-alist       ; File name patterns and backup directory names.
;;       `(("." . ,(expand-file-name "backups" user-emacs-directory)))
;;       make-backup-files t          ; Backup of a file the first time it is saved.
;;       vc-make-backup-files t       ; No backup of files under version contr
;;       backup-by-copying t          ; Don't clobber symlinks
;;       version-control t            ; Version numbers for backup files
;;       delete-old-versions t        ; Delete excess backup files silently
;;       kept-old-versions 6          ; Number of old versions to keep
;;       kept-new-versions 9          ; Number of new versions to keep
;;       delete-by-moving-to-trash t) ; Delete files to trash

;; ;; Back
;; (require 'vc-backup)




;; ;; dialogs
;; (setq-default show-help-function nil    ; No help text
;;               use-file-dialog nil       ; No file dialog
;;               use-dialog-box nil        ; No dialog box
;;               pop-up-windows nil)       ; No popup windows

;; (tooltip-mode -1)                       ; No tooltips
;; (scroll-bar-mode -1)                    ; No scroll bars
;; (tool-bar-mode -1)                      ; No toolbar

;; (menu-bar-mode 1)


;; ;; keyboard
;; (require 'which-key)

;; (which-key-mode)

;; ;; cursor
;; (setq-default cursor-in-non-selected-windows nil ; Hide the cursor in inactive windows
;;               cursor-type '(hbar . 2)            ; Underline-shaped cursor
;;               cursor-intangible-mode t           ; Enforce cursor intangibility
;;               x-stretch-cursor nil)              ; Don't stretch cursor to the glyph width

;; (blink-cursor-mode 0)                            ; Still cursor

;; ;; text
;; (setq-default use-short-answers t                     ; Replace yes/no prompts with y/n
;;               confirm-nonexistent-file-or-buffer nil) ; Ok to visit non existent files

;; ;; Replace region when inserting text
;; (delete-selection-mode 1)

;; ;; A smarter fill/unfill command
;; (defun beorged/fill-unfill ()
;;   "Like `fill-paragraph', but unfill if used twice."
  
;;   (interactive)
;;   (let ((fill-column
;;          (if (eq last-command #'my/fill-unfill)
;;              (progn (setq this-command nil)
;;                     (point-max))
;;            fill-column)))
;;     (call-interactively #'fill-paragraph)))

;; (bind-key "M-q"  #'beorged/fill-unfill)
;; ;; (bind-key [remap fill-paragraph]  #'beorged/fill-unfill)


;; ;; sound
;; (setq-default visible-bell nil             ; No visual bell      
;;               ring-bell-function 'ignore)  ; No bell

;; ;; scroll
;; (setq-default scroll-conservatively 101       ; Avoid recentering when scrolling far
;;               scroll-margin 2                 ; Add a margin when scrolling vertically
;;               recenter-positions '(5 bottom)) ; Set re-centering positions

;; ;; help
;; (setq help-window-select t)             ; Focus new help windows when opened

;; (bind-key "C-h f"   #'helpful-callable) ; Look up callable
;; (bind-key "C-h v"   #'helpful-variable) ; Look up variable
;; (bind-key "C-h k"   #'helpful-key)      ; Look up key 
;; (bind-key "C-c C-d" #'helpful-at-point) ; Look up the current symbol at point
;; (bind-key "C-h F"   #'helpful-function) ; Look up *F*unctions (excludes macros).
;; (bind-key "C-h C"   #'helpful-command)  ; Look up *C*ommands.

;; (require 'nano-theme)
;; (setq nano-fonts-use t) ; Use theme font stack
;; (nano-light)            ; Use theme light version
;; (nano-mode)             ; Recommended settings

;; ;; colors
;; (defun beorged/set-face (face style)
;;   "Reset FACE and make it inherit STYLE."
;;   (set-face-attribute face nil
;;                       :foreground 'unspecified :background 'unspecified
;;                       :family     'unspecified :slant      'unspecified
;;                       :weight     'unspecified :height     'unspecified
;;                       :underline  'unspecified :overline   'unspecified
;;                       :box        'unspecified :inherit    style))
;; (beorged/set-face 'italic 'nano-faded)

;; ;; the transient nano splash screen
;; (require 'nano-splash)

;; ;; tabulations
;; (setq-default indent-tabs-mode nil        ; Stop using tabs to indent
;;               tab-always-indent 'complete ; Indent first then try completions
;;               tab-width 4)                ; Smaller width for tab characters

;; ;; Let Emacs guess Python indent silently
;; (setq python-indent-guess-indent-offset t
;;       python-indent-guess-indent-offset-verbose nil)

;; ;; Parenthesis
;; (require 'paren)
;; ;; (setq show-paren-style 'expression)
;; (setq show-paren-style 'parenthesis)
;; (setq show-paren-when-point-in-periphery t)
;; (setq show-paren-when-point-inside-paren nil)
;; (show-paren-mode)

;; ;; Imenu list
;; (require 'imenu-list)

;; (setq-default imenu-list-position 'left
;;               imenu-max-item-length 1000)

;; ;; Highlighting
;; (require 'hl-line)

;; (global-hl-line-mode)

;; ;; Completion
;; (setq beorged/section-start-time (current-time))

;; ;; corfu
;; (require 'corfu)

;; (setq corfu-cycle t                ; Enable cycling for `corfu-next/previous'
;;       corfu-auto t                 ; Enable auto completion
;;       corfu-auto-delay 60.0        ; Delay before auto-completion shows up
;;       corfu-separator ?\s          ; Orderless field separator
;;       corfu-quit-at-boundary nil   ; Never quit at completion boundary
;;       corfu-quit-no-match t        ; Quit when no match
;;       corfu-preview-current nil    ; Disable current candidate preview
;;       corfu-preselect-first nil    ; Disable candidate preselection
;;       corfu-on-exact-match nil     ; Configure handling of exact matches
;;       corfu-echo-documentation nil ; Disable documentation in the echo area
;;       corfu-scroll-margin 5)       ; Use scroll margin

;; (global-corfu-mode)

;; ;; TAB cycle if there are only few candidates
;; (setq completion-cycle-threshold 3)

;; ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
;; ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
;; (setq read-extended-command-predicate
;;       #'command-completion-default-include-p)

;; ;; Enable indentation+completion using the TAB key.
;; ;; completion-at-point is often bound to M-TAB.
;; (setq tab-always-indent 'complete)

;; ;; Completion in source blocks
;; (require 'cape)

;; (add-to-list 'completion-at-point-functions 'cape-symbol)

;; ;; orderless
;; (require 'orderless)
  
;; (setq completion-styles '(substring orderless basic)
;;       orderless-component-separator 'orderless-escapable-split-on-space
;;       read-file-name-completion-ignore-case t
;;       read-buffer-completion-ignore-case t
;;       completion-ignore-case t)

;; ;; Modeline

;; (require 'nano-theme)
;; (require 'nano-modeline)

;; (setq nano-modeline-prefix 'status)
;; (setq nano-modeline-prefix-padding 1)

;; (set-face-attribute 'header-line nil)
;; (set-face-attribute 'mode-line nil
;;                     :foreground (face-foreground 'nano-subtle-i)
;;                     :background (face-foreground 'nano-subtle-i)
;;                     :inherit nil
;;                     :box nil)
;; (set-face-attribute 'mode-line-inactive nil
;;                     :foreground (face-foreground 'nano-subtle-i)
;;                     :background (face-foreground 'nano-subtle-i)
;;                     :inherit nil
;;                     :box nil)

;; (set-face-attribute 'nano-modeline-active nil
;;                     :underline (face-foreground 'nano-default-i)
;;                     :background (face-background 'nano-subtle)
;;                     :inherit '(nano-default-)
;;                     :box nil)
;; (set-face-attribute 'nano-modeline-inactive nil
;;                     :foreground 'unspecified
;;                     :underline (face-foreground 'nano-default-i)
;;                     :background (face-background 'nano-subtle)
;;                     :box nil)

;; (set-face-attribute 'nano-modeline-active-name nil
;;                     :foreground "black"
;;                     :inherit '(nano-modeline-active nano-strong))
;; (set-face-attribute 'nano-modeline-active-primary nil
;;                     :inherit '(nano-modeline-active))
;; (set-face-attribute 'nano-modeline-active-secondary nil
;;                     :inherit '(nano-faded nano-modeline-active))

;; (set-face-attribute 'nano-modeline-active-status-RW nil
;;                     :inherit '(nano-faded-i nano-strong nano-modeline-active))
;; (set-face-attribute 'nano-modeline-active-status-** nil
;;                     :inherit '(nano-popout-i nano-strong nano-modeline-active))
;; (set-face-attribute 'nano-modeline-active-status-RO nil
;;                     :inherit '(nano-default-i nano-strong nano-modeline-active))

;; (set-face-attribute 'nano-modeline-inactive-name nil
;;                     :inherit '(nano-faded nano-strong
;;                                nano-modeline-inactive))
;; (set-face-attribute 'nano-modeline-inactive-primary nil
;;                     :inherit '(nano-faded nano-modeline-inactive))

;; (set-face-attribute 'nano-modeline-inactive-secondary nil
;;                     :inherit '(nano-faded nano-modeline-inactive))
;; (set-face-attribute 'nano-modeline-inactive-status-RW nil
;;                     :inherit '(nano-modeline-inactive-secondary))
;; (set-face-attribute 'nano-modeline-inactive-status-** nil
;;                     :inherit '(nano-modeline-inactive-secondary))
;; (set-face-attribute 'nano-modeline-inactive-status-RO nil
;;                     :inherit '(nano-modeline-inactive-secondary))

;; (defun beorged/thin-modeline ()
;;   "Transform the modeline in a thin faded line"
  
;;   (nano-modeline-face-clear 'mode-line)
;;   (nano-modeline-face-clear 'mode-line-inactive)
;;   (setq mode-line-format (list ""))
;;   (setq-default mode-line-format (list ""))
;;   (set-face-attribute 'mode-line nil
;;                       :box nil
;;                       :inherit nil
;;                       :foreground (face-background 'nano-subtle)
;;                       :background (face-background 'nano-subtle)
;;                       :height 0.1)
;;   (set-face-attribute 'mode-line-inactive nil
;;                       :box nil
;;                       :inherit nil
;;                       :foreground (face-background 'nano-subtle)
;;                       :background (face-background 'nano-subtle)
;;                       :height 0.1))

;; (add-hook 'nano-modeline-mode-hook #'beorged/thin-modeline)
;; (nano-modeline-mode 1)

;; (require 'minibuffer-header)

;; (setq minibuffer-header-show-message t
;;       minibuffer-header-hide-prompt t
;;       minibuffer-header-default-message "")

;; (set-face-attribute 'minibuffer-header-face nil
;;                     :inherit 'nano-subtle
;;                     :extend t)
;; (set-face-attribute 'minibuffer-header-message-face nil
;;                     :inherit '(nano-subtle nano-faded)
;;                     :extend t)


;; (defun beorged/minibuffer-header-format (prompt)
;;   "Minibuffer header"
  
;;   (let* ((prompt (replace-regexp-in-string "[: \t]*$" "" prompt))
;;          (depth (minibuffer-depth))
;;          (prompt (cond ((string= prompt "M-x") "Extended command")
;;                        ((string= prompt "Function") "Help on function")
;;                        ((string= prompt "Callable") "Help on function or macro")
;;                        ((string= prompt "Variable") "Help on variable")
;;                        ((string= prompt "Command") "Help on command")
;;                        ((string= prompt "Eval") "Evaluate lisp expression")
;;                        (t prompt))))
;;     (concat
;;      (propertize (format " %d " depth)
;;                  'face `(:inherit (nano-salient-i nano-strong)
;;                          :extend t))
;;      (propertize " "
;;                  'face 'nano-subtle 'display `(raise ,nano-modeline-space-top))

;;      (propertize prompt
;;                  'face `(:inherit (nano-subtle nano-strong nano-salient)
;;                          :extend t))
;;      (propertize " "
;;                  'face 'nano-subtle 'display `(raise ,nano-modeline-space-bottom))
;;      (propertize "\n" 'face 'highlight)
;;      (propertize " " 'face 'highlight
;;                      'display `(raise ,nano-modeline-space-top))
;;      (propertize "︎︎" 'face '(:inherit (nano-salient nano-strong)))
;;      (propertize " " 'face 'highlight
;;                      'display `(raise ,nano-modeline-space-bottom)))))

;; (setq minibuffer-header-format #'beorged/minibuffer-header-format)

;; (minibuffer-header-mode)


;; ;; enable Wakib for keybindings
;; ;;(use-package wakib-keys
;; ;;  :ensure t
;; ;;  :config
;; ;;    (define-key wakib-keys-overriding-map (kbd "C-q") nil)
;; ;;)
;; ;;(wakib-keys 1)


;; (setq-default org-directory "/home/ken/PycharmProjects/second_brain"
;;               org-ellipsis " …"              ; Nicer ellipsis
;;               org-tags-column 1              ; Tags next to header title
;;               org-hide-emphasis-markers t    ; Hide markers
;;               org-cycle-separator-lines 2    ; Number of empty lines between sections
;;               org-use-tag-inheritance nil    ; Tags ARE NOT inherited 
;;               org-use-property-inheritance t ; Properties ARE inherited
;;               org-indent-indentation-per-level 2 ; Indentation per level
;;               org-link-use-indirect-buffer-for-internals t ; Indirect buffer for internal links
;;               org-fontify-quote-and-verse-blocks t ; Specific face for quote and verse blocks
;;               org-return-follows-link nil    ; Follow links when hitting return
;;               org-image-actual-width nil     ; Resize image to window width
;;               org-indirect-buffer-display 'other-window ; Tab on a task expand it in a new window
;;               org-outline-path-complete-in-steps nil ; No steps in path display
;;               org-agenda-files (directory-files-recursively org-directory "\\.org$")
;; )


;; (require 'org-agenda)
;; (require 'org-agenda-property)

;; (setq org-agenda-window-setup 'current-window
;;       org-agenda-restore-windows-after-quit t
;;       org-agenda-show-all-dates nil
;;       org-agenda-time-in-grid t
;;       org-agenda-show-current-time-in-grid t
;;       org-agenda-start-on-weekday 1
;;       org-agenda-span 7
;;       org-agenda-hide-tags-regexp "." ; No tags
;;     ; org-agenda-hide-tags-regexp nil) ; All tags
;;       org-agenda-tags-column 0
;;     ; org-agenda-tags-column -79)      ; Left aling
;;       org-agenda-block-separator nil
;;       org-agenda-category-icon-alist nil
;;       org-agenda-skip-deadline-if-done t
;;       org-agenda-skip-scheduled-if-done t
;;       org-agenda-sticky t)

;; (setq org-agenda-prefix-format
;;       '((agenda . "%i %?-12t%s")
;;         (todo .   "%i")
;;         (tags .   "%i")
;;         (search . "%i")))

;; (setq org-agenda-sorting-strategy
;;       '((agenda deadline-down scheduled-down todo-state-up time-up
;;                 habit-down priority-down category-keep)
;;         (todo   priority-down category-keep)
;;         (tags   timestamp-up priority-down category-keep)
;;         (search category-keep)))

;; (setq org-agenda-time-grid
;;       '((daily today require-timed)
;;         ()
;;         "......" "----------------"))

;; (setq org-agenda-current-time-string "   now")

;; ;; org mode
;; ;;(use-package org
;; ;;  :ensure t
;; ;;  :defer t
;; ;;  :config
;; ;;    (setq org-directory "/home/ken/PycharmProjects/second_brain"
;; ;;          org-adapt-indentation t
;; ;;          org-return-follows-link t
;; ;;          
;; ;;    )

;; ;;    (add-hook 'org-mode-hook 'visual-line-mode)
;; ;;    (add-hook 'org-mode-hook 'org-indent-mode)
;; ;;)

;; ;;(use-package org-bullets
;; ;;  :ensure t
;; ;;  :config
;; ;;    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; ;;)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("de8f2d8b64627535871495d6fe65b7d0070c4a1eb51550ce258cd240ff9394b0" default))
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
