;;; flyspell-popup-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "flyspell-popup" "flyspell-popup.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from flyspell-popup.el

(autoload 'flyspell-popup-correct "flyspell-popup" "\
Use popup for flyspell correction.
Adapted from `flyspell-correct-word-before-point'." t nil)

(autoload 'flyspell-popup-auto-correct-mode "flyspell-popup" "\
Minor mode for automatically correcting word at point.

If called interactively, enable Flyspell-Popup-Auto-Correct mode
if ARG is positive, and disable it if ARG is zero or negative.
If called from Lisp, also enable the mode if ARG is omitted or
nil, and toggle it if ARG is `toggle'; disable the mode
otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "flyspell-popup" '("flyspell-popup-")))

;;;***

(provide 'flyspell-popup-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; flyspell-popup-autoloads.el ends here