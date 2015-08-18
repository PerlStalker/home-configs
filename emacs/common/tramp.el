;; no longer needed
;; use: /ssh:user@host|/sudo:host:/file/name
(set-default 'tramp-default-proxies-alist
 (quote
  (
;   (".*" "^root$" "/ssh:%h:")
   )
  )
 )
