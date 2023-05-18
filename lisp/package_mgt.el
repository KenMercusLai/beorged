
(setq straight-check-for-modifications nil)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; (add-to-list 'load-path
;;              (expand-file-name "lisp" user-emacs-directory))
;; (add-to-list 'custom-theme-load-path
;;              (expand-file-name "theme" user-emacs-directory))
;; (add-to-list 'load-path 
;;   "/usr/local/Cellar/mu/1.6.10/share/emacs/site-lisp/mu/mu4e/mu4e.el")
