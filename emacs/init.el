;; main init.el
(add-to-list 'load-path "~/.emacs.d/lisp")
(load-file "~/.emacs.d/conf/common/init.el")
(if
 (member
  (system-name) '("rbsmith-desktop.adams.edu" "rbsmith-laptop" "ChrUbuntu" "shelob.vuser.org" "localhost" "archusb.localdomain"))
 (load-file "~/.emacs.d/conf/desktop/init.el")
 (load-file "~/.emacs.d/conf/server/init.el")
)

