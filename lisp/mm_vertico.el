;; Vertico provides a performant and minimalistic vertical completion UI based on the default completion system but aims to be highly flexible, extensible and modular.
(require 'vertico)

;; (setq completion-styles '(basic substring partial-completion flex))

(setq vertico-resize nil        ; How to resize the Vertico minibuffer window.
      vertico-count 8           ; Maximal number of candidates to show.
      vertico-count-format nil) ; No prefix with number of entries

(vertico-mode)

;; Tweaking settings
(setq vertico-grid-separator
      #("  |  " 2 3 (display (space :width (1))
                             face (:background "#ECEFF1")))

      vertico-group-format
      (concat #(" " 0 1 (face vertico-group-title))
              #(" " 0 1 (face vertico-group-separator))
              #(" %s " 0 4 (face vertico-group-title))
              #(" " 0 1 (face vertico-group-separator
                          display (space :align-to (- right (-1 . right-margin) (- +1)))))))

(set-face-attribute 'vertico-group-separator nil
                    :strike-through t)
(set-face-attribute 'vertico-current nil
                    :inherit '(nano-strong nano-subtle))
(set-face-attribute 'completions-first-difference nil
                    :inherit '(nano-default))

;; Bind shift-tab for completion
(bind-key "<backtab>" #'minibuffer-complete vertico-map)

;; Completion-at-point and completion-in-region (see https://github.com/minad/vertico#completion-at-point-and-completion-in-region)
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   #'consult-completion-in-region
                 #'completion--in-region)
               args)))

;; Prefix the current candidate (See https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow)
(defun minibuffer-format-candidate (orig cand prefix suffix index _start)
  (let ((prefix (if (= vertico--index index)
                    "  "
                  "   "))) 
    (funcall orig cand prefix suffix index _start)))

(advice-add #'vertico--format-candidate
           :around #'minibuffer-format-candidate)

;; See https://kristofferbalintona.me/posts/vertico-marginalia-all-the-icons-completion-and-orderless/#vertico
(defun vertico--prompt-selection ()
  "Highlight the prompt"

  (let ((inhibit-modification-hooks t))
    (set-text-properties (minibuffer-prompt-end) (point-max)
                         '(face (nano-strong nano-salient)))))

;; See minad/vertico#145
(defun minibuffer-vertico-setup ()

  (setq truncate-lines t)
  (setq completion-in-region-function
        (if vertico-mode
            #'consult-completion-in-region
          #'completion--in-region)))

(add-hook 'vertico-mode-hook #'minibuffer-vertico-setup)
(add-hook 'minibuffer-setup-hook #'minibuffer-vertico-setup)
