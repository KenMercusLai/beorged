(require 'mini-frame)

(defcustom beorged/minibuffer-position 'bottom
  "Minibuffer position, one of 'top or 'bottom"
  :type '(choice (const :tag "Top"    top)
                 (const :tag "Bottom" bottom))
  :group 'nano-minibuffer)


(defun beorged/minibuffer--frame-parameters ()
  "Compute minibuffer frame size and position."

  ;; Quite precise computation to align the minibuffer and the
  ;; modeline when they are both at top position
  (let* ((edges (window-pixel-edges)) ;; (left top right bottom)
         (body-edges (window-body-pixel-edges)) ;; (left top right bottom)
         (left (nth 0 edges)) ;; Take margins into account
         (top (nth 1 edges)) ;; Drop header line
         (right (nth 2 edges)) ;; Take margins into account
         (bottom (nth 3 body-edges)) ;; Drop header line
         (left (if (eq left-fringe-width 0)
                   left
                 (- left (frame-parameter nil 'left-fringe))))
         (right (nth 2 edges))
         (right (if (eq right-fringe-width 0)
                    right
                  (+ right (frame-parameter nil 'right-fringe))))
         (border 1)
         (width (- right left (* 1 border)))

         ;; Window divider mode
         (width (- width (if (and (bound-and-true-p window-divider-mode)
                                  (or (eq window-divider-default-places 'right-only)
                                      (eq window-divider-default-places t))
                                  (window-in-direction 'right (selected-window)))
                             window-divider-default-right-width
                           0)))
         (y (- top border)))

    (append `((left-fringe . 0)
              (right-fringe . 0)
              (user-position . t) 
              (foreground-color . ,(face-foreground 'highlight nil 'default))
              (background-color . ,(face-background 'highlight nil 'default)))
            (cond ((and (eq beorged/minibuffer-position 'bottom))
                   `((top . -1)
                     (left . 0)
                     (width . 1.0)
                     (child-frame-border-width . 0)
                     (internal-border-width . 0)))
                  (t
                   `((left . ,(- left border))
                     (top . ,y)

                     (width . (text-pixels . ,width))
                     (child-frame-border-width . ,border)
                     (internal-border-width . 0)))))))

  ;; (set-face-background 'child-frame-border (face-foreground 'nano-faded))
  (setq mini-frame-default-height 3)
  (setq mini-frame-create-lazy t)
  (setq mini-frame-show-parameters 'beorged/minibuffer--frame-parameters)
  (setq mini-frame-ignore-commands
        '("edebug-eval-expression" debugger-eval-expression))
  (setq mini-frame-internal-border-color (face-foreground 'nano-faded))

  (setq mini-frame-resize-min-height 3)
  (setq mini-frame-resize t)
  ;; (setq mini-frame-resize 'grow-only)
  ;; (setq mini-frame-default-height (+ 1 vertico-count))
  ;; (setq mini-frame-resize-height (+ 1 vertico-count))
  ;; (setq mini-frame-resize nil)

;; Mini-frame mode OFF
;; (mini-frame-mode 1)

;; More a hack than a fix but the code below improve the mini-frame resize by setting position explicity. CURRENTLY INACTIVE
(defun beorged/mini-frame--resize-mini-frame (frame)
  "Resize FRAME vertically only.
This function used as value for `resize-mini-frames' variable."
  (funcall mini-frame--fit-frame-function
           frame
           mini-frame-resize-max-height
           (if (eq mini-frame-resize 'grow-only)
               (max (frame-parameter frame 'height)
                    mini-frame-resize-min-height)
             mini-frame-resize-min-height)
           ;; A max-width must be included to work around a bug in Emacs which
           ;; causes wrapping to not be taken into account in some situations
           ;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=56102
           (window-body-width)
           nil
           'vertically)

  (if (eq beorged/minibuffer-position 'top)
      (modify-frame-parameters  mini-frame-completions-frame `((top . 0)))
    (modify-frame-parameters  mini-frame-completions-frame `((top . (- 1))))))
