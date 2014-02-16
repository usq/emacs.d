
(defun imessage-greta (message)
  (interactive "sMessage an Greta:")
  (imessage-receiver message "greta.bomhard@gmx.de")
)

(defun imessage-andi (message)
  (interactive "sMessage an Andi:")
  (imessage-receiver message "andi@w-eichner.de")
)

(defun imessage-receiver (message receiver)
  (interactive "sMessage:")
   (do-applescript (concat 
		    "tell application \"Messages\"\n"
		    "\tset targetService to 1st service whose service type = iMessage\n"
		    "\tset theBuddy to buddy \"" receiver "\" of targetService\n" 
		    "\tsend \"" message "\" to theBuddy\n"
		    "end tell")))

(provide 'osx)
