
(setq-default org-directory "~/Documents/org"
              org-ellipsis " …"              ; Nicer ellipsis
              org-tags-column 1              ; Tags next to header title
              org-hide-emphasis-markers t    ; Hide markers
              org-cycle-separator-lines 2    ; Number of empty lines between sections
              org-use-tag-inheritance nil    ; Tags ARE NOT inherited 
              org-use-property-inheritance t ; Properties ARE inherited
              org-indent-indentation-per-level 2 ; Indentation per level
              org-link-use-indirect-buffer-for-internals t ; Indirect buffer for internal links
              org-fontify-quote-and-verse-blocks t ; Specific face for quote and verse blocks
              org-return-follows-link nil    ; Follow links when hitting return
              org-image-actual-width nil     ; Resize image to window width
              org-indirect-buffer-display 'other-window ; Tab on a task expand it in a new window
              org-outline-path-complete-in-steps nil) ; No steps in path display


;; Better latex preview (see https://stackoverflow.com/questions/30151338)
(setq org-latex-create-formula-image-program 'dvisvgm)

;; We adapt fill functions according to the indent level.
(defun beorged/calc-offset-on-org-level ()
  "Calculate offset (in chars) on current level in org mode file."

  (* (or (org-current-level) 0) org-indent-indentation-per-level))

(defun beorged/org-fill-paragraph (&optional justify region)
  "Calculate apt fill-column value and fill paragraph."
 
  (let* ((fill-column (- fill-column (beorged/calc-offset-on-org-level))))
    (org-fill-paragraph justify region)))

(defun beorged/org-auto-fill-function ()
  "Calculate apt fill-column value and do auto-fill"
 
  (let* ((fill-column (- fill-column (beorged/calc-offset-on-org-level))))
    (org-auto-fill-function)))

(defun beorged/org-mode-hook ()
  (setq fill-paragraph-function #'beorged/org-fill-paragraph
        normal-auto-fill-function #'beorged/org-auto-fill-function))

(add-hook 'org-load-hook 'beorged/org-mode-hook)
(add-hook 'org-mode-hook 'beorged/org-mode-hook)

;; A shortcut for emacs-lisp source blocks. Type “<S” (in org-mode) then press tab.
(require 'org-tempo)
(add-to-list 'org-structure-template-alist
             '("S" . "src emacs-lisp"))
