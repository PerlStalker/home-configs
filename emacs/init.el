;; main init.el

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")
(load-file "~/.emacs.d/conf/common/init.el")
(if
 (member
  (system-name) '("mfs"))
    (load-file "~/.emacs.d/conf/server/init.el")
  (load-file "~/.emacs.d/conf/desktop/init.el")
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(package-selected-packages
   (quote
    (helm-eww eww-lnum elfeed multi-term web-mode w3m projectile erc-status-sidebar erc-sidebar erc-image erc markdown-mode org-plus-contrib org helm-tramp helm-themes helm-projectile helm-mt helm-google helm-flyspell helm-firefox helm helm-pass password-store-otp password-store minions doom-modeline all-the-icons use-package doom-themes puppet-mode docker-compose-mode dockerfile-mode helm-gitlab gitlab wanderlust notmuch pass magit yankpad smtpmail-multi)))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(w3m-display-mode (quote tabbed-frames)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
