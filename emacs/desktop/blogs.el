(require 'w3m)
(require 'w3m-load)

(el-get 'sync "apel" "flim")

(add-to-list 'load-path "~/.emacs.d/el-get/emacs-w3m/shimbun")

(setq w3m-default-display-inline-images t)
(setq w3m-toggle-inline-images-permanently t)
(setq w3m-safe-url-regexp nil)
(setq mm-inline-text-html-with-images t)
(setq mm-w3m-safe-url-regexp nil)

(require 'sb-rss-hash)

(setq gnus-visible-headers "^From:\\|^Newsgroups:\\|^Subject:\\|^Date:\\|^Followup-To:\\|^Reply-To:\\|^Organization:\\|^Summary:\\|^Keywords:\\|^To:\\|^[BGF]?Cc:\\|^Posted-To:\\|^Mail-Copies-To:\\|^Mail-Followup-To:\\|^Apparently-To:\\|^Gnus-Warning:\\|^Resent-From:\\|^X-Sent:\\|^Xref:\\|^Archived-at:")

(defun my-nnshimbun-generate-download-script()
 (interactive)
;; ; (nnshimbun-generate-download-script 1)
;;  (nnshimbun-generate-download-script)
;;  (write-file "~/bin/nnshimbun.sh")
;;  (kill-buffer nil)
;;  (shell-command "chmod u+x ~/bin/nnshimbun.sh")
;;  (message "Nnshimbun script saved.")
)

;(add-hook 'gnus-exit-gnus-hook 'my-nnshimbun-generate-download-script)

;; from http://www.emacswiki.org/emacs-pt/GnusRss
(require 'mm-url)
(defadvice mm-url-insert (after DE-convert-atom-to-rss () )
  "Converts atom to RSS by calling xsltproc."
  (when (re-search-forward "xmlns=\"http://www.w3.org/.*/Atom\"" 
			   nil t)
    (goto-char (point-min))
    (message "Converting Atom to RSS... ")
    (call-process-region (point-min) (point-max) 
			 "xsltproc" 
			 t t nil 
			 (expand-file-name "~/.emacs.d/atom2rss.xsl") "-")
    (goto-char (point-min))
    (message "Converting Atom to RSS... done")))

(ad-activate 'mm-url-insert)

(setq nnrss-use-local t)
(setq shimbun-use-local t)

;; defines shimbuns for gnus to import later.

(setq shimbun-rss-blogs-group-url-regexp
 '(
   ;; Colorado
  ;;  ("81101 - Google News" "http://news.google.com/news?pz=1&cf=all&ned=us&hl=en&geo=81101&output=rss")
  ;;  ("AriArmstrong.com" "http://ariarmstrong.com/feed/")
  ;;  ("Colorado GOP" "http://www.cologop.org/feed/")
  ;;  ("Colorado GOP Press Releases" "http://www.cologop.org/category/press-releases/feed/")
  ;;  ("Colorado News Agency" "http://www.coloradonewsagency.com/feed/")
  ;;  ("Colorado Peak Politics" "http://coloradopeakpolitics.com/feed/")
  ;;  ("Colorado Springs Gazette - Colorado Politics"
  ;;   "http://www.gazette.com/common/rss/rss.php?catID=20113"
  ;;   "<div id=\"articleviewed\">"
  ;;   "<input type=\"hidden\" id=\"realstory\""
  ;;   )
  ;;  ("Colorado Statesman" "http://coloradostatesman.com/rss.xml" "<!-- ******** General Node Template Begin" "<!-- ********* General Node Template End ************* -->")
  ;;  ("Denver Post - Higher Education"
  ;;   "http://feeds.denverpost.com/dp-news-local-schools-highered"
  ;;   "<div id=\"articleOverline\" class=\"articleOverline\">"
  ;;   "<div class=\"articlePositionFooter\">"
  ;;   )
  ;;  ("Denver Post - Legislature"
  ;;   "http://feeds.denverpost.com/dp-politics-legislature"
  ;;   "<div id=\"articleOverline\" class=\"articleOverline\">"
  ;;   "<div class=\"articlePositionFooter\">"
  ;;   )
  ;;  ("Denver Post - Local Politics"
  ;;   "http://feeds.denverpost.com/dp-politics-local_politics"
  ;;   "<div id=\"articleOverline\" class=\"articleOverline\">"
  ;;   "<div class=\"articlePositionFooter\">"
  ;;   )
  ;;  ("Energy Policy Center" "http://energy.i2i.org/feed/rss/"
  ;;   "<div id=\"content\">"
  ;;   "<div id=\"commentblock\">"
  ;;   ) ; from PPC 
  ;;  ("FOX 31 News - Politics"
  ;;   "http://kdvr.com/category/news/politics/feed/"
  ;;   "<div class=\"content\">"
  ;;   "<div class=\"action_group clearfix bottom\""
  ;;   )
  ;;  ("KUSA - From the Capitol" "http://www.9news.com/rss/politics.aspx"
  ;;   "<div id=\"gtv_content\">"
  ;;   "<div id=\"taboola-leftcolumn-div\""
  ;;   )
  ;;  ("The Colorado Observer" "http://thecoloradoobserver.com/feed/"
  ;;   "<div id=\"leftcontent\">"
  ;;   "<div id=\"comments\">"
  ;;   )

  ;;  ("Valley Courier (via Yahoo)"
  ;;   "http://news.yahoo.com/rss/local/provider/2352586/valley-courier-5550877"
  ;;   "<div class=\"mainBoxWide\">"
  ;;   "<!-- google_ad_section_end -->"
  ;;   )

  ;;  ;; comics
  ;;  ;; ("Bug" "http://www.bugcomic.com/feed/"
  ;;  ;;  "<div id=\"comic\">"
  ;;  ;;  "<div id=\"comic-foot\">"
  ;;  ;;  )
  ;;  ("Dilbert Daily Strip" "http://feeds.feedburner.com/DilbertDailyStrip"
  ;;   "<a id=\"strip_zoom\""
  ;;   "<div class=\"STR_Calendar\">"
  ;;   )

  ;;  ("The Oatmeal" "http://theoatmeal.com/feed/rss"
  ;;   "<div class=\"post_body\">"
  ;;   "<div id=\"content_footer2\""
  ;;   )

  ;;  ("Evil Inc." "http://www.evil-inc.com/feed/"
  ;;   "<div id=\"comic\">"
  ;;   "<div id=\"comic-foot\">"
  ;;   )

  ;;  ("Full Frontal Nerdity" "http://ffn.nodwick.com/?feed=rss2"
  ;;   "<div id=\"content-wrapper\">"
  ;;   "<div id=\"subcontent-wrapper\">"
  ;;   )

  ;;  ("Real Life Comics" "http://reallifecomics.com/rss.php?feed=rss2"
  ;;   "<div id=\"comic\">"
  ;;   "<div id=\"comic-foot\">"
  ;;   )

  ;;  ("Use Sword on Monster" "http://www.useswordonmonster.com/?feed=rss2"
  ;;   "<div id=\"content-wrapper\">"
  ;;   "<div id=\"subcontent-wrapper\">"
  ;;   )

  ;;  ;; fun
  ;;  ("The mental_floss Blogs" "http://mentalfloss.com/blogs/feed/rss"
  ;;   "<div id=\"main\" class=\"main region\">"
  ;;   "<div id=\"article-teaser-header\">"
  ;;   )
  ;;  ;; lds
  ;;  ("Church News and Events"
  ;;   "http://lds.org/tools/rss?lang=eng&uri=/church/news&location=article"
  ;;   "<div id=\"primary\">"
  ;;   "<div id=\"secondary\""
  ;;   )
  ;;  ("LDS Newsroom" "http://newsroom.lds.org/rss.xqy?a=news"
  ;;   "<div id=\"article\">"
  ;;   "<p class=\"style_guide\">"
  ;;   )
  ;;  ;; nfl
  ;;  ("ESPN.com - AFC West Blog" "http://espn.go.com/blog/feed?blog=afcwest"
  ;;   "<div id=\"content\""
  ;;   "<ul id=\"page-actions-bottom\""
  ;;   )
  ;;  ("Football Outsiders" "http://feeds.feedburner.com/FootballOutsiders"
  ;;   "<div class=\"message\">"
  ;;   "<div id=\"comments\">"
  ;;   )
  ;;  ("NFL Films Blog" "http://nflfilms.nfl.com/feed/"
  ;;   "<div id=\"main\">"
  ;;   "<div id=\"comments\">"
  ;;   )

  ;;  ;; other

  ;;  ;; perl

  ;;  ;; sci-fi
  ;;  ("Bureau 42" "http://www.bureau42.com/bureau42.rss")
  ;;  ;; tier 1
  ;;  ("Ace of Spades HQ" "http://ace.mu.nu/index.rdf"
  ;;   "<div class=\"blog\">"
  ;;   "<div id=\"ace_comments\">"
  ;;   )
  ;;  ("Director's Blog" "http://www.cbo.gov/publications/directors-blog/rss.xml"
  ;;   "<!-- Column 1 start: Main Content -->"
  ;;   "<div id=\"contentinfo\" class=\"footer\""
  ;;   )
  ;;  ("Downsizing the Federal Government"
  ;;   "http://www.downsizinggovernment.org/rss.xml"
  ;;   "<div id=\"zone-content\""
  ;;   "<footer class=\"blog-post-footer\">"
  ;;   )
  ;;  ("Hot Air"
  ;;   "http://feeds.feedburner.com/hotair/main"
  ;;   "<div id=\"main-vent\" class=\"inner\">"
  ;;   "<div class=\"ha-social-wrapper bottom\">"
  ;;   )
  ;;  ("Liberty News Network"
  ;;   "http://www.libertynews.com/feed/"
  ;;   "<div id=\"content\">"
  ;;   "<div class=\"entry-footer\">"
  ;;   )
  ;;  ("Michelle Malkin"
  ;;   "http://feeds.feedburner.com/michellemalkin/posts"
  ;;   "<div id=\"content\">"
  ;;   "id=\"comments\" class=\"comments\">"
  ;;   )
  ;;  ("Dr. Melissa Clouthier"
  ;;   "http://feeds.feedburner.com/melissaclouthier/PTzm"
  ;;   "<div id=\"content\">"
  ;;   "<div id=\"disqus_thread\">"
  ;;   )
  ;;  ("Political Math"
  ;;   "http://www.politicalmathblog.com/?feed=rss2"
  ;;   "<div id=\"content\">"
  ;;   "<div id=\"comments\">"
  ;;   )
  ;;  ("The Foundry"
  ;;   "http://blog.heritage.org/feed/"
  ;;   "<div id=\"container\" class=\"outer\">"
  ;;   "<div class=\"related-posts-rap\">"
  ;;   )
  ;;  ("The H"
  ;;   "http://www.h-online.com/grand-atom.xml"
  ;;   ;;"<div id=\"(item|feature)\">"
  ;;   "<h1>"
  ;;   "<div class=\"forum_link\">"
  ;;   )

  ;;  ("All Things D"
  ;;   "http://allthingsd.com/category/news/feed/"
  ;;   "<div id=\"main\" role=\"main\">"
  ;;   "<div class=\"article-footer"
  ;;   )
  ;;  ("GigaOM"
  ;;   "http://feeds.feedburner.com/ommalik"
  ;;   "<section class=\"body entry-content\" itemprop=\"articleBody\">"
  ;;   "<footer class=\"foot entry-footer\">"
  ;;   )
  ;;  ;; tier 2
  ;;  ("Groklaw"
  ;;   "http://www.groklaw.net/backend/GrokLaw.rdf"
  ;;   "<!-- ARTICLE START -->"
  ;;   "<!-- ARTICLE END -->"
  ;;   )

  ;;  ("Watts Up With That?"
  ;;   "http://wattsupwiththat.com/feed/"
  ;;   )

  ;;  ;; tier 3
  ;;  ("Pajamas Media"
  ;;   "http://feeds.feedburner.com/PajamasMedia"
  ;;   "<div id=\"content\">"
  ;;   "<div id='related_posts' class='clearingfix'>"
  ;;   )
 
  ;; ("Washington Free Beacon"
  ;;  "http://feeds.feedburner.com/FreeBeacon?format=xml"
  ;;  "<div id=\"content\" role=\"main\">"
  ;;  "<div id=\"sidebar\""
  ;;  )

))

(setq shimbun-rss-hash-group-path-alist
 '(
;;    ;; colorado
;;    ("State Bill Colorado" "http://www.statebillnews.com/feed/")
;;    ("Valley Courier - Community" "http://www.alamosanews.com/Community.xml")
;;    ("Valley Courier - News" "http://www.alamosanews.com/News.xml")
;;    ("Jon Caldera" "http://www.joncaldara.com/feed/") ; from PPC
;;    ("Michelle Morin" "http://www.mom4freedom.com/feed/") ; from PPC
;;    ("Ed is Watching" "http://www.ediswatching.org/feed/") ; from PPC
;;    ("Rossputin" "http://rossputin.com/blog/index.php?tempskin=_rss2") ; from PPC
;;    ("The Blue Carp" "http://www.bluecarp.com/feeds/posts/default") ; from PPC
;;    ("View from a Height" "http://www.jsharf.com/view/?feed=rss2") ; from PPC
;;    ("The Complete Colorado - Page Two" "http://completecolorado.com/pagetwo/feed/")

;;    ;; comics
;;    ;("Bug" "http://www.bugcomic.com/feed/")
;;    ("Day by Day Cartoon by Chris Muir" "http://www.daybydaycartoon.com/index-full.xml")
;;    ("Diesel Sweeties webcomic by rstevens" "http://www.dieselsweeties.com/ds-unifeed.xml")
;;    ("Dinosaur Comics" "http://www.rsspect.com/rss/qwantz.xml")
;;    ("Drive Comic" "http://www.drivecomic.com/index.xml")
;;    ("Dueling Analogs" "http://www.duelinganalogs.com/feed/")
;;    ("FoxTrot.com" "http://www.foxtrot.com/feed/")
;;    ;("Geek And Poke" "http://feeds.feedburner.com/GeekAndPoke")
;;    ("Let's Be Friends Again" "http://www.letsbefriendsagain.com/feed/")
;; ;   ("Schlock Mercenary" "http://feeds2.feedburner.com/SchlockRSS")
;;    ("Sheldon" "http://www.sheldoncomics.com/index.xml")
;;    ("Super Siblings" "http://feeds.feedburner.com/SuperSiblings")
;;    ("Twice Shy" "http://twiceshy.bitedaily.com/feeds/posts/default")
;;    ("Wondermark" "http://feeds2.feedburner.com/wondermark")
;;    ("xkcd.com" "http://xkcd.com/rss.xml")

;;    ;; fun
;;    ("Quotes of the Day" "http://www.quotationspage.com/data/qotd.rss")

;;    ;; lds
;;    ("Daily Study - The New Testament" "http://perlstalker.vuser.org/Scriptures/nt.rdf")

;;    ;; nfl
;;    ("DenverBroncos.com Blog" "http://blog.denverbroncos.com/feed/")

;;    ;; perl

;;    ;; sci-fi
;;    ("Bureau 42" "http://www.bureau42.com/bureau42.rss")

;;    ;; tier 1
;;    ("Dr. Melissa Clouthier" "http://feeds.feedburner.com/melissaclouthier/PTzm")
;;    ("EFF.org Updates" "http://www.eff.org/rss/updates.xml")

;;    ;; tier 2
;;    ("Candid Conservative" "http://www.candidconservative.com/feed/")
;;    ("KVM - The Linux Kernel-Based Virtual Machine" "http://feeds2.feedburner.com/Kvm-TheLinuxKernel-basedVirtualMachine")
;;    ("SCOTUSblog" "http://www.scotusblog.com/feed/") ; couldn't parse tag
;;    ("The Blaze - Stories" "http://www.theblaze.com/stories/feed/")

;;    ;; tier 3
;;    ("Groklaw NewsPicks" "http://www.groklaw.net/backend/GLNewsPicks.rdf")
;;    ("The D'Arque Cathedral" "http://www.darquecathedral.org/feed")
;;    ("Ubuntu - news, usn" "http://www.ubuntu.com/rss.xml")

   )
)
(setq shimbun-atom-hash-group-path-alist
 '(
   ;; ;; colorado
   ;; ; ppc is problematic (End of buffer)
   ;; ("People's Press Collective" "http://www.peoplespresscollective.org/feed/")
   ;; ("The Intermittent Blogger" "http://thedailyblogster.blogspot.com/feeds/posts/default") ; from PPC

   ;; ;; comics
   ;; ("Bug" "http://www.bugcomic.com/feed/")
   ;; ("Geek And Poke" "http://feeds.feedburner.com/GeekAndPoke")
   ;; ("Schlock Mercenary" "http://feeds2.feedburner.com/SchlockRSS")
   ;; ("Not Invented Here" "http://feeds.feedburner.com/NotInventedHere")
   ;; ("Skin Horse" "http://skin-horse.com/feed/") ; prob

   ;; ;; perl
   ;; ("Perlbuzz" "http://feeds.feedburner.com/PerlBuzz") ; prob
   ;; ("Modern Perl Books" "http://www.modernperlbooks.com/mt/atom.xml")
   ;; ("Perl.com" "http://www.perl.com/pub/atom.xml")

   ;; ;; tier 1
   ;; ; end of buffer
   ;; ("The Sundries Shack" "http://www.sundriesshack.com/feed/")
   ;; ("Schneier on Security" "http://www.schneier.com/blog/atom.xml");"http://www.schneier.com/blog/index.rdf")

   ;; ("Reason.com - Articles" "http://feeds.feedburner.com/reason/Articles")

   ;; ;; tier 2
   ;; ("The Geekery" "http://jon.netdork.net/feed")
   ;; ; end of buffer
   ;; ("The Gateway Pundit" "http://www.thegatewaypundit.com/feed/") ; prob
   ;; ("SCOTUSblog" "http://www.scotusblog.com/feed/atom/")
   )
)

;; feeds from gwene
;; - sundries shack
;; - ppc
;; - gateway pundit
