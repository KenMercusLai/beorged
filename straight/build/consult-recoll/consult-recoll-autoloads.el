;;; consult-recoll-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "consult-recoll" "consult-recoll.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from consult-recoll.el

(autoload 'consult-recoll "consult-recoll" "\
Consult recoll's local index.
With prefix argument ASK, the user is prompted for an initial query string.

\(fn ASK)" t nil)

(autoload 'consult-recoll-embark-setup "consult-recoll" "\
Set up integration with embark.
In particular, allow opening candidates from embark-collect
buffers." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "consult-recoll" '("consult-recoll-")))

;;;***

(provide 'consult-recoll-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; consult-recoll-autoloads.el ends here
