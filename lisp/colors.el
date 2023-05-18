
(require 'nano-theme)
(setq nano-fonts-use t) ; Use theme font stack
(nano-light)            ; Use theme light version
(nano-mode)             ; Recommended settings


(defun beorged/set-face (face style)
  "Reset FACE and make it inherit STYLE."
  (set-face-attribute face nil
                      :foreground 'unspecified :background 'unspecified
                      :family     'unspecified :slant      'unspecified
                      :weight     'unspecified :height     'unspecified
                      :underline  'unspecified :overline   'unspecified
                      :box        'unspecified :inherit    style))
(beorged/set-face 'italic 'nano-faded)

(require 'nano-splash)
