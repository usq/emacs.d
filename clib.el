;;window resizing
(defun clib-enlarge-w (&optional enlarge)
  (let ((size 10))
    (condition-case nil
        (if enlarge (enlarge-window size t)(shrink-window size))
      (error (condition-case nil
                 (if enlarge (enlarge-window size)(shrink-window size))
               (error (message "No Split windows"))
               ))
      )
    ))
(defun clib-enlarge-w+ ()  (interactive)  (clib-enlarge-w t))
(defun clib-enlarge-w- ()  (interactive)  (clib-enlarge-w))


;; mark the current line
(defun mark-sentence ()
  "Moves to the front of the line, places the mark end moves to the
  end of the line, effectively marking the whole line"
  (interactive)
  (move-beginning-of-line 1)
  (push-mark-command 1)
  (move-end-of-line 1)
  )
(global-set-key (kbd "C-c l") 'mark-sentence)


(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;;http://irreal.org/blog/?p=354
(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)
    )
  )





(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)


(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)


(defun checkout-gitignore()
  (interactive)
  (let ((repourl "https://github.com/github/gitignore.git")
        (foldername (concat "/tmp/gitignore" (replace-regexp-in-string " " "" (current-time-string)))))
    (mkdir foldername)
    (shell-command (concat "git clone " repourl " " foldername) nil)
    (shell-command (concat "mv " foldername "/Objective-C.gitignore" " ./.gitignore") nil)
    (shell-command (concat "rm -rf " foldername) nil)
    ))

(defun checkout-gitignore-and-close()
  (interactive)
  (checkout-gitignore)
  (save-buffers-kill-)
)

(provide 'clib)

