;; Samplet configuration from https://protesilaos.com/emacs/denote
(require 'denote)

;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/Documents/Denote/"))
(setq denote-known-keywords
      '("emacs" "research" "visualization"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type nil) ; Org is the default, set others here

;; We allow multi-word keywords by default.  The author's personal
;; preference is for single-word keywords for a more rigid workflow.
(setq denote-allow-multi-word-keywords t)

(setq denote-front-matter-date-format nil) ; change this to `org-timestamp' or custom string

;; You will not need to `require' all those individually once the
;; package is available.
(require 'denote-retrieve)
(require 'denote-link)
(require 'denote-dired)
(setq denote-dired-rename-expert nil)

;; We use different ways to specify a path for demo purposes.
(setq denote-dired-directories
      (list denote-directory
            (thread-last denote-directory (expand-file-name "attachments"))
            (expand-file-name "~/Documents/vlog")))

;; Generic:
;; (add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR better:
(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

;; Here is a custom, user-level command from one of the examples we
;; showed in this manual.  We define it here and add it to a key binding
;; below.
(defun beorged/denote-journal ()
  "Create an entry tagged 'journal', while prompting for a title."
  (interactive)
  (denote
   (denote--title-prompt)
   "journal"))

;; Denote does not define any key bindings.  This is for the user to
;; decide.  For example:
(let ((map global-map))
  (define-key map (kbd "C-c n j") #'beorged/denote-journal) ; our custom command
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n d") #'denote-date)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-link-add-links)
  (define-key map (kbd "C-c n l") #'denote-link-find-file) ; "list" links
  (define-key map (kbd "C-c n b") #'denote-link-backlinks)
  ;; Note that `denote-dired-rename-file' can work from any context, not
  ;; just Dired bufffers.  That is why we bind it here to the
  ;; `global-map'.
  (define-key map (kbd "C-c n r") #'denote-dired-rename-file))

(with-eval-after-load 'org-capture
  (require 'denote-org-capture)
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))
