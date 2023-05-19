;; (require 'pdf-tools)

(add-hook 'doc-view-mode-hook 'pdf-tools-install)

(setq-default pdf-view-use-scaling t
              pdf-view-use-imagemagick nil)
