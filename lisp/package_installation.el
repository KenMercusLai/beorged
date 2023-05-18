(setq package-list
      '(cape                ; Completion At Point Extensions
        orderless           ; Completion style for matching regexps in any order
        vertico             ; VERTical Interactive COmpletion
        marginalia          ; Enrich existing commands with completion annotations
        consult             ; Consulting completing-read
        corfu               ; Completion Overlay Region FUnction
        deft                ; Quickly browse, filter, and edit plain text notes
        elpher              ; A friendly gopher and gemini client 
        elfeed              ; Emacs Atom/RSS feed reader
        elfeed-org          ; Configure elfeed with one or more org-mode files
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
(straight-use-package
 '(pdf-tools :type git :host github :repo "vedang/pdf-tools"))

;; Denote not yet on ELPA (2022-06-19)
(straight-use-package
 '(denote :type git :host github :repo "protesilaos/denote"))



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

;; ;; Dashboard for mu4e
;; (straight-use-package
;;  '(mu4e-dashboard :type git :host github :repo "rougier/mu4e-dashboard"))

;; ;; Folding mode for mu4e
;; (straight-use-package
;;  '(mu4e-folding :type git :host github :repo "rougier/mu4e-folding"))

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
