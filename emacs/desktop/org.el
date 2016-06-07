(el-get 'sync "org-mode")
(add-to-list 'load-path "~/.emacs.d/el-get/org-mode/contrib/lisp/")
;(add-to-list 'load-path "~/.emacs.d/el-get/org-mode/contrib/oldexp/")

(setq org-babel-sh-command "/usr/sbin/bash")

;; org-modules
(setq org-modules
 (quote
  (org-crypt
   org-habit
   org-gnus
  )))		 

(require 'ox-latex)
(require 'ox-bibtex)
(add-to-list 'org-latex-classes
 '(
   "beamer"
   "\\documentclass\[presentation\]\{beamer\}"
   ("\\section\{%s\}" . "\\section*\{%s\}")
   ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
   ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")
))

(setq org-latex-pdf-process '("texi2dvi -p -b -V %f"))

(defun my-org-confirm-babel-evaluate (lang body)
  (not (string= lang "ditaa")))  ; don't ask for ditaa
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

;(require 'org-mw)
;(require 'org-export-generic)
;(load-file ".emacs.d/el-get/org-mode/contrib/lisp/org-export-generic.el")
;(load-file "~/.emacs.d/org-mode/contrib/lisp/org-export-generic.el")

(require 'org-contacts)
; properties: EMAIL, ADDRESS
(setq org-contacts-files (quote ("~/org/contacts.org")))
(org-contacts-gnus-insinuate)

(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-log-done 'time)
;(setq org-mobile-files (quote ("~/org")))
(setq org-mobile-files
 (
  quote (
	"~/org/todo.org" "~/org/notes.org"
	)))
(setq org-agenda-files
 (quote (
	 "~/org/todo.org" "~/org/notes.org" "~/org/meetings/"
	 "~/org/calendars/"
	 )))

(setq org-link-abbrev-alist
 '(("rt" . "https://helpdesk.adams.edu/Search/Simple.html?q=%s")
))

(setq org-export-with-sub-superscripts "{}")

(setq org-tags-column -76)

(setq org-capture-templates
 '(("t" "Todo" entry (file+headline "~/org/todo.org" "to do") "** TODO %?\n %i\n %a")
   ("j" "Journal" entry (file+datetree "~/org/journal.org") "* %U %?\n\n %i\n %a")
   ("p" "Phone call" entry (file+datetree "~/org/journal.org") "* %U  :phone:\n\n %i-Who: %? \n-Company: \n\n")
   ("c" "Contacts" entry (file "~/org/contacts.org") "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:")
   ))

(setq org-remember-templates
 '(("Todo" ?t "* TODO %?\n %i\n" "~/org/todo.org")
   ("Journal" ?j "* %U %?\n\n %i\n" "~/org/journal.org" date-tree)
  ))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
; \C\t doesn't work so relace it with something else
(global-set-key "\C-x\t" 'org-force-cycle-archived)
;;(global-set-key "\C-cr" 'getcals)

(setq org-publish-project-alist
 '(
   ("images"
     :base-directory "~/org/website/images"
     :base-extension "jpg\\|gif\\|png"
     :publishing-directory "~/smb4k/myfiles.adams.edu/home/public_html/images/"
     :publishing-function org-publish-attachment
     )
   ("site"
     :base-directory "~/org/website"
     :recursive t
     :author-info "Randall Smith"
     :email-info "rbsmith@adams.edu"
     :link-home "http://people.adams.edu/~rbsmith/"
     :base-extension "org"
     :publishing-directory "~/smb4k/myfiles.adams.edu/home/public_html/"
     :publishing-function org-publish-org-to-html
     :headline-levels 3
     :makeindex t
     :auto-sitemap t
     )
   ("meetings" :components ("meetings-org" "meetings-images"))
   ("meetings-org"
     :base-directory "~/org/meetings"
     :author "Randall Smith"
     :email "rbsmith@adams.edu"
     :link-home "http://people.adams.edu/~rbsmith/meetings/"
     :base-extension "org"
     :publishing-directory "~/smb4k/myfiles.adams.edu/home/public_html/meetings/"
     :publishing-function org-publish-org-to-html
     :exclude "1-1.org"
     :link-up "http://people.adams.edu/~rbsmith/"
    )
   ("meetings-images"
     :base-directory "~/org/meetings/images/"
     :base-extension "jpg\\|gif\\|png"
     :publishing-directory "~/smb4k/myfiles.adams.edu/home/public_html/meetings/images/"
     :publishing-function org-publish-attachment
     )
   ; requires https://raw.github.com/craftkiller/orgmode-octopress/master/org-octopress.el
   ("sysadmin-org" . (:base-directory "~/src/vc/sysadmin/source/org_posts/"
				      :base-extension "org"
				      :publishing-directory "~/src/vc/sysadmin/source/_posts"
				      :sub-superscript ""
				      :recursive t
				      ;:publishing-function org-publish-org-to-octopress
				      :publishing-function org-html-publish-to-html
				      :headline-levels 4
				      :html-extension "markdown"
				      :octopress-extension "markdown"
				      :body-only t))
   ("sysadmin-extra" . (:base-directory "~/src/vc/sysadmin/source/org_posts/"
					:publishing-directory "~/git/blog/source/"
					:base-extension "css\\|pdf\\|png\\|jpg\\|gif\\|svg"
					:publishing-function org-publish-attachment
					:recursive t
					:author nil
					))
   ("sysadmin" . (:components ("sysadmin-org" "sysadmin-extra")))

))

;; agenda publish
(setq org-agenda-exporter-settings
 '((ps-number-of-columns 2)
   (ps-landscape-mode t)
   (org-agenda-add-entry-text-maxlines 5)
   (htmlize-output-type 'css)
 ))

;; (setq org-feed-alist
;;       '(("My Requests"
;; 	 "https://helpdesk.adams.edu/NoAuth/rss/rbsmith/43c1c34bdd6eeffe/?Order=ASC|ASC|ASC|ASC&OrderBy=id|||&Query=%28%20Requestor.id%20%3D%20%27__CurrentUser__%27%20OR%20Cc.id%20%3D%20%27__CurrentUser__%27%20OR%20Owner.id%20%3D%20%27__CurrentUser__%27%20OR%20Watcher.id%20%3D%20%27__CurrentUser__%27%20OR%20QueueCc.id%20%3D%20%27__CurrentUser__%27%20%29%20AND%20%28%20%20Status%20%3D%20%27new%27%20OR%20Status%20%3D%20%27open%27%20OR%20Status%20%3D%20%27stalled%27%20%29"
;; 	 "~/org/tickets.org"
;; 	 "Tickets"
;; 	 :template "\n* TODO %h\n  %T\n  %description\n\n  %a\n"
;; 	 )
;; 	("Account Management"
;; 	 "https://helpdesk.adams.edu/NoAuth/rss/rbsmith/671385fcd4177943/?Order=ASC%7CASC%7CASC%7CASC&OrderBy=id%7C%7C%7C&Query=Queue%20%3D%20%27Account%20Management%27%20AND%20(%20%20Status%20%3D%20%27new%27%20OR%20Status%20%3D%20%27open%27%20OR%20Status%20%3D%20%27stalled%27%20)"
;; 	 "~/org/tickets.org"
;; 	 "Account Management"
;; 	 :template "\n* TODO %h\n  %T\n %description\n\n %a\n"
;; 	 )
;; 	))

(add-hook 'org-mode-hook 'auto-revert-mode)
(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(add-hook 
  'after-save-hook 
  (lambda () 
     (if (string= buffer-file-name "~/org/todo.org") 
        (org-mobile-push)
     )
  ))
;;(add-hook 'org-load-hook '(lambda nil
;;			    (run-at-time "5 sec" 900 'org-feed-update-all)))

;; ditaa
(setq ditaa-cmd "java -jar ~/src/ditaa/ditaa0_9.jar")
(defun djcb-ditaa-generate ()
  (interactive)
  (shell-command
    (concat ditaa-cmd " " buffer-file-name)))

;; plantuml
(setq org-plantuml-jar-path
      (expand-file-name "/opt/plantuml/plantuml.jar"))

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (ditaa . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (latex . t)
   (perl . t)
;   (sh . t)
   (shell . t)
   (plantuml . t)
   ))

;; org-crypt (encrypt parts of org files)
; http://orgmode.org/worg/org-tutorials/encrypting-files.html
(require 'org-crypt)
(org-crypt-use-before-save-magic)

; gpg key to use for encryption
(setq org-crypt-key "0x7CA638BCAF301D3E")

;; To turn autosave off only locally, you can insert this:
;;
;; # -*- buffer-auto-save-file-name: nil; -*-

; org-secretary (project management)
(require 'org-secretary)

(setq org-todo-keywords
 '((sequence "TODO(t)" "STARTED(s)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)")
   (sequence "TASK(f)" "|" "DONE(d)")
   (sequence "MAYBE(m)" "|" "CANCELED(c)")
   ))

(setq org-todo-keyword-faces
 '(("TODO".(:weight bold))
   ))

(setq org-tags-exclude-from-inheritance
 '("crypt" ; tag with 'crypt' to signal encryption
   "prj"   ; projects
   "maint" ; maint
  )
 org-stuck-projects '("+prj/-MAYBE-DONE" ("TODO" "TASK") () )
)

(setq org-sec-me "rbsmith")

(setq org-agenda-custom-commands
      '(("h" "Work todos" tags-todo
         "-personal-doat={.+}-dowith={.+}/!-TASK"
         ((org-agenda-todo-ignore-scheduled t)))
        ("H" "All work todos" tags-todo "-personal/!-TASK-MAYBE"
         ((org-agenda-todo-ignore-scheduled nil)))
        ("A" "Work todos with doat or dowith" tags-todo
         "-personal+doat={.+}|dowith={.+}/!-TASK"
         ((org-agenda-todo-ignore-scheduled nil)))
        ("j" "TODO dowith and TASK with"
         ((org-sec-with-view "TODO dowith")
          (org-sec-where-view "TODO doat")
          (org-sec-assigned-with-view "TASK with")
          (org-sec-stuck-with-view "STUCK with")))
        ;; ("J" "Interactive TODO dowith and TASK with"
        ;;  ((org-sec-who-view "TODO dowith")))
	;; ("X" agenda "" nil ("~/smb4k/myfiles.adams.edu/home/public_html/agenda/agenda.html"
	;; 		    "~/smb4k/myfiles.adams.edu/home/public_html/agenda/agenda.ps"
	;; 		    "~/smb4k/myfiles.adams.edu/home/public_html/agenda/agenda.ics"))
	;; ("Y" alltodo ""
        ;;   ((org-agenda-prefix-format " [ ] ")
        ;;    )
        ;;   ("~/smb4k/myfiles.adams.edu/home/public_html/agenda/todo.html"
	;;    "~/smb4k/myfiles.adams.edu/home/public_html/agenda/todo.ps"
	;;    "~/smb4k/myfiles.adams.edu/home/public_html/agenda/todo.ics"))
	("p" "Projects" tags-todo
	 "+TYPE=\"Project\""
	 ;"+TYPE=\"Project\"|+TYPE=\"Maintenance\""
	 (
	  (org-agenda-sorting-strategy '(priority-down))
	  (org-agenda-show-all-dates t)
	  (org-agenda-include-deadlines t)
	  )
	 ("~/mnt/home/public_html/agenda/projects.html"
	  ;"~/mnt/home/public_html/agenda/projects.ps"
	  "~/mnt/home/public_html/agenda/projects.ics")
	 )
	("S" "Scheduled maintenance"
	 ;agenda
	 tags-todo
	 "+TYPE=\"Maintenance\""
         (
	  ;(org-agenda-search-view "+TYPE=\"Maintenance")
	  (org-agenda-use-time-grid nil)
	  (org-agenda-span (quote week))
	  (org-agenda-add-entry-text-maxlines 0)
	  ;(org-agenda-skip-scheduled-if-done t)
	  (org-agenda-skip-entry-if 'notscheduled)
	  (org-agenda-show-all-dates t)
	  (org-agenda-include-deadlines t)
	  (org-agenda-files (quote ("~/org/todo.org")))
	  )
	 ("~/mnt/home/public_html/agenda/maint.html"
	  ;"~/mnt/home/public_html/agenda/maint.ps"
	  "~/mnt/home/public_html/agenda/maint.ics")
	 )
	("x" "Test block agenda"
	 (
	  (agenda ""
	   (
	    (org-agenda-time-grid nil)
	    (org-agenda-ndays 3)
	    (org-deadline-warning 60)
	    )
	   )
	  ;(tags-todo "+PRIORITY=\"A\"")
	  (tags "+TYPE=\"Project\"" )
	  (tags "+TYPE=\"Maintenance\"" )
	  )
	  (
	   (org-agenda-entry-types '(:scheduled :deadline))
	   (org-agenda-sorting-strategy '(time-up scheduled-up priority-down))
	   )
	 )
  ))

;; appointments
; see:
; - http://www.gnu.org/software/emacs/manual/html_node/emacs/Appointments.html
; - http://emacs-fu.blogspot.com/2009/11/showing-pop-ups.html

(defun djcb-popup (title msg &optional icon sound)
  "Show a popup if we're on X, or echo it otherwise; TITLE is the title
of the message, MSG is the context. Optionally, you can provide an ICON and
a sound to be played"

  (interactive)
  (when sound (shell-command
                (concat "mplayer -really-quiet " sound " 2> /dev/null")))
  (if (eq window-system 'x)
    (shell-command (concat "notify-send "

                     (if icon (concat "-i " icon) "")
                     " '" title "' '" msg "'"))
    ;; text only version

    (message (concat title ": " msg))))

(setq
  appt-message-warning-time 15 ;; warn 15 min in advance

  appt-display-mode-line t     ;; show in the modeline
  appt-display-format 'window) ;; use our func
(appt-activate 1)              ;; active appt (appointment notification)
(display-time)                 ;; time display is required for this...

 ;; update appt each time agenda opened

(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

;; our little façade-function for djcb-popup
 (defun djcb-appt-display (min-to-app new-time msg)
    (djcb-popup (format "Appointment in %s minute(s)" min-to-app) msg 
      "/usr/share/icons/gnome/32x32/status/appointment-soon.png"
      nil ;"/usr/share/sounds/ubuntu/stereo/phone-incoming-call.ogg"
      ))
  (setq appt-disp-window-function (function djcb-appt-display))
