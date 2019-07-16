;(load-file "~/.emacs.d/multi-term.el")
					;(el-get 'sync "multi-term")
(package-install 'multi-term)
(require 'multi-term)
(setq multi-term-program "/bin/bash")
;(setq multi-term-program "/bin/zsh")

(setq multi-term-dedicated-select-after-open-p t)

(define-prefix-command 'mt-map)
(global-set-key (kbd "C-c t") 'mt-map)

(global-set-key (kbd "C-c t n") 'multi-term-next)
(global-set-key (kbd "C-c t p") 'multi-term-prev)
(global-set-key (kbd "C-c t c") 'multi-term)
(global-set-key (kbd "C-c t d") 'multi-term-dedicated-toggle)

(global-set-key (kbd "C-c t x") 'term-send-M-x)

(add-hook 'term-mode-hook
	  (lambda()
	    (define-key term-raw-map (kbd "C-z") 'self-insert-command)
	    (setq yas-dont-activate t)
	    ))
