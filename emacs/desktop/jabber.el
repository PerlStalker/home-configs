(el-get 'sync "emacs-jabber")

(setq jabber-account-list
 '(
   ("rbsmith@adams.edu"
    (:network-server . "talk.google.com")
    (:connection-type . ssl))
   ("perlstalker@gmail.com"
    (:network-server . "talk.google.com")
    (:connection-type . ssl))
   )
)

(require 'jabber)
(require 'jabber-autoloads)

