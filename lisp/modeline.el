;; We’re using nano-modeline and modify some settings here.

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

;; We set a thin modeline

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

;; We start the nano modeline.

(nano-modeline-mode 1)
