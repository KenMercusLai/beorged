
(temp-buffer-resize-mode)
(setq temp-buffer-max-height 8)

(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse
      uniquify-separator " • "
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

(bind-key "C-x k" #'kill-current-buffer)
