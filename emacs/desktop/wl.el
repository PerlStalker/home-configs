(package-install 'wanderlust)

(defcustom org-contacts-wl-address-file "~/.addresses"
  "Default file for wanderlust address book export."
  :group 'org-contacts
  :type 'file
  )

(defun org-contacts-wl-address-format (contact)
  "Formats CONTACT in wanderlust address book format."
  (let* ((properties (caddr contact))
	 (name (car contact))
	 (email (cdr (assoc-string org-contacts-email-property properties)))
	 (nick (cdr (assoc-string org-contacts-nickname-property properties)))
	 (head (format "\"%s\"" email)))
    (concat head
	    (format "\t\"%s\"" (if nick nick name))
	    (format "\t\"%s\"\n" name)
	    )
    )
  )

(defun org-contacts-export-as-wl-address (&optional name tags file to-buffer)
  "Exports all contacts matching NAME as wanderlust address book format."
    (interactive)

    (let* ((filename (or file org-contacts-wl-address-file))
	   (buffer (if to-buffer
		       (get-buffer-create to-buffer)
		     (find-file-noselect filename)))
	  )
      (message "Exporting ..." )

      (set-buffer buffer)
      (let ((inhibit-read-only t)) (erase-buffer))
      (fundamental-mode)
      ;;(org-install-letbind)

      (when (fboundp 'set-buffer-file-coding-system)
	(set-buffer-file-coding-system coding-system-for-write))
      
      (cl-loop for contact in (org-contacts-filter name tags) do
	       (message (org-contacts-wl-address-format contact))
	       (insert (org-contacts-wl-address-format contact))
	       )

      (if to-buffer
	  (current-buffer)
	(progn (save-buffer) (kill-buffer)))
      )
)

;;(org-contacts-exports-as-wl-address)
