(defun myentrypoint ()
  ;; (require 'helm-descbinds)
  ;; (helm-descbinds-mode)

  ;; ----------------------------------------------------------------
  ;; Org mode
  ;; ----------------------------------------------------------------
  (setq org-modules (quote (org-habit)))
  (setq org-log-into-drawer "LOGBOOK")
  (setq org-agenda-files (directory-files-recursively "~/Dropbox/org/" "\\.org$"))
  (setq org-agenda-start-on-weekday 7)
  (setq org-agenda-custom-commands
   (quote
    (("n" "Agenda and all TODOs"
      ((agenda "" nil)
       (alltodo "" nil))
      nil)
     ("i" "Important things to do"
      ((tags-todo "ME"
                  ((org-agenda-overriding-header "Me tag")))
       (tags-todo "RELATING"
                  ((org-agenda-overriding-header "Relating tag"))))
      nil nil))))
  (setq org-refile-targets (quote ((org-agenda-files :level . 1))))
  (setq org-refile-use-outline-path (quote full-file-path))
  (setq org-refile-allow-creating-parent-nodes (quote confirm))
  (setq org-todo-keywords '((type "TODO" "NEXT" "WAITING" "|" "DONE" "CANCELED")))
  (setq org-tag-persistent-alist (quote ((:startgroup)
                              ("@errand" . ?e)
                              ("@office" . ?o)
                              ("@home" . ?H)
                              ("@farm" . ?f)
                              (:endgroup)
                              ("WAITING" . ?w)
                              ("HOLD" . ?h)
                              ("PERSONAL" . ?P)
                              ("WORK" . ?W)
                              ("FARM" . ?F)
                              ("ORG" . ?O)
                              ("NORANG" . ?N)
                              ("crypt" . ?E)
                              ("NOTE" . ?n)
                              ("CANCELLED" . ?c)
                              ("FLAGGED" . ??))))
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

  ;; See: https://github.com/sprig/org-capture-extension
  (defun transform-square-brackets-to-round-ones(string-to-transform)
    "Transforms [ into ( and ] into ), other chars left unchanged."
    (concat
     (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform))
    )

  ;; Capture Templates for TODO tasks
  (setq org-capture-templates
    '(
      ("p" "Protocol" entry (file+headline ,(concat org-directory "~/Dropbox/org/capture.org") "Inbox")
        "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
      ("L" "Protocol Link" entry (file+headline ,(concat org-directory "~/Dropbox/org/capture.org") "Inbox")
        "* %? [[%:link][%:description]] \nCaptured On: %U")

      ;; ;; See: https://github.com/sprig/org-capture-extension
      ;; ("p" "Protocol" entry (file+headline ,(concat org-directory "~/Dropbox/org/capture.org") "Inbox")
      ;;  "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
	    ;; ("L" "Protocol Link" entry (file+headline ,(concat org-directory "~/Dropbox/org/capture.org") "Inbox")
      ;;  "* %? [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n")

      ;; Templates for the TASKS keyword sequence
      ("t" "Tasks")

      ;; TEMPLATE A
      ("th" "SMART Habit" entry (file "~/Dropbox/org/capture.org")
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

  ;; ----------------------------------------------------------------
  ;; Pinentry
  ;; See: https://emacs.stackexchange.com/a/32882
  ;; See: https://github.com/syl20bnr/spacemacs-elpa-mirror/blob/master/gnu/pinentry-readme.txt
  ;; ----------------------------------------------------------------
  (pinentry-start)

  ;; ----------------------------------------------------------------
  ;; Edit server
  ;; See: https://www.emacswiki.org/emacs/Edit_with_Emacs
  ;; ----------------------------------------------------------------
  (add-to-list 'load-path "~/.spacemacs.d/thirdparty")
  (require 'edit-server)
  (edit-server-start)
)

(provide 'myinit)
