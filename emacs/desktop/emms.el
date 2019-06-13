;; emms
;;(el-get 'sync "emms")
(package-install 'emms)

;; go to playlist : M-x emms-playlist-mode-go

;; the emms package isn't loaded until after this file is read.
;; Add the setup to the after-init-hook.
(add-hook 'after-init-hook 'rbsmith-init-emms)

(defun rbsmith-init-emms ()

(require 'emms-setup)
(emms-all)

(require 'emms-player-mplayer)
(require 'emms-player-xine)
(require 'emms-player-mpg321-remote)
(require 'emms-source-file)
(require 'emms-source-playlist)

; mode line
(require 'emms-mode-line)
(emms-mode-line 1)

(require 'emms-playing-time)
(emms-playing-time 1)

;; mp3 info
(require 'emms-info)
(require 'emms-info-libtag)
(add-to-list 'emms-info-functions 'emms-info-libtag)
(add-to-list 'emms-track-initialize-functions 'emms-info-initialize-track)

; http://unixforever.blogspot.com/2010/06/sample-emms-emacs-configuration.html
; trims display to just file name rather then whole path
(setq emms-mode-line-mode-line-function
      (lambda nil
	(let ((track (emms-playlist-current-selected-track)))
	  (let ((title (emms-track-get track 'info-title)))
	    (let ((name (emms-track-get track 'name)))
	      (if (not (null title))
		  (format emms-mode-line-format title)
		(if (not (null (string-match "^url: " (emms-track-simple-description track))))
		    (format emms-mode-line-format "Internet Radio")
		  (setq name2 (replace-regexp-in-string ".*\/" "" name))
		  (format emms-mode-line-format name2))))))))
(emms-mode-line-disable)
(emms-mode-line-enable) 

(setq emms-playlist-buffer-name "*Music*")

(setq emms-player-mplayer-command-name "mplayer"
      emms-player-mplayer-parameters '("-slave")
      emms-player-mpg321-command-name "mpg123"
      emms-player-list
      '(
	emms-player-mplayer
	emms-player-mplayer-playlist
	emms-player-mpg321
;	emms-player-xine
	emms-player-ogg123
))

(defun rbsmith-add-lds-music ()
  (interactive)
  (emms-add-url "http://mp3radio.lds.org/new_music")
)

;; mode line
;; (setq emms-mode-line-mode-line-function 'bigclean-emms-mode-line-playlist-current)
;; (defun bigclean-emms-mode-line-playlist-current ()
;;   "Return a description of the current track"
;;   (let* ((track (emms-playlist-current-selected-track))
;;          (type (emms-track-type track))
;;          (title (emms-track-get track 'info-title)))
;;     (format "[ %s ]"
;;             (cond ((and title)
;;                    title)))))

;; playlist buffer format
;(setq emms-track-description-function 'bigclean-emms-info-track-description)
(defun bigclean-emms-info-track-description (track)
  "Return a description of the current track."
  (let ((artist (emms-track-get track 'info-artist))
        (title (emms-track-get track 'info-title))
        (album (emms-track-get track 'info-album))
        (ptime (emms-track-get track 'info-playing-time)))
    (if title 
        (format 
         "%-25s %-45s %-35s %5s:%-2s"
         (if artist artist "")
         (if title title "")
         (if album album "")
         (/ ptime 60)
         (% ptime 60)))))

;; global key bindings
(global-set-key (kbd "C-c e SPC") 'emms-pause)

)
