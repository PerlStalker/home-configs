
;; Turn on spell checking.
(add-hook 'rcirc-mode-hook (lambda ()
			     (flyspell-mode 1)))

;; Keep input line at bottom.
(add-hook 'rcirc-mode-hook
	  (lambda ()
	    (set (make-local-variable 'scroll-conservatively)
		 8192)))

;; limit buffer size
(setq rcirc-buffer-maximum-lines 500)

;; Change user info
(setq rcirc-default-nick "PerlStalker")
(setq rcirc-default-user-name "PerlStalker")
(setq rcirc-default-full-name "Randall Smith")

; http://www.emacswiki.org/emacs/rcircAutoAuthentication
(setq rcirc-authinfo
 '(
;   ("freenode"  nickserv "PerlStalker" "...")
;   ("oftc"      nickserv "PerlStalker" "...")
;   ("localhost" bitlbee  "PerlStalker" "...")
   )
 )

;; connect
(setq rcirc-server-alist
 '(
   ("chat.freenode.net" :port 7000 :encryption tls
    :channels ("#lopsa" "#docker" "#coreos"))
   ("irc.perl.org" :channels ("#moose"))
   ("irc.oftc.net" :port 6697 :encryption tls :channels ("#ceph"))
   ;("irc.twit.tv"  :channels ("#twitlive"))
   )
 )

;; bitlbee is only on rbsmith-desktop
;(if (string= (system-name) "rbsmith-desktop")
; (add-to-list 'rcirc-server-alist '("localhost" :channels ("bitlbee")) t)
;)

;; Adjust the colours of one of the faces.
;(require 'rcirc-color)
;(eval-after-load 'rcirc '(set-face-foreground 'rcirc-my-nick "red" nil))

;; Turn on notifications
(add-hook 'rcirc-mode-hook
 (lambda ()
  (rcirc-track-minor-mode 1)
  ))

;; (eval-after-load 'rcirc '(require 'rcirc-notify))
;; (add-hook 'rcirc-mode-hook
;; 	  (lambda ()
;;                  (rcirc-track-minor-mode 1)))
;; (setq rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY"))


;; from http://www.emacswiki.org/emacs/rcircAll
(eval-after-load 'rcirc
  '(defun-rcirc-command all (input)
     "Run the arguments as a command for all connections.
Example use: /all away food or /all quit zzzz."
     (interactive "s")
     (let ((buffers (mapcar 'process-buffer (rcirc-process-list))))
       (dolist (buf buffers)
	  (with-current-buffer buf
	       (goto-char (point-max))
	          (insert "/" input)
		     (rcirc-send-input))))))

;; from http://www.emacswiki.org/emacs/rcircAutoAuthentication
(defadvice rcirc (before rcirc-read-from-authinfo activate)
  "Allow rcirc to read authinfo from ~/.authinfo.gpg via the auth-source API.
This doesn't support the chanserv auth method"
  (unless arg
    (dolist (p (auth-source-search :port '("nickserv" "bitlbee" "quakenet")
                                   :require '(:port :user :secret)))
      (let ((secret (plist-get p :secret))
            (method (intern (plist-get p :port))))
        (add-to-list 'rcirc-authinfo
                     (list (plist-get p :host)
                           method
                           (plist-get p :user)
                           (if (functionp secret)
                               (funcall secret)
                             secret)))))))
