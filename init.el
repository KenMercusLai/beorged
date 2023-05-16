;; install use-package
;;(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(package-initialize)

;;(package-refresh-contents)
;;(package-install 'use-package)

;; Install quelpa-use-package
;;(unless (package-installed-p 'quelpa)
;;    (with-temp-buffer
;;      (url-insert-file-contents "https://github.com/quelpa/quelpa/raw/master/quelpa.el")
;;      (eval-buffer)
;;      (quelpa-self-upgrade)))

;;(quelpa
;; '(quelpa-use-package
;;   :fetcher git
;;   :url "https://github.com/quelpa/quelpa-use-package.git"))
;;(require 'quelpa-use-package)

;; Load use-package
;;(require 'use-package)

;; straight.el
(setq straight-check-for-modifications nil) ;;disable checking (for speedup)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-list
      '(cape                ; Completion At Point Extensions
        orderless           ; Completion style for matching regexps in any order
        vertico             ; VERTical Interactive COmpletion
        marginalia          ; Enrich existing commands with completion annotations
        consult             ; Consulting completing-read
        corfu               ; Completion Overlay Region FUnction
        deft                ; Quickly browse, filter, and edit plain text notes
        elpher              ; A friendly gopher and gemini client 
        f                   ; Modern API for working with files and directories
        citar               ; Citation-related commands for org, latex, markdown
        citeproc            ; A CSL 1.0.2 Citation Processor
        flyspell-correct-popup ; Correcting words with flyspell via popup interface
        flyspell-popup      ; Correcting words with Flyspell in popup menus
        guess-language      ; Robust automatic language detection
        helpful             ; A better help buffer
        htmlize             ; Convert buffer text and decorations to HTML
        mini-frame          ; Show minibuffer in child frame on read-from-minibuffer
        imenu-list          ; Show imenu entries in a separate buffer
        magit               ; A Git porcelain inside Emacs.
        markdown-mode       ; Major mode for Markdown-formatted text
        multi-term          ; Managing multiple terminal buffers in Emacs.
        pinentry            ; GnuPG Pinentry server implementation
        use-package         ; A configuration macro for simplifying your .emacs
        vc-backup           ; VC backend for versioned backups
        yaml-mode           ; YAML mode
        consult-recoll      ; Consult interface for recoll query
        org-auto-tangle     ; Tangle org file when it is saved
        exec-path-from-shell; Get environment variables such as $PATH from the shell 
        which-key))         ; Display available keybindings in popup

;; Install packages that are not yet installed
(dolist (package package-list)
  (straight-use-package package))

;; Special case for pdf-tools that has recently (2022) changed maintainer
;;(straight-use-package
;; '(pdf-tools :type git :host github :repo "vedang/pdf-tools"))

;; Denote not yet on ELPA (2022-06-19)
;;(straight-use-package
;; '(denote :type git :host github :repo "protesilaos/denote"))

;; Display org properties in the agenda buffer (modified version)
(straight-use-package
 '(org-agenda-property :type git :host github :repo "Malabarba/org-agenda-property"
                       :fork (:host github :repo "rougier/org-agenda-property")))

;; NANO splash
(straight-use-package
 '(nano-splash :type git :host github :repo "rougier/nano-splash"))

;; NANO theme
(straight-use-package
 '(nano-theme :type git :host github :repo "rougier/nano-theme"))

;; NANO modeline
(straight-use-package
 '(nano-modeline :type git :host github :repo "rougier/nano-modeline"))

;; NANO agenda
(straight-use-package
 '(nano-agenda :type git :host github :repo "rougier/nano-agenda"))

;; NANO agenda
(straight-use-package
 '(minibuffer-header :type git :host github :repo "rougier/minibuffer-header"))

;; SVG tags, progress bars & icons
(straight-use-package
 '(svg-lib :type git :host github :repo "rougier/svg-lib"))

;; Replace keywords with SVG tags
(straight-use-package
 '(svg-tag-mode :type git :host github :repo "rougier/svg-tag-mode"))

;; Relative date formatting
(straight-use-package
 '(relative-date :type git :host github :repo "rougier/relative-date"))

;; org imenu
(straight-use-package
 '(org-imenu :type git :host github :repo "rougier/org-imenu"))

;; pdf-drop-mode
(straight-use-package
 '(pdf-drop-mode :type git :host github :repo "rougier/pdf-drop-mode"))


;; Bilbliography manager in org mode
(straight-use-package
  '(org-bib :type git :host github :branch "org-imenu" :repo "rougier/org-bib-mode"))



(set-default-coding-systems 'utf-8)     ; Default to utf-8 encoding
(prefer-coding-system       'utf-8)     ; Add utf-8 at the front for automatic detection.
(set-terminal-coding-system 'utf-8)     ; Set coding system of terminal output
(set-keyboard-coding-system 'utf-8)     ; Set coding system for keyboard input on TERMINAL
(set-language-environment "English")    ; Set up multilingual environment

;; dialogs

(setq-default show-help-function nil    ; No help text
              use-file-dialog nil       ; No file dialog
              use-dialog-box nil        ; No dialog box
              pop-up-windows nil)       ; No popup windows

(tooltip-mode -1)                       ; No tooltips
(scroll-bar-mode -1)                    ; No scroll bars
(tool-bar-mode -1)                      ; No toolbar

(menu-bar-mode 1)


;; keyboard
(require 'which-key)

(which-key-mode)


;; text
(setq-default use-short-answers t                     ; Replace yes/no prompts with y/n
              confirm-nonexistent-file-or-buffer nil) ; Ok to visit non existent files
;; Replace region when inserting text
(delete-selection-mode 1)
;; A smarter fill/unfill command

(defun beorged/fill-unfill ()
  "Like `fill-paragraph', but unfill if used twice."
  
  (interactive)
  (let ((fill-column
         (if (eq last-command #'my/fill-unfill)
             (progn (setq this-command nil)
                    (point-max))
           fill-column)))
    (call-interactively #'fill-paragraph)))

(bind-key "M-q"  #'beorged/fill-unfill)
;; (bind-key [remap fill-paragraph]  #'beorged/fill-unfill)


;; sound
(setq-default visible-bell nil             ; No visual bell      
              ring-bell-function 'ignore)  ; No bell

;; scroll
(setq-default scroll-conservatively 101       ; Avoid recentering when scrolling far
              scroll-margin 2                 ; Add a margin when scrolling vertically
              recenter-positions '(5 bottom)) ; Set re-centering positions

;; help
(setq help-window-select t)             ; Focus new help windows when opened

(bind-key "C-h f"   #'helpful-callable) ; Look up callable
(bind-key "C-h v"   #'helpful-variable) ; Look up variable
(bind-key "C-h k"   #'helpful-key)      ; Look up key 
(bind-key "C-c C-d" #'helpful-at-point) ; Look up the current symbol at point
(bind-key "C-h F"   #'helpful-function) ; Look up *F*unctions (excludes macros).
(bind-key "C-h C"   #'helpful-command)  ; Look up *C*ommands.

(require 'nano-theme)
(setq nano-fonts-use t) ; Use theme font stack
(nano-light)            ; Use theme light version
(nano-mode)             ; Recommended settings

;; colors
(defun beorged/set-face (face style)
  "Reset FACE and make it inherit STYLE."
  (set-face-attribute face nil
                      :foreground 'unspecified :background 'unspecified
                      :family     'unspecified :slant      'unspecified
                      :weight     'unspecified :height     'unspecified
                      :underline  'unspecified :overline   'unspecified
                      :box        'unspecified :inherit    style))
(beorged/set-face 'italic 'nano-faded)

;; the transient nano splash screen
(require 'nano-splash)

;; tabulations
(setq-default indent-tabs-mode nil        ; Stop using tabs to indent
              tab-always-indent 'complete ; Indent first then try completions
              tab-width 4)                ; Smaller width for tab characters

;; Let Emacs guess Python indent silently
(setq python-indent-guess-indent-offset t
      python-indent-guess-indent-offset-verbose nil)

;; Parenthesis
(require 'paren)
;; (setq show-paren-style 'expression)
(setq show-paren-style 'parenthesis)
(setq show-paren-when-point-in-periphery t)
(setq show-paren-when-point-inside-paren nil)
(show-paren-mode)

;; Imenu list
(require 'imenu-list)

(setq-default imenu-list-position 'left
              imenu-max-item-length 1000)

;; Highlighting
(require 'hl-line)

(global-hl-line-mode)

;; corfu
(require 'corfu)

(setq corfu-cycle t                ; Enable cycling for `corfu-next/previous'
      corfu-auto t                 ; Enable auto completion
      corfu-auto-delay 60.0        ; Delay before auto-completion shows up
      corfu-separator ?\s          ; Orderless field separator
      corfu-quit-at-boundary nil   ; Never quit at completion boundary
      corfu-quit-no-match t        ; Quit when no match
      corfu-preview-current nil    ; Disable current candidate preview
      corfu-preselect-first nil    ; Disable candidate preselection
      corfu-on-exact-match nil     ; Configure handling of exact matches
      corfu-echo-documentation nil ; Disable documentation in the echo area
      corfu-scroll-margin 5)       ; Use scroll margin

(global-corfu-mode)

;; TAB cycle if there are only few candidates
(setq completion-cycle-threshold 3)

;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
;; Corfu commands are hidden, since they are not supposed to be used via M-x.
(setq read-extended-command-predicate
      #'command-completion-default-include-p)

;; Enable indentation+completion using the TAB key.
;; completion-at-point is often bound to M-TAB.
(setq tab-always-indent 'complete)

;; Completion in source blocks
(require 'cape)

(add-to-list 'completion-at-point-functions 'cape-symbol)

;; orderless
(require 'orderless)
  
(setq completion-styles '(substring orderless basic)
      orderless-component-separator 'orderless-escapable-split-on-space
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

;; Modeline

(require 'nano-theme)
(require 'nano-modeline)

(setq nano-modeline-prefix 'status)
(setq nano-modeline-prefix-padding 1)

(set-face-attribute 'header-line nil)
(set-face-attribute 'mode-line nil
                    :foreground (face-foreground 'nano-subtle-i)
                    :background (face-foreground 'nano-subtle-i)
                    :inherit nil
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :foreground (face-foreground 'nano-subtle-i)
                    :background (face-foreground 'nano-subtle-i)
                    :inherit nil
                    :box nil)

(set-face-attribute 'nano-modeline-active nil
                    :underline (face-foreground 'nano-default-i)
                    :background (face-background 'nano-subtle)
                    :inherit '(nano-default-)
                    :box nil)
(set-face-attribute 'nano-modeline-inactive nil
                    :foreground 'unspecified
                    :underline (face-foreground 'nano-default-i)
                    :background (face-background 'nano-subtle)
                    :box nil)

(set-face-attribute 'nano-modeline-active-name nil
                    :foreground "black"
                    :inherit '(nano-modeline-active nano-strong))
(set-face-attribute 'nano-modeline-active-primary nil
                    :inherit '(nano-modeline-active))
(set-face-attribute 'nano-modeline-active-secondary nil
                    :inherit '(nano-faded nano-modeline-active))

(set-face-attribute 'nano-modeline-active-status-RW nil
                    :inherit '(nano-faded-i nano-strong nano-modeline-active))
(set-face-attribute 'nano-modeline-active-status-** nil
                    :inherit '(nano-popout-i nano-strong nano-modeline-active))
(set-face-attribute 'nano-modeline-active-status-RO nil
                    :inherit '(nano-default-i nano-strong nano-modeline-active))

(set-face-attribute 'nano-modeline-inactive-name nil
                    :inherit '(nano-faded nano-strong
                               nano-modeline-inactive))
(set-face-attribute 'nano-modeline-inactive-primary nil
                    :inherit '(nano-faded nano-modeline-inactive))

(set-face-attribute 'nano-modeline-inactive-secondary nil
                    :inherit '(nano-faded nano-modeline-inactive))
(set-face-attribute 'nano-modeline-inactive-status-RW nil
                    :inherit '(nano-modeline-inactive-secondary))
(set-face-attribute 'nano-modeline-inactive-status-** nil
                    :inherit '(nano-modeline-inactive-secondary))
(set-face-attribute 'nano-modeline-inactive-status-RO nil
                    :inherit '(nano-modeline-inactive-secondary))

(defun beorged/thin-modeline ()
  "Transform the modeline in a thin faded line"
  
  (nano-modeline-face-clear 'mode-line)
  (nano-modeline-face-clear 'mode-line-inactive)
  (setq mode-line-format (list ""))
  (setq-default mode-line-format (list ""))
  (set-face-attribute 'mode-line nil
                      :box nil
                      :inherit nil
                      :foreground (face-background 'nano-subtle)
                      :background (face-background 'nano-subtle)
                      :height 0.1)
  (set-face-attribute 'mode-line-inactive nil
                      :box nil
                      :inherit nil
                      :foreground (face-background 'nano-subtle)
                      :background (face-background 'nano-subtle)
                      :height 0.1))

(add-hook 'nano-modeline-mode-hook #'beorged/thin-modeline)
(nano-modeline-mode 1)



;; enable Wakib for keybindings
;;(use-package wakib-keys
;;  :ensure t
;;  :config
;;    (define-key wakib-keys-overriding-map (kbd "C-q") nil)
;;)
;;(wakib-keys 1)

;; org mode
;;(use-package org
;;  :ensure t
;;  :defer t
;;  :config
;;    (setq org-directory "/home/ken/PycharmProjects/second_brain"
;;          org-adapt-indentation t
;;          org-return-follows-link t
;;          org-agenda-files (directory-files-recursively org-directory "\\.org$")
;;    )

;;    (add-hook 'org-mode-hook 'visual-line-mode)
;;    (add-hook 'org-mode-hook 'org-indent-mode)
;;)

;;(use-package org-bullets
;;  :ensure t
;;  :config
;;    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;)


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
