
;;(package-install 'solarized-theme)
;;(load-theme 'solarized-dark t)

(package-install 'doom-themes)
(load-theme 'doom-one t)
(doom-themes-org-config)

;;(package-install 'all-the-icons)
(use-package all-the-icons)
;;(all-the-icons-install-fonts)

;; (use-package minions
;;   :config (minions-mode 1))
(package-install 'minions)
(minions-mode 1)

;; https://github.com/seagle0128/doom-modeline
;;(package-install 'doom-modeline)
(use-package doom-modeline
      :ensure t
      :hook (after-init . doom-modeline-mode))

(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-buffer-state-icon t)

(setq doom-modeline-buffer-encoding nil)

(setq doom-modeline-github nil)
