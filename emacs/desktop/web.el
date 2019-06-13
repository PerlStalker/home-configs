;;(el-get 'sync "web-mode")
(package-install 'web-mode)

(defun my-web-mode-hook ()
  "Hooks for Web mode."

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)
