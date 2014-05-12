(setq tea-time-sound "/Users/michaelconrads/Music/iTunes/iTunes Media/Music/AC_DC/Iron Man 2/05 Back In Black.m4a")
(setq tea-time-sound-command "afplay %s")


;; Default js indentation levels
(setq-default js2-basic-offset 2)
(setq js-indent-level 2)

;; Disallow scrolling with mouse wheel
(when window-system
  (mouse-wheel-mode -1))

;; Monday ftw
(set-variable 'calendar-week-start-day 1)

;; Font size
(define-key global-map (kbd "M-s +") 'zoom-in)
(define-key global-map (kbd "M-s -") 'zoom-out)


;; backup in tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;line numbers please (something is fucked up here)
;;(global-linum-mode t)

(defun ns-get-pasteboard ()
  "Returns the value of the pasteboard, or nil for unsupported formats."
  (condition-case nil
      (ns-get-selection-internal 'CLIPBOARD)
    (quit nil)))
(setq save-interprogram-paste-before-kill 'nil)


(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

;; Ruby mode when editing Cocoapods please
(add-auto-mode 'ruby-mode
               "Podfile\\'" "\\.podspec\\'")






