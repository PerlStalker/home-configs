(package-install 'projectile)
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c o") 'projectile-command-map)
  (projectile-mode +1)
  )
