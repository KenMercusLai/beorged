
(set-face-attribute 'default nil
                    :family "Roboto Mono"
                    :weight 'light
                    :height 140)

(set-face-attribute 'bold nil
                    :family "Roboto Mono"
                    :weight 'regular)

(set-face-attribute 'italic nil
                    :family "Victor Mono"
                    :weight 'semilight
                    :slant 'italic)

(set-fontset-font t 'unicode
                    (font-spec :name "Inconsolata Light"
                               :size 16) nil)

(set-fontset-font t '(#xe000 . #xffdd)
                     (font-spec :name "RobotoMono Nerd Font"
                                :size 12) nil)
