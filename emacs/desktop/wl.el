(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

(require 'mailcrypt)
(add-hook 'wl-summary-mode-hook 'mc-install-read-mode)
(add-hook 'wl-mail-setup-hook 'mc-install-write-mode)

(setq wl-message-id-domain "gmail.com")

;; IMAP, gmail:
(setq elmo-imap4-default-server "imap.gmail.com"
      elmo-imap4-default-user "perlstalker"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '993
      elmo-imap4-default-stream-type 'ssl

      ;;for non ascii-characters in folder-names
      elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "perlstalker"
      wl-smtp-posting-server "smtp.gmail.com"
      wl-local-domain "gmail.com"
      wl-message-id-domain "smtp.gmail.com")

(setq wl-from "Randall Smith <perlstalker@gmail.com>"

      ;;all system folders (draft, trash, spam, etc) are placed in the
      ;;[Gmail]-folder, except inbox. "%" means it's an IMAP-folder
      wl-default-folder "%inbox"
      wl-draft-folder	"%[Gmail]/Drafts"
      wl-trash-folder	"%[Gmail]/Trash"
      wl-fcc		"%[Gmail]/Sent"

      ;; mark sent messages as read (sent messages get sent back to you and
      ;; placed in the folder specified by wl-fcc)
      wl-fcc-force-as-read    t

      ;;for when auto-compleating foldernames
      wl-default-spec "%")

(defun mc-wl-verify-signature ()
  (interactive)
  (save-window-excursion
    (wl-summary-jump-to-current-message)
    (mc-verify)))

(defun mc-wl-decrypt-message ()
  (interactive)
  (save-window-excursion
    (wl-summary-jump-to-current-message)
    (let ((inhibit-read-only t))
      (mc-decrypt))))

(eval-after-load "mailcrypt"
  '(setq mc-modes-alist
       (append
        (quote
         ((wl-draft-mode (encrypt . mc-encrypt-message)
            (sign . mc-sign-message))
          (wl-summary-mode (decrypt . mc-wl-decrypt-message)
            (verify . mc-wl-verify-signature))))
        mc-modes-alist)))
