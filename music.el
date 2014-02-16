(defun itunes-get-playlists ()
  (interactive)
  (let 
      ((numberOfPlaylists (do-applescript "tell application \"iTunes\" to get number of playlists")))
    (loop for i from 10 upto numberOfPlaylists collect 
	  (do-applescript (format "tell application \"iTunes\" to return name of playlist %d" i)))))

(defun itunes-playlists()
  (interactive)
  (let ((playlist (completing-read "playlist: " (itunes-get-playlists))))
    (itunes-play-playlist playlist)))

(defun itunes-play-playlist (name)
  "Asks the user which playlist to play"
  (interactive)
   (do-applescript (concat "tell application \"iTunes\" to play playlist \"" name "\"")))


(defun spotify-play ()
  (interactive)
   (do-applescript "tell application \"spotify\" to play"))

(defun spotify-pause ()
  (interactive)
   (do-applescript "tell application \"spotify\" to pause"))


(defun itunes-get-artists ()
  (interactive)
  (let 
      ((numberOfArtist (do-applescript "tell application \"iTunes\" to get number of file tracks of playlist 1")))
    (loop for i from 1 upto numberOfArtist collect 
	  (do-applescript (format "tell application \"iTunes\" to get artist of file track %d of playlist 1" i)))))


(defun itunes-art()
  (interactive)
  (let ((artist (completing-read "artist: " (itunes-get-artists))))
    (itunes-play-artist artist)))

(defun itunes-play-artist (name)
  "Asks the user which artist to play"
  (interactive)
   (do-applescript (concat "tell application \"iTunes\" to play every track of playlist 1 whose artist is \"" name "\"")))


(provide 'music)
