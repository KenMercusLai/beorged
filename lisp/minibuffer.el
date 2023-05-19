;; Headerline (fake) for minibuffer
(require 'minibuffer-header)

(setq minibuffer-header-show-message t
      minibuffer-header-hide-prompt t
      minibuffer-header-default-message "")

(set-face-attribute 'minibuffer-header-face nil
                    :inherit 'nano-subtle
                    :extend t)
(set-face-attribute 'minibuffer-header-message-face nil
                    :inherit '(nano-subtle nano-faded)
                    :extend t)

;; This should be an advice but it is simpler to rewrite the function

(defun beorged/minibuffer-header-format (prompt)
  "Minibuffer header"
  
  (let* ((prompt (replace-regexp-in-string "[: \t]*$" "" prompt))
         (depth (minibuffer-depth))
         (prompt (cond ((string= prompt "M-x") "Extended command")
                       ((string= prompt "Function") "Help on function")
                       ((string= prompt "Callable") "Help on function or macro")
                       ((string= prompt "Variable") "Help on variable")
                       ((string= prompt "Command") "Help on command")
                       ((string= prompt "Eval") "Evaluate lisp expression")
                       (t prompt))))
    (concat
     (propertize (format " %d " depth)
                 'face `(:inherit (nano-salient-i nano-strong)
                         :extend t))
     (propertize " "
                 'face 'nano-subtle 'display `(raise ,nano-modeline-space-top))

     (propertize prompt
                 'face `(:inherit (nano-subtle nano-strong nano-salient)
                         :extend t))
     (propertize " "
                 'face 'nano-subtle 'display `(raise ,nano-modeline-space-bottom))
     (propertize "\n" 'face 'highlight)
     (propertize " " 'face 'highlight
                     'display `(raise ,nano-modeline-space-top))
     (propertize "︎︎" 'face '(:inherit (nano-salient nano-strong)))
     (propertize " " 'face 'highlight
                     'display `(raise ,nano-modeline-space-bottom)))))

(setq minibuffer-header-format #'beorged/minibuffer-header-format)

;; Activate minibuffer header

(minibuffer-header-mode)

;; Some styling setting for the minibuffer

(defun beorged/minibuffer-setup ()

  (set-window-margins nil 0 0)
  (set-fringe-style '(0 . 0))
  (cursor-intangible-mode t)
  (face-remap-add-relative 'default :inherit 'highlight))

(add-hook 'minibuffer-setup-hook #'beorged/minibuffer-setup)

;; Showing key binding for the current command

;; Code from https://stackoverflow.com/questions/965263
(defun beorged/lookup-function (keymap func)
  (let ((all-bindings (where-is-internal (if (symbolp func)
                                             func
                                           (cl-first func))
                                         keymap))
        keys key-bindings)
    (dolist (binding all-bindings)
      (when (and (vectorp binding)
                 (integerp (aref binding 0)))
        (push binding key-bindings)))
    (push (mapconcat #'key-description key-bindings " or ") keys)
    (car keys)))


(defun beorged/minibuffer-show-last-command-setup ()
  (setq minibuffer-header-default-message
   (beorged/lookup-function (current-global-map) this-command)))

(add-hook 'minibuffer-setup-hook #'beorged/minibuffer-show-last-command-setup)

(defun beorged/minibuffer-show-last-command-exit ()
  (setq minibuffer-header-default-message ""))
(add-hook 'minibuffer-exit-hook #'beorged/minibuffer-show-last-command-exit)

;; Vertico will disable truncate lines when point is too far on the right. Problem is that it’ll mess up with our fake headerline. We thus rewrite here the function to have truncate lines always on.
(defun beorged/vertico--resize-window (height)
  "Resize active minibuffer window to HEIGHT."
;;  (setq-local truncate-lines (< (point) (* 0.8 (vertico--window-width)))
    (setq-local truncate-lines t
                resize-mini-windows 'grow-only
                max-mini-window-height 1.0)
  (unless (frame-root-window-p (active-minibuffer-window))
    (unless vertico-resize
      (setq height (max height vertico-count)))
    (let* ((window-resize-pixelwise t)
           (dp (- (max (cdr (window-text-pixel-size))
                       (* (default-line-height) (1+ height)))
                  (window-pixel-height))))
      (when (or (and (> dp 0) (/= height 0))
                (and (< dp 0) (eq vertico-resize t)))
        (window-resize nil dp nil nil 'pixelwise)))))

(advice-add #'vertico--resize-window :override #'beorged/vertico--resize-window)

;; No prompt editing and recursive minibuffer
(setq minibuffer-prompt-properties '(read-only t
                                     cursor-intangible t
                                     face minibuffer-prompt)
      enable-recursive-minibuffers t)
