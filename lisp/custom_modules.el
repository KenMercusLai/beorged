;; String related
(defun beorged/string-pad-right (len s)
  "If S is shorter than LEN, pad it on the right,
   if S is longer than LEN, truncate it on the right."

  (if (> (length s) len)
      (concat (substring s 0 (- len 1)) "…")
    (concat s (make-string (max 0 (- len (length s))) ?\ ))))

(defun beorged/string-pad-left (len s)
  "If S is shorter than LEN, pad it on the left,
   if S is longer than LEN, truncate it on the left."
  
  (if (> (length s) len)
      (concat  "…" (substring s (- (length s) len -1)))
    (concat (make-string (max 0 (- len (length s))) ?\ ) s)))

(defun beorged/string-join (len left right &optional spacing)
  "Join LEFT and RIGHT strings to fit LEN characters with at least SPACING characters 
between them. If len is negative, it is retrieved from current window width."

    (let* ((spacing (or spacing 3))
           (len (or len (window-body-width)))
           (len (if (< len 0)
                   (+ (window-body-width) len)
                  len)))
      (cond ((> (length right) len)
             (beorged/string-pad-left len right))

            ((> (length right) (- len spacing))
             (beorged/string-pad-left len (concat (make-string spacing ?\ )
                                        right)))

            ((> (length left) (- len spacing (length right)))
             (concat (beorged/string-pad-right (- len spacing (length right)) left)
                     (concat (make-string spacing ?\ )
                             right)))
            (t
             (concat left
                     (make-string (- len (length right) (length left)) ?\ )
                     right)))))

;; Date related
(defun beorged/date-day (date)
  "Return DATE day of month (1-31)."

  (nth 3 (decode-time date)))

(defun beorged/date-month (date)
  "Return DATE month number (1-12)."
  
  (nth 4 (decode-time date)))

(defun beorged/date-year (date)
  "Return DATE year."

  (nth 5 (decode-time date)))

(defun beorged/date-equal (date1 date2)
  "Check if DATE1 is equal to DATE2."
  
  (and (eq (beorged/date-day date1)
           (beorged/date-day date2))
       (eq (beorged/date-month date1)
           (beorged/date-month date2))
       (eq (beorged/date-year date1)
           (beorged/date-year date2))))

(defun beorged/date-inc (date &optional days months years)
  "Return DATE + DAYS day & MONTH months & YEARS years"

  (let ((days (or days 0))
        (months (or months 0))
        (years (or years 0))
        (day (beorged/date-day date))
        (month (beorged/date-month date))
        (year (beorged/date-year date)))
    (encode-time 0 0 0 (+ day days) (+ month months) (+ year years))))

(defun beorged/date-dec (date &optional days months years)
  "Return DATE - DAYS day & MONTH months & YEARS years"
  
  (let ((days (or days 0))
        (months (or months 0))
        (years (or years 0)))
    (beorged/date-inc date (- days) (- months) (- years))))

(defun beorged/date-today ()
  "Return today date."
  
  (current-time))

(defun beorged/date-is-today (date)
  "Check if DATE is today."
  
  (beorged/date-equal (current-time) date))

(defun beorged/date-is-yesterday (date)
  "Check if DATE is yesterday."
  
  (beorged/date-equal (beorged/date-dec (beorged/date-today) 1) date))

(defun beorged/date-relative (date)
  "Return a string with a relative date format."

  (let* ((now (current-time))
         (delta (float-time (time-subtract now date)))
         (days (ceiling (/ (float-time (time-subtract now date)) (* 60 60 24)))))
    (cond ((< delta (*       3 60))     "now")
          ((< delta (*      60 60))     (format "%d minutes ago" (/ delta   60)))
          ;;  ((< delta (*    6 60 60))     (format "%d hours ago"   (/ delta 3600)))
          ((beorged/date-is-today date)      (format-time-string "%H:%M" date))
          ((beorged/date-is-yesterday date)  (format "Yesterday"))
          ((< delta (* 4 24 60 60))     (format "%d days ago" (+ days 1)))
          (t                            (format-time-string "%d %b %Y" date)))))

