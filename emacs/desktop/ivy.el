;; https://oremacs.com/swiper/

(package-install 'counsel)
(package-install 'all-the-icons-ivy)
(package-install 'counsel-org-capture-string)
(package-install 'counsel-org-clock)
(package-install 'counsel-projectile)
(package-install 'counsel-tramp)

(package-install 'ivy-explorer)
;;(package-install 'ivy-gitlab) ;; part of gitlab package
(package-install 'ivy-pass)
(package-install 'ivy-todo)

(package-install 'flyspell-correct-ivy)

(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

(ivy-mode 1)
