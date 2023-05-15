;; install use-package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(package-refresh-contents)
(package-install 'use-package)

;; Install quelpa-use-package
(unless (package-installed-p 'quelpa)
    (with-temp-buffer
      (url-insert-file-contents "https://github.com/quelpa/quelpa/raw/master/quelpa.el")
      (eval-buffer)
      (quelpa-self-upgrade)))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

;; Load use-package
(require 'use-package)

;; Install and enable nano theme
(use-package nano-theme
  :ensure t
  :defer t
  :quelpa (nano-theme
           :fetcher github
           :repo "rougier/nano-theme"))

(load-theme 'nano t)
(nano-mode)

;; enable Wakib for keybindings
(use-package wakib-keys
  :ensure t
  :config
    (define-key wakib-keys-overriding-map (kbd "C-q") nil)
)
(wakib-keys 1)

;; org mode
(use-package org
  :ensure t
  :defer t
  :config
    (setq org-directory "/home/ken/PycharmProjects/second_brain"
          org-adapt-indentation t
          org-agenda-files (directory-files-recursively org-directory "\\.org$")
    )

    (add-hook 'org-mode-hook 'visual-line-mode)
    (add-hook 'org-mode-hook 'org-indent-mode)
)

(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("de8f2d8b64627535871495d6fe65b7d0070c4a1eb51550ce258cd240ff9394b0" default))
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
