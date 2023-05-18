
(setq-default cursor-in-non-selected-windows nil ; Hide the cursor in inactive windows
              cursor-type '(hbar . 2)            ; Underline-shaped cursor
              cursor-intangible-mode t           ; Enforce cursor intangibility
              x-stretch-cursor nil)              ; Don't stretch cursor to the glyph width

(blink-cursor-mode 0)                            ; Still cursor
