(package-install 'helm)
(package-install 'helm-firefox)
(package-install 'helm-flyspell)
(package-install 'helm-google)
(package-install 'helm-mt)
(package-install 'helm-projectile)
(package-install 'helm-themes)
(package-install 'helm-tramp)

;; https://tuhdo.github.io/helm-intro.html

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))


(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(helm-mode 1)
