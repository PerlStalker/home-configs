;; http://www.emacswiki.org/emacs/TwitteringMode

(setq twittering-timeline-spec-alias
 '(
   ("related-to" .
    (lambda (username)
      (if username
	  (format ":search/to:%s OR from:%s OR @%s/"
		  username username username)
	":home")))
   ("related-to-perlstalker" . "$related-to(perlstalker)")
   ("related-to-musicfreestatic" . "$related-to(musicfreestatic)")
   ("related-to-musicfreegaming" . "$related-to(musicfreegaming)")
   )
)

(setq twittering-initial-timeline-spec-string
      '(;":home"
        ":mentions"
        ;":favorites"
        ":direct_messages"
	;"$related-to-perlstalker" 
	;"$related-to-musicfreestatic"
        "perlstalker/essential"
        ;"perlstalker/news"
))

(setq twittering-use-master-password t)

;; add spell-check
(add-hook 'twittering-edit-mode-hook (lambda () (ispell-minor-mode) (flyspell-mode)))

;; url shortening

;; load share to twitter
(load-file "~/.emacs.d/conf/desktop/share-to-twitter.el")
