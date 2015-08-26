;(load-file "/home/rbsmith/.emacs.d/mediawiki.el")
;(require 'mediawiki)
(add-to-list 'auto-mode-alist '("\\.wiki\\'" . mediawiki-mode))
(add-to-list 'auto-mode-alist '("\\.mw\\'" . mediawiki-mode))
(add-hook 'mediawiki-mode-hook 'flyspell-mode)

(setq mediawiki-site-alist
 (quote
  (
   ("Wikipedia" "http://en.wikipedia.org/wiki/index.php" "username" "password" "Main Page")
   ("cswiki" "https://cswiki.adams.edu/" "" "" "Main Page")
   )))
(setq mediawiki-site-default "cswiki")

;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(mediawiki-site-alist (Quote (("Wikipedia" "http://en.wikipedia.org/wiki/index.php" "username" "password" "Main Page") ("cswiki" "https://cswiki.adams.edu/" "" "" "Main Page"))))
;;  '(mediawiki-site-default "cswiki"))

(el-get 'sync "orgmode-mediawiki")
