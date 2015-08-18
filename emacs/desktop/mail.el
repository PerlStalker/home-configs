(setq sendmail-program "/usr/bin/msmtp")

;(setq mail-user-agent 'gnus-user-agent)

(setq mail-header-separator "")
(add-hook 'message-mode-hook 'turn-on-flyspell)
(add-hook 'message-mode-hook 'turn-on-auto-fill)
(add-hook 'message-mode-hook 'turn-on-orgstruct++)
(add-hook 'message-mode-hook 'turn-on-orgtbl)
