;(el-get 'sync "gnus")

;; smtpmail-multi
;;(el-get-bundle elpa:smtpmail-multi)
;;(el-get-bundle vapniks/smtpmail-multi)
(package-install 'smtpmail-multi)
(setq message-send-mail-function 'smtpmail-multi-send-it)

;;(setq sendmail-program "/usr/bin/msmtp")

;;(setq mail-user-agent 'gnus-user-agent)

(setq mail-header-separator "")
(add-hook 'message-mode-hook 'turn-on-flyspell)
(add-hook 'message-mode-hook 'turn-on-auto-fill)
(add-hook 'message-mode-hook 'turn-on-orgstruct++)
(add-hook 'message-mode-hook 'turn-on-orgtbl)

(setq mm-verify-option "always")
(setq mm-decrypt-option "always")

(setq gnus-buttonized-mime-types
      '(
	"multipart/signed"
	))

;; use w3m to render mail
(setq mm-text-html-renderer 'w3m)
(setq mm-inline-text-html-with-images t)
(setq mm-inline-text-html-with-w3m-keymap nil)

(defun gnus-summary-w3m-safe-toggle-inline-images (&optional arg)
            "Toggle displaying of all images in the article buffer.
          If the prefix arg is given, force displaying of images."
            (interactive "P")
            (with-current-buffer gnus-article-buffer
              (let ((st (point-min))
                    (nd (point-max))
                    (w3m-async-exec w3m-async-exec))
                (save-restriction
                  (widen)
                  (if (or (> st (point-min)) (< nd (point-max)))
                      (setq w3m-async-exec nil))
                  (article-goto-body)
                  (goto-char (or (text-property-not-all (point) (point-max)
                                                        'w3m-safe-url-regexp nil)
                                 (point)))
                  (if (interactive-p)
                      (call-interactively 'w3m-toggle-inline-images)
                    (w3m-toggle-inline-images arg))))))

          (eval-after-load "gnus-sum"
            '(define-key gnus-summary-mode-map
               "vi" 'gnus-summary-w3m-safe-toggle-inline-images))


(defun select-gpg-user-id (&optional args)
  "Select GPG user id based on the group name."
  (dolist (entry gpg-user-ids)
    (when (string-match (nth 0 entry) gnus-newsgroup-name)
      (setq pgg-gpg-user-id (nth 1 entry)
            pgg-default-user-id (nth 1 entry))
      ; (message (concat "set to " (nth 1 entry)))
      (return))))

(add-hook 'gnus-summary-mode-hook 'select-gpg-user-id)


;; Make Gnus NOT ignore [Gmail] mailboxes
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;; offline imap
;(setq offlineimap-command "offlineimap -u MachineUI")
;(setq offlineimap-command "/usr/bin/python /usr/bin/offlineimap -u MachineUI")
;(add-hook 'gnus-before-startup-hook 'offlineimap)

;(setq user-mail-address "rbsmith@adams.edu")
;(setq gnus-local-domain "adams.edu")
(setq gnus-fetch-old-headers t)

;; http://www.emacswiki.org/emacs/ArchivingMail
;(setq gnus-message-archive-method '(nnimap "work"))
;(setq gnus-message-archive-group (format-time-string "INBOX.sent.%Y-%m"))

;; don't queue mail
(setq gnus-agent-queue-mail nil)

;; sending mail
;(setq message-send-mail-function 'message-send-mail-with-sendmail)
;(setq sendmail-program "/usr/bin/msmtp")
;(setq message-sendmail-extra-arguments '("--account" "rbsmith@adams.edu"))
(setq gnus-permanently-visible-groups nil)

;; Set sent folder to the current year/month every time a new message
;; is composed.
;; (defun gse-set-mail-archive-file-name()
;;   "Set the sent folder to be based on the current year/month."
;;   (setq mail-archive-file-name
;; 	(concat
;; 	 "~/Mail/sent/"
;; 	 (format-time-string "%Y-%m"))))

;(add-hook 'mail-mode-hook 'gse-set-mail-archive-file-name)

; https://www.gnu.org/software/emacs/manual/html_node/gnus/Asynchronous-Fetching.html
(setq gnus-asynchronous t)

; http://www.randomsample.de/dru5/node/45
;; (setq shimbun-rss-blogs-group-url-regexp
;;  '(
;;    ("ASC News" "http://www.adams.edu/news/rss.xml" "<h3>" "<h1>")
;;   )
;; )

;; (setq shimbun-rss-hash-group-path-alist
;;  '(
;;    ("reddit" "http://www.reddit.com/.rss?feed=c1a70a1382687474ecbf15f259157d399152d868&user=perlstalker")
;;    ("ASC Announcements" "http://blogs.adams.edu/campus/feed/")
;;    ))


(setq gnus-summary-line-format "%U%R%B%(%[%&user-date;: %-15,15f%]%) %s\n")

;; make tree view prettier (in xterm)
;(setq gnus-summary-make-false-root 'dummy
;; (setq
;;       gnus-sum-thread-tree-false-root      "┈─► "
;;       gnus-sum-thread-tree-single-indent   "●  "
;;       gnus-sum-thread-tree-root            "●  "
;;       gnus-sum-thread-tree-vertical        "│"
;;       gnus-sum-thread-tree-leaf-with-other "├─► "
;;       gnus-sum-thread-tree-single-leaf     "╰─► "
;;       gnus-sum-thread-tree-indent          " ")