;; mini frame
(defun beorged/mini-frame (&optional height foreground background border)
  "Create a child frame positionned over the header line whose
width corresponds to the width of the current selected window.

The HEIGHT in lines can be specified, as well as the BACKGROUND
color of the frame. BORDER width (pixels) and color (FOREGROUND)
can be also specified."
  
  (interactive)
  (let* ((foreground (or foreground
                         (face-foreground 'font-lock-comment-face nil t)))
         (background (or background (face-background 'highlight nil t)))
         (border (or border 1))
         (height (round (* (or height 8) (window-font-height))))
         (edges (window-pixel-edges))
         (body-edges (window-body-pixel-edges))
         (top (nth 1 edges))
         (bottom (nth 3 body-edges))
         (left (- (nth 0 edges) (or left-fringe-width 0)))
         (right (+ (nth 2 edges) (or right-fringe-width 0)))
         (width (- right left))

         ;; Window divider mode
         (width (- width (if (and (bound-and-true-p window-divider-mode)
                                  (or (eq window-divider-default-places 'right-only)
                                      (eq window-divider-default-places t))
                                (window-in-direction 'right (selected-window)))
                             window-divider-default-right-width
                           0)))
         (y (- top border))
         (child-frame-border (face-attribute 'child-frame-border :background)))
    (set-face-attribute 'child-frame-border t :background foreground)
    (let ((frame (make-frame
                  `((parent-frame . ,(window-frame))
                    (delete-before . ,(window-frame))
                    (minibuffer . nil)
                    (modeline . nil)
                    (left . ,(- left border))
                    (top . ,y)
                    (width . (text-pixels . ,width))
                    (height . (text-pixels . ,height))
                    ;; (height . ,height)
                    (child-frame-border-width . ,border)
                    (internal-border-width . ,border)
                    (background-color . ,background)
                    (horizontal-scroll-bars . nil)
                    (menu-bar-lines . 0)
                    (tool-bar-lines . 0)
                    (desktop-dont-save . t)
                    (unsplittable . nil)
                    (no-other-frame . t)
                    (undecorated . t)
                    (pixelwise . t)
                    (visibility . t)))))
      (set-face-attribute 'child-frame-border t :background child-frame-border)
      frame)))

(defun beorged/mini-frame-reset (frame)
  "Reset FRAME size and position.

  Move frame at the top of parent frame and resize it
  horizontally to fit the width of current selected window."
  
  (interactive)
  (let* ((border (frame-parameter frame 'internal-border-width))
         (height (frame-parameter frame 'height)))
    (with-selected-frame (frame-parent frame)
      (let* ((edges (window-pixel-edges))
             (body-edges (window-body-pixel-edges))
             (top (nth 1 edges))
             (bottom (nth 3 body-edges))
             (left (- (nth 0 edges) (or left-fringe-width 0)))
             (right (+ (nth 2 edges) (or right-fringe-width 0)))
             (width (- right left))
             (y (- top border)))
        (set-frame-width frame width nil t)
        (set-frame-height frame height)
        (set-frame-position frame (- left border) y)))))

(defun beorged/mini-frame-shrink (frame &optional delta)
  "Make the FRAME DELTA lines smaller.

  If no argument is given, make the frame one line smaller. If
  DELTA is negative, enlarge frame by -DELTA lines."

  (interactive)
  (let ((delta (or delta -1)))
    (when (and (framep frame)
               (frame-live-p frame)
               (frame-visible-p frame))
      (set-frame-parameter frame 'height
                           (+ (frame-parameter frame 'height) delta)))))

;; mu4e
(defun beorged/mu4e-get-account (msg)
  "Get MSG related account."
  
  (let* ((maildir (mu4e-message-field msg :maildir))
         (maildir (substring maildir 1)))
    (nth 0 (split-string maildir "/"))))

(defun beorged/mu4e-get-maildir (msg)
  "Get MSG related maildir."
  
  (let* ((maildir (mu4e-message-field msg :maildir))
         (maildir (substring maildir 1)))
    (nth 0 (reverse (split-string maildir "/")))))

(defun beorged/mu4e-get-mailbox (msg)
  "Get MSG related mailbox as 'account - maildir' "
  
  (format "%s - %s" (mu4e-get-account msg) (mu4e-get-maildir msg)))

(defun beorged/mu4e-get-sender (msg)
  "Get MSG sender."
  
  (let ((addr (cdr-safe (car-safe (mu4e-message-field msg :from)))))
      (mu4e~headers-contact-str (mu4e-message-field msg :from))))
