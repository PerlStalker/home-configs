;; desktop
;;(load-file "~/.emacs.d/conf/desktop/server.el")
(load-file "~/.emacs.d/conf/desktop/projectile.el")
;;(load-file "~/.emacs.d/conf/desktop/helm.el")
(load-file "~/.emacs.d/conf/desktop/ivy.el")
(load-file "~/.emacs.d/conf/desktop/org.el")
(load-file "~/.emacs.d/conf/desktop/w3m.el")
(load-file "~/.emacs.d/conf/desktop/eww.el")
(setq browse-url-browser-function 'eww-browse-url)

(load-file "~/.emacs.d/conf/desktop/mail.el")
;(load-file "~/.emacs.d/conf/desktop/pianobar.el")
;(load-file "~/.emacs.d/conf/desktop/emms.el")
;(load-file "~/.emacs.d/conf/desktop/rcirc.el")
;;(load-file "~/.emacs.d/conf/desktop/jabber.el")
;;(load-file "~/.emacs.d/conf/desktop/wl.el")
(load-file "~/.emacs.d/conf/desktop/mu4e.el")
(load-file "~/.emacs.d/conf/desktop/elfeed.el")
;(load-file "~/.emacs.d/conf/desktop/twittering.el")
;(load-file "~/.emacs.d/conf/desktop/yasnippet.el")
(load-file "~/.emacs.d/conf/desktop/theme.el")

;; (if (string= (system-name) "localhost")
;;     (load-file "~/.emacs.d/conf/desktop/google-chrome.el")
;;   (load-file "~/.emacs.d/conf/desktop/chromium.el")
;; )

;; (if (string= (system-name) "rbsmith-desktop.adams.edu")
;;     (load-file "~/.emacs.d/conf/desktop/conkeror.el")
;;   (load-file "~/.emacs.d/conf/desktop/chromium.el")
;; )

;(load-file "~/.emacs.d/conf/desktop/chromium.el")

;(load-file "~/.emacs.d/conf/desktop/blogs.el")
(load-file "~/.emacs.d/conf/desktop/magit.el")
;;(load-file "~/.emacs.d/conf/desktop/gitlab.el")
(load-file "~/.emacs.d/conf/desktop/docker.el")
(load-file "~/.emacs.d/conf/desktop/web.el")
(load-file "~/.emacs.d/conf/desktop/vterm.el")

(load-file "~/.emacs.d/conf/desktop/pass.el")

(require 'printing)
