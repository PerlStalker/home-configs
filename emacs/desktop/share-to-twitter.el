(defun rbsmith-share-article-to-twittering ()
  "Read the subject and url from an article and use them to start
  a new twittering status update.

  The url is pulled from the Xref header or the Archived-at
  header. The latter is useful when reading feeds through gwene.
"
  (interactive)

  (if (not (nnheader-article-p))
      (message "no article here")

    (goto-char 1)
    (setq headers (mail-header-extract))
    (setq subject (cdr (assoc 'subject headers)))

    (setq xref (cdr (assoc 'xref headers)))
    (setq url "")
    (if (string-match "^http" xref)
	(setq url xref)
      (setq url (cdr (assoc 'archived-at headers)))
      ; strip off <>s
      (setq url (substring url 1 -1))
      )
    ;(message url)
    )

  ;; Open a twittering status update window and insert the title and url
  (setq status (concatenate 'string "[shared] " subject " " url))
  (twittering-update-status-from-pop-up-buffer status)
)
