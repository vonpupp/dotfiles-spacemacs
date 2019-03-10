(defun myentrypoint ()
  ;; ----------------------------------------------------------------
  ;; Spell check
  ;; ----------------------------------------------------------------
  (setq spell-checking-enable-auto-dictionary t)
  (setq enable-flyspell-auto-completion t)
  ;; ----------------------------------------------------------------
  ;; Org Protocol
  ;; ----------------------------------------------------------------
  (require 'org-protocol)

  ;; (require 'helm-descbinds)
  ;; (helm-descbinds-mode)

  ;; ----------------------------------------------------------------
  ;; Babel
  ;; ----------------------------------------------------------------

  (org-babel-do-load-languages
   (quote org-babel-load-languages)
   (quote (
     (emacs-lisp . t)
     (dot . t)
     (ditaa . t)
     (R . t)
     (python . t)
     (gnuplot . t)
     (ledger . t)
     (org . t)
     (plantuml . t)
     (latex . t)
  )))

  ;; PLANTUML
  (setq org-plantuml-jar-path
    (expand-file-name "/opt/plantuml/plantuml.jar"))

  ;; ----------------------------------------------------------------
  ;; Org mode
  ;; ----------------------------------------------------------------

  ;; PATH AND IMPORTANT FILES
  (if (memq window-system '(w32))
      (setq my-home-dir "C:/Users/av")
    (setq my-home-dir (expand-file-name "~")))
  (setq org-directory (concat my-home-dir "/org/"))
  (setq org-default-capture-file (concat org-directory "capture.org"))

  ;; MODULES
  (setq org-modules (quote (org-habit)))
  (add-to-list 'org-modules 'org-protocol)

  ;; LOG
  (setq org-log-into-drawer "LOGBOOK")

  ;; AGENDA
  (setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))
  ;; Source: https://stackoverflow.com/a/29905161/1332764
  (setq org-agenda-include-diary t)
  (setq org-agenda-start-on-weekday 7)
  ;; (setq org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("HABIT" "REPEAT")))
  (setq org-agenda-custom-commands
   (quote (
     ;; gtd base states
     ("d" "TODO state" todo "TODO"
      ((org-agenda-overriding-header "TODO tasks")))
     ("s" "SOMEDAY state" todo "SOMEDAY"
      ((org-agenda-overriding-header "SOMEDAY tasks")))
     ("n" "NEXT state" todo "NEXT"
      ((org-agenda-overriding-header "NEXT tasks")))
     ("w" "WAITING state" todo "WAITING"
      ((org-agenda-overriding-header "WAITING tasks")))
     ("p" "PROJ state" todo "PROJ"
      ((org-agenda-overriding-header "PROJ tasks")))
     ("d" "DONE state" todo "DONE"
      ((org-agenda-overriding-header "DONE tasks")))
     ("c" "CANCELLED state" todo "CANCELLED"
      ((org-agenda-overriding-header "CANCELLED tasks")))
     ("k" "SKIPPED state" todo "SKIPPED"
      ((org-agenda-overriding-header "SKIPPED tasks")))
     ;; other filters
     ("l" "All actionable tasks" todo "TODO|NEXT|WAITING|PROJ"
      ((org-agenda-overriding-header "TODO tasks")))
     ("h" "Habits" tags-todo "+habit"
      ((org-agenda-overriding-header "Habits")))
     ("1" "ME" tags-todo "+ME"
      ((org-agenda-overriding-header "ME tag")))
     ("2" "RELATING" tags-todo "+RELATING"
      ((org-agenda-overriding-header "RELATING tag")))
     ("3" "DOING" tags-todo "+DOING"
      ((org-agenda-overriding-header "DOING tag")))
     ("i" "Important things to do"
      ((tags-todo "ME"
                  ((org-agenda-overriding-header "Me tag")))
       (tags-todo "RELATING"
                  ((org-agenda-overriding-header "Relating tag"))))
      nil nil)
  )))

  ;; REFILE
  (setq org-refile-targets (quote ((org-agenda-files :level . 1))))
  (setq org-refile-use-outline-path (quote full-file-path))
  (setq org-refile-allow-creating-parent-nodes (quote confirm))

  ;; ID
  (setq org-id-locations-file (concat org-directory ".org-id-locations"))

  ;; JOURNAL
  ;; https://github.com/syl20bnr/spacemacs/tree/develop/layers/%2Bemacs/org#org-journal-support
  (setq org-journal-dir (concat org-directory "journal/"))
  (setq org-journal-file-format "%Y-%m-%d")
  (setq org-journal-date-prefix "* ")
  ;;(setq org-journal-date-format "%A, %B %d %Y")
  (setq org-journal-date-format "%Y-%m-%d")
  (setq org-journal-time-prefix "* ")
  (setq org-journal-time-format "%Y-%m-%d %H:%M")
  (setq org-journal-time-format "%H:%M")

  ;; STATES
  ;; TIP: ~M-x org-mode-restart~ refreshes the org-mode cache
  (setq org-todo-keywords '((type "TODO(t/!)" "SOMEDAY(s/!)" "NEXT(n/!)" "WAITING(w@/!)" "PROJ(p)" "REPEAT(r/!)" "MEETING(m/!)" "|" "DONE(d)" "CANCELLED(c@/!)" "SKIPPED(k@/!)")))
  ;; (setq org-todo-keywords '(
  ;;   (sequence "TODO(t/!)" "NEXT(n/!)" "|" "DONE(d/!)")
  ;;   (sequence "HABIT(x)" "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING")
  ;; ))

  ;; TAGS
  (setq org-tag-persistent-alist (quote (
    ("@home" . ?h)
    ("@work" . ?w)
    ("@phone" . ?p)
    ("@notebook" . ?n)
    ("@desktop" . ?d)
    ("review" . ?r)
    (:startgrouptag)
    ("me" . ?1)
    (:grouptags)
    ("spirit" . ?s)
    ("emotions" . ?e)
    ("mind" . ?m)
    ("body" . ?b)
    (:endgrouptag)
    (:startgrouptag)
    ("relating" . ?2)
    (:grouptags)
    ("partner" . ?l)
    ("parents" . ?o)
    ("extfamily" . ?x)
    ("neighbor" . ?g)
    ;; ("friends" . ?f)
    (:endgrouptag)
    (:startgrouptag)
    ("doing" . ?3)
    (:grouptags)
    ("finances" . ?f)
    ("stayinmalaga" . ?y)
    ("living" . ?v)
    (:endgrouptag)
  )))

  ;; FACES
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "DarkOrange1" :weight bold))
          ("SOMEDAY" . (:foreground "sea green"))
          ("DONE" . (:foreground "light sea green"))
          ("CANCELLED" . (:foreground "forest green"))
          ("WAITING" . (:foreground "blue"))
         ))
  (setq org-tag-faces
        '(("ME" . (:foreground "forest green" :weight bold))
          ("SPIRIT" . (:foreground "lime green"))
          ("MIND" . (:foreground "forest green"))
          ("BODY" . (:foreground "yellow"))
         ))

  ;; Source: https://github.com/sprig/org-capture-extension
  ;; (defun transform-square-brackets-to-round-ones(string-to-transform)
  ;;   "Transforms [ into ( and ] into ), other chars left unchanged."
  ;;   (concat
  ;;    (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform))
  ;;   )

  ;; CAPTURE
  (setq org-capture-templates
    '(
      ;; Source: https://github.com/sprig/org-capture-extension
      ;; Source: https://gist.github.com/cjp/64ac13f5966456841c197f70c7d3a53a
      ("p" "Protocol" entry (file+headline "~/org/capture.org" "Inbox")
       "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
      ("L" "Protocol Link" entry (file+headline "~/org/capture.org" "Inbox")
       "* %? [[%:link][%:description]] \nCaptured On: %U")

      ;; ;; Source: https://github.com/sprig/org-capture-extension
      ;; ("p" "Protocol" entry (file+headline ,(concat org-directory "capture.org") "Inbox")
      ;;  "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
	    ;; ("L" "Protocol Link" entry (file+headline ,(concat org-directory "capture.org") "Inbox")
      ;;  "* %? [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n")

      ;; Templates for the TASKS keyword sequence
      ("t" "Tasks")

      ;; TEMPLATE A
      ("th" "SMART Habit" entry (file org-default-capture-file)
       "* REPEAT %^{Describe the task}       :HABIT:
  %?
  SCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d>>\")
  :STYLE:    habit
  :SMART:
  :Specific:   %^{What is the purpose of this goal}
  :Measurable: %^{How can you measure it}
  :Activity:   %^{What activity do we need to do}
  :Resources:  %^{What resources do we need}
  :Timebox:    %^{What time do we need to spend on that}
  :Reviewed:
  :LOGBOOK:
  - Recorded: %U
  :HoursWeek:  Get it automatically
  :END:" :empty-lines 1)
  ))

  ;; EXPORT
  (setq org-export-backends
   (quote
    (beamer html icalendar latex man odt freemind taskjuggler)))

  ;; ----------------------------------------------------------------
  ;; Org Misc
  ;; ----------------------------------------------------------------
  ;; When hitting alt-return on a header, please create a new one without
  ;; messing up the one I'm standing on.
  (setq org-insert-heading-respect-content t)
  ;; Keep the indentation well structured by. OMG this is a must have. Makes
  ;; it feel less like editing a big text file and more like a purpose built
  ;; editor for org mode that forces the indentation.
  (setq org-startup-indented t)
  ;; Open notes on a separate frame
  (setq org-noter-notes-window-location (quote (quote other-frame)))
  ;; This should allow to continue on last page but it is not working.
  ;; Needs review
  (setq org-noter-auto-save-last-location t)

  ;; ----------------------------------------------------------------
  ;; Misc
  ;; ----------------------------------------------------------------
  (setq vc-follow-symlinks t) ;; do not ask question about following symlinks
  (setq org-confirm-babel-evaluate nil)
  ;; Familiar zooming with Ctrl+ and Ctrl-
  (define-key global-map (kbd "C-=") 'text-scale-increase)
  (define-key global-map (kbd "C--") 'text-scale-decrease)
  (add-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell)
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (add-to-list 'safe-local-variable-values
               '(eval flyspell-buffer))

  ;; ----------------------------------------------------------------
  ;; Calendar
  ;; ----------------------------------------------------------------
  ;;(setq holiday-christian-holidays nil)
  ;;(setq holiday-hebrew-holidays t)
  ;;(setq holiday-islamic-holidays nil)
  ;;(setq holiday-bahai-holidays nil)
  ;;(setq holiday-oriental-holidays nil)

  ; Source: https://www.emacswiki.org/emacs/CalendarWeekNumbers
  (copy-face 'default 'calendar-iso-week-header-face)
  (set-face-attribute 'calendar-iso-week-header-face nil
                      :height 1.0 :foreground "salmon")
  (setq calendar-intermonth-header
        (propertize "W"
                    'font-lock-face 'calendar-iso-week-header-face))

  (copy-face font-lock-constant-face 'calendar-iso-week-face)
  (set-face-attribute 'calendar-iso-week-face nil
                      :height 1.0 :foreground "salmon")
  (setq calendar-intermonth-text
        '(propertize
          (format "%2d"
                  (car
                   (calendar-iso-from-absolute
                    (calendar-absolute-from-gregorian (list month day year)))))
          'font-lock-face 'calendar-iso-week-face))

  ;; ----------------------------------------------------------------
  ;; ERC
  ;; ----------------------------------------------------------------
  (setq erc-prompt-for-nickserv-password nil)
  (setq erc-server-list '(
         ("irc.freenode.net"
           :port "6697"
           :ssl t
           :nick "vonpupp")
  ;;       ("irc.oftc.net"
  ;;         :port "6697"
  ;;         :ssl t
  ;;         :nick "vonpupp")
  ))
  (setq erc-autojoin-channels-alist '(
    ("freenode.net" "#emacs" "#org-mode" "#spacemacs")
  ;;  ("oftc.net" "#bitlbee")
  ))
  (setq erc-keywords '("vonpupp"))

  ;; ----------------------------------------------------------------
  ;; Pinentry
  ;; Source: https://emacs.stackexchange.com/a/32882
  ;; Source: https://github.com/syl20bnr/spacemacs-elpa-mirror/blob/master/gnu/pinentry-readme.txt
  ;; ----------------------------------------------------------------
  (pinentry-start)

  ;; ----------------------------------------------------------------
  ;; Third party modules
  ;; ----------------------------------------------------------------

  ;; ----------------------------------------------------------------
  ;; Edit server
  ;; Source: https://www.emacswiki.org/emacs/Edit_with_Emacs
  ;; ----------------------------------------------------------------
  (add-to-list 'load-path "~/.spacemacs.d/thirdparty/editserver")
  (require 'edit-server)
  (edit-server-start)

  ;; ----------------------------------------------------------------
  ;; pdf-tools-org
  ;; ----------------------------------------------------------------
  (add-to-list 'load-path "~/.spacemacs.d/thirdparty/pdf-tools-org")
  (require 'pdf-tools-org)

  ;; ----------------------------------------------------------------
  ;; org-impress-js.el
  ;; ----------------------------------------------------------------
  (add-to-list 'load-path "~/.spacemacs.d/thirdparty/org-impress-js.el")
  (require 'ox-impress-js)

  ;; ----------------------------------------------------------------
  ;; org-reveal
  ;; ----------------------------------------------------------------
  ;;(add-to-list 'load-path "~/.spacemacs.d/thirdparty/org-reveal")
  ;;(require 'ox-reveal)

  ;; ----------------------------------------------------------------
  ;; org-re-reveal
  ;; ----------------------------------------------------------------
  (add-to-list 'load-path "~/.spacemacs.d/thirdparty/org-re-reveal")
  (require 'org-re-reveal)

  ;; ----------------------------------------------------------------
  ;; openwith
  ;; Source: https://stackoverflow.com/questions/51006855/open-mp4-files-from-orgmode
  ;; ----------------------------------------------------------------
  (require 'openwith)
  (openwith-mode t)
  (setq openwith-associations '(("\\.mp4\\'" "mpv" (file))))

  ;; ----------------------------------------------------------------
  ;; Diatheke
  ;; See: https://github.com/vonpupp/diatheke.el
  ;; ----------------------------------------------------------------
  ;;(add-to-list 'load-path "~/.spacemacs.d/thirdparty/diatheke.el")
  ;;(require 'diatheke)
  (add-to-list 'load-path "~/.spacemacs.d/thirdparty/dtk")
  (require 'dtk)

  ;; ----------------------------------------------------------------
  ;; Notmuch
  ;; See: https://github.com/syl20bnr/spacemacs/tree/develop/layers/%2Bemail/notmuch
  ;; See: https://github.com/jethrokuan/.emacs.d/blob/master/config.org
  ;; ----------------------------------------------------------------
  ;(require 'org-notmuch)
  ;(setq notmuch-search-oldest-first nil)
  ;(notmuch-search-oldest-first nil)
  ;(use-package notmuch
  ;  :preface (setq-default notmuch-command (executable-find "notmuch"))
  ;  :if (executable-find "notmuch")
  ;  :bind (("<f5>" . notmuch)
  ;         :map notmuch-search-mode-map
  ;         ("t" . jethro/notmuch-toggle-read)
  ;         ("r" . notmuch-search-reply-to-thread)
  ;         ("R" . notmuch-search-reply-to-thread-sender)
  ;         :map notmuch-show-mode-map
  ;         ;("l" . jethro/notmuch-show-jump-to-latest)
  ;         ("<tab>" . org-next-link)
  ;         ("<backtab>". org-previous-link)
  ;         ("C-<return>" . browse-url-at-point))
  ;  :config
  ;;(require 'notmuch)
  ;;(message-auto-save-directory "~/.mail/drafts/")
  ;  :custom
  ;  (setq notmuch-search-oldest-first nil)

  ;  (setq notmuch-saved-searches quote(
  ;   ((:name "inbox" :query "folder:inbox" :key "i" :sort-order newest-first)
  ;    (:name "unread" :query "tag:unread" :key "u" :sort-order newest-first)
  ;    (:name "flagged" :query "tag:flagged" :key "f" :sort-order newest-first)
  ;    (:name "sent" :query "tag:sent" :key "t" :sort-order newest-first)
  ;    (:name "drafts" :query "tag:draft" :key "d" :sort-order newest-first)
  ;    (:name "all mail" :query "*" :key "a" :sort-order newest-first))))


  ;  )
  ;(setq message-send-mail-function 'message-send-mail-with-sendmail)
  ;(setq sendmail-program (executable-find "msmtp"))

  ;;; We need this to ensure msmtp picks up the correct email account
  ;(setq message-sendmail-envelope-from 'header)
  ;(setq mail-envelope-from 'header)
  ;(setq mail-specify-envelope-from t)
  ;(setq message-sendmail-f-is-evil nil)
  ;(setq message-kill-buffer-on-exit t)
  ;(setq notmuch-always-prompt-for-sender t)
  ;(setq notmuch-archive-tags '("-inbox" "-unread"))
  ;(setq notmuch-crypto-process-mime t)
  ;(setq notmuch-hello-sections '(notmuch-hello-insert-saved-searches))
  ;;'(notmuch-search-oldest-first nil)
  ;(setq notmuch-message-headers '("To" "Cc" "Subject" "Bcc"))


;  (setq mail-user-agent 'message-user-agent)
;  (setq message-send-mail-function 'message-send-mail-with-sendmail)
;  (setq message-kill-buffer-on-exit t)
;  (setq mail-specify-envelope-from t)
;  (setq sendmail-program "/usr/bin/msmtp"
;	      mail-specify-envelope-from t
;	      mail-envelope-from 'header
;	      message-sendmail-envelope-from 'header)


)

(provide 'myinit)
