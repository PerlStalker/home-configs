;; http://www.djcbsoftware.nl/code/mu/mu4e/Gmail-configuration.html#Gmail-configuration

(require 'mu4e)
(require 'org-mu4e)

(setq mu4e-attachment-dir  "~/Downloads")

(setq mu4e-maildir "~/.mail/rbsmithadamsedu")
(setq mu4e-drafts-folder "/[Gmail]/Drafts")
(setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
(setq mu4e-trash-folder  "/[Gmail]/Trash")

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail]/Sent Mail"   . ?s)
       ("/[Gmail]/Trash"       . ?t)
;;       ("/[Gmail]/All Mail"    . ?a)
       ("/[Gmail]/Spam"        . ?p)
       ("/Tickets"             . ?k)
       ))

(setq mu4e-bookmarks
 `(
   ,(make-mu4e-bookmark
     :name  "Unread messages"
     :query "flag:unread AND NOT maildir:/[Gmail]/Spam AND NOT flag:trashed"
     :key ?u)
   ,(make-mu4e-bookmark
     :name "Today's messages"
     :query "date:today..now AND NOT maildir:/[Gmail]/Spam AND NOT flag:trashed"
     :key ?t)
   ,(make-mu4e-bookmark
     :name "Last 7 days"
     :query "date:7d..now AND NOT maildir:/[Gmail]/Spam AND NOT flag:trashed"
     :key ?w)
   ,(make-mu4e-bookmark
     :name "Alerts"
     :query "maildir:/Alerts"
     :key ?a)
   ,(make-mu4e-bookmark
     :name "Tickets"
     :query "maildir:/Tickets"
     :key ?k)
   ,(make-mu4e-bookmark
     :name "News"
     :query "maildir:/feeds/ASU OR maildir:/feeds/news"
     :key ?n)
   ))

;; allow for updating mail using 'U' in the main view:
(setq
 mu4e-get-mail-command "true"   ;; implicit check (if running offlineimap in bg)
 ;;mu4e-get-mail-command "offlineimap -o"   ;; or fetchmail, or ...
 ;;mu4e-update-interval 300             ;; update time (seconds)
 ;;mu4e-update-interval nil             ;; update time (seconds)
 )

;; speed up checks
(setq
  mu4e-index-cleanup nil      ;; don't do a full cleanup check
  mu4e-index-lazy-check t)    ;; don't consider up-to-date dirs

;; something about ourselves
(setq
   user-mail-address "rbsmith@adams.edu"
   user-full-name  "Randall Smith"
   mu4e-compose-signature
   (concat
    "Randall Smith\n"
    "Computing Services\n"
    "Adams State University\n"
    "http://www.adams.edu/\n"
    "719-587-7741\n"
    ))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
   starttls-use-gnutls t
   smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
   smtpmail-auth-credentials
     '(("smtp.gmail.com" 587 "rbsmith@adams.edu" nil))
   smtpmail-default-smtp-server "smtp.gmail.com"
   smtpmail-smtp-server "smtp.gmail.com"
   smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(setq mu4e-view-show-addresses t)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; If you’re using a dark theme, and the messages are hard to read, it can help to change the luminosity, e.g.:
;(setq shr-color-visible-luminance-min 80)

(setq mu4e-compose-complete-only-personal t)

;; http://www.djcbsoftware.nl/code/mu/mu4e/Compose-hooks.html#Compose-hooks
(add-hook 'mu4e-compose-mode-hook
  (defun my-do-compose-stuff ()
    "My settings for message composition."
    (set-fill-column 72)
    (flyspell-mode)
    ))
