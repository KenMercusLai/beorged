
(require 'cal-iso)
(require 'holidays)

;; (defvar french-holidays nil
;;   "French holidays")

;; (setq french-holidays
;;       `((holiday-fixed 1 1 "New year's Day")
;; 	    (holiday-fixed 5 1 "Labour Day")
;; 	    (holiday-fixed 5 8 "Victory in Europe Day")
;; 	    (holiday-fixed 7 14 "Bastille day")
;; 	    (holiday-fixed 8 15 "Assumption of Mary")
;; 	    (holiday-fixed 11 11 "Armistice 1918")
;; 	    (holiday-fixed 11 1 "All Saints' Day")
;; 	    (holiday-fixed 12 25 "Christmas Day")
;; 	    (holiday-easter-etc 0 "Easter Sunday")
;;         (holiday-easter-etc 1 "Easter Monday")
;;         (holiday-easter-etc 39 "Ascension Day")
;;         (holiday-easter-etc 50 "Whit Monday")
;;         (holiday-sexp
;;          '(if (equal
;;                (holiday-easter-etc 49)
;;                (holiday-float 5 0 -1 nil))
;;               (car (car (holiday-float 6 0 1 nil)))
;;             (car (car (holiday-float 5 0 -1 nil))))
;;          "Mother's Day")))

;; (setq calendar-holidays french-holidays     ; French holidays
(setq calendar-week-start-day 1             ; Week starts on Monday
      calendar-mark-diary-entries-flag nil) ; Do not show diary entries

; Mark today in calendar
(add-hook 'calendar-today-visible-hook  #'calendar-mark-today)

;; Week day name with holidays
(defun beorged/org-agenda-format-date (date)
  "Org agenda date format displaying holidays"
  (let* ((dayname (calendar-day-name date))
	     (day (cadr date))
	     (month (car date))
	     (monthname (calendar-month-name month))
	     (year (nth 2 date))
         (holidays (calendar-check-holidays date)))
    (concat "\n"
            dayname " "
            (format "%d " day)
            monthname " "
            (format "%d" year)
            (if holidays (format " (%s)" (nth 0 holidays)))
            "\n")))

(setq org-agenda-format-date #'beorged/org-agenda-format-date)
