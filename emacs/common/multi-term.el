;(load-file "~/.emacs.d/multi-term.el")
(el-get 'sync "multi-term")
;(require 'multi-term)
;(setq multi-term-program "/bin/bash")
(setq multi-term-program "/bin/zsh")
(global-set-key (kbd "C-c n") 'multi-term-next)
(global-set-key (kbd "C-c p") 'multi-term-prev)
(global-set-key (kbd "C-c t") 'multi-term)

(add-hook 'term-mode-hook (lambda()
				(setq yas-dont-activate t)))
