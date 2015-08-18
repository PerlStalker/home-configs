;; common
(load-file "~/.emacs.d/conf/common/el-get.el")
(load-file "~/.emacs.d/conf/common/package.el")

(load-file "~/.emacs.d/conf/common/mailcrypt.el")
;; multi-term breaks with emacs 24.4
;;(load-file "~/.emacs.d/conf/common/multi-term.el")
(load-file "~/.emacs.d/conf/common/tramp.el")


(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(setq display-time-mode 0)
