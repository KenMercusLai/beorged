
(setq-default initial-major-mode 'text-mode   ; Initial mode is text
              default-major-mode 'text-mode)  ; Default mode is text

(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'prog-mode-hook 'visual-line-mode)
