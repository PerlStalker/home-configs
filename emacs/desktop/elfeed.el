(package-install 'elfeed)
;; Use to connect to self-hosted servers https://github.com/fasheng/elfeed-protocol
;; (package-install 'elfeed-protocol)
; Need to require for the -tagger function to work
(require 'elfeed)

; http://nullprogram.com/blog/2013/11/26/
;; Entries older than 2 weeks are marked as read
(add-hook 'elfeed-new-entry-hook
          (elfeed-make-tagger :before "2 weeks ago"
                              :remove 'unread))

(setq elfeed-feeds
  '(
    ("https://insights.ubuntu.com/feed/?_ga=1.44669607.2055131982.1473458046" ubuntu work)
    ("https://opennebula.org/feed/" opennebula work)
    ("https://about.gitlab.com/atom.xml" gitlab work)
    ("https://blog.docker.com/feed/" docker work)
    ("http://ceph.com/feed/atom/?cat=-57" ceph work)
    ("http://googleappsupdates.blogspot.com/atom.xml" google work)
    ("https://blogs.adams.edu/campus/feed/" asu)
    ("http://blogs.adams.edu/enews/feed/" asu)
    ("https://deva.adams.edu/dashboard/projects.atom?feed_token=znSCoDZ6u7m78EKiWLHF" asu)
    ("https://deva.adams.edu/dashboard/issues.atom?assignee_username=rbsmith&feed_token=znSCoDZ6u7m78EKiWLHF&state=opened" asu)
    ("http://www.archlinux.org/feeds/news/" work linux)
    ("http://blog.bestpractical.com/atom.xml" work apps)
    ("http://pyd.io/feed/" work apps)
    ))
