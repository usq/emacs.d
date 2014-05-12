


(defcustom tea-time-sound nil
  "sound that will play once timer is expired.
If you don't have alsa, it is better to be .wav file"
  :group 'tea-time
  :type 'string
  )

(defcustom tea-time-sound-command nil
  "Command to run to play sounds."
  :group 'tea-time
  :type 'string
)

(defvar tea-time-notification-hook nil
  "Hook run when tea is ready"
  )

(defun tea-timer (sec)
  "Ding and show notification when tea is ready.
Store current timer in a global variable."
  (interactive)
  (run-at-time sec nil (lambda (seconds)
                         (tea-time-show-notification (format "Time is up! %d minutes" (/ seconds 60)))
                         (tea-time-play-sound)
                         ) sec))

(defun tea-time-play-sound ()
  "Play sound"
  (if tea-time-sound
      (if tea-time-sound-command
          (start-process-shell-command "tea-ready" nil (format tea-time-sound-command (concat  "\"" tea-time-sound "\"")))
        (play-sound-file tea-time-sound))
    (progn (beep t) (beep t)))
  )

(defun tea-show-remaining-time ()
  "Show how much time is left. If timer is not started - say it."
  (interactive)
  (if (not (tea-timer-is-active))
      (message "Timer is not yet started.")
    (let* (
           (remaining-time (decode-time (time-subtract (timer--time tea-active-timer) (current-time))))
           (remaining-seconds (nth 0 remaining-time))
           (remaining-minutes (nth 1 remaining-time))
           )
      (message "%d min %d sec left" remaining-minutes remaining-seconds)
      )
    ))

(defun tea-timer-cancel ()
  (interactive)
  "Cancel currenly running tea-timer. If not running - do nothing."
  (if (tea-timer-is-active)
      (progn
        (cancel-timer tea-active-timer)
        (makunbound 'tea-active-timer)
        )
    ))

(defun tea-timer-is-active ()
  "Check if we have a running tea-timer."
  (and (boundp 'tea-active-timer) (< (float-time) (float-time (timer--time tea-active-timer))))
  )

(defun tea-time (timeval)
  "Ask how long the tea should draw and start a timer.
Cancel prevoius timer, started by this function"
  (interactive "sHow long (min)? ")
  (if (not (string-match "\\`\\([0-9]+\\)\\'" timeval))
      (tea-show-remaining-time)
    (let* ((minutes (string-to-int (substring timeval (match-beginning 1)
                                              (match-end 1))))
           (seconds (* minutes 60)))
      (progn
        (tea-timer-cancel)
        (setq tea-active-timer (tea-timer seconds))
        )))
  )

(defun tea-time-show-notification (notification)
  "Show notification. Use mumbles."
    (message notification)
    (run-hooks 'tea-time-notification-hook)
    )

;;kill dat bitch!
(defun tea-time-stop ()
  (interactive)
  (signal-process "tea-ready" 9)
)

(provide 'tea-time)
