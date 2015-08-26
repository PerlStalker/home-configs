(setq ;gnus-sync-backend "/ssh:rbsmith@perlstalker.vuser.org:/home/rbsmith/gnus-sync.gpg"
 gnus-sync-backend '(lesync "http://perlstalker.vuser.org:5984/gnus-sync")
;      gnus-sync-global-vars '(gnus-newsrc-last-checked-date gnus-newsrc-alist gnus-server-alist gnus-topic-topology)
      gnus-sync-global-vars '(gnus-newsrc-last-checked-date gnus-newsrc-alist gnus-server-alist gnus-topic-topology gnus-topic-alist)
      gnus-sync-newsrc-groups '("nntp" "nnrss" "nnshimbun+rss-blogs" "nnshimbun+rss-hash" "nnshimbun+atom-blogs")
;      gnus-sync-newsrc-groups '("nntp" "nnrss" "nnshimbun")
)
