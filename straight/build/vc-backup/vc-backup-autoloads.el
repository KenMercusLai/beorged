;;; vc-backup-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "vc-backup" "vc-backup.el" (0 0 0 0))
;;; Generated autoloads from vc-backup.el

(autoload 'vc-backup-registered "vc-backup" "\
Inform VC that FILE will work if a backup can be found.

\(fn FILE)" nil nil)

(autoload 'vc-backup-responsible-p "vc-backup" "\
Inform VC that this backend requires a backup for FILE.

\(fn FILE)" nil nil)

(add-to-list 'vc-handled-backends 'Backup t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vc-backup" '("vc-backup-")))

;;;***

(provide 'vc-backup-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; vc-backup-autoloads.el ends here
