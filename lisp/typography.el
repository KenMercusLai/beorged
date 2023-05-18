

(setq-default fill-column 80                          ; Default line width 
              sentence-end-double-space nil           ; Use a single space after dots
              bidi-paragraph-direction 'left-to-right ; Faster
              truncate-string-ellipsis "…")           ; Nicer ellipsis

(require 'nano-theme)

;; Nicer glyphs for continuation and wrap 
(set-display-table-slot standard-display-table
                        'truncation (make-glyph-code ?… 'nano-faded))

(defface wrap-symbol-face
  '((t (:family "Fira Code"
        :inherit nano-faded)))
  "Specific face for wrap symbol")

(set-display-table-slot standard-display-table
                        'wrap (make-glyph-code ?↩ 'wrap-symbol-face))

(setq x-underline-at-descent-line nil
      x-use-underline-position-properties t
      underline-minimum-offset 10)

;; Fix a bug on OSX in term mode & zsh (spurious “%” after each command)
(when (eq system-type 'darwin)
  (add-hook 'term-mode-hook
            (lambda ()
              (setq buffer-display-table (make-display-table)))))
