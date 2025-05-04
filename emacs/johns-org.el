
;; Set the fixed pitch face

(set-face-attribute 'default nil :height 150) ;; 15pt font

;; Set the variable pitch face
;(set-face-attribute 'variable-pitch nil :font "Inter" :height 175 :weight 'regular)
(set-face-attribute 'variable-pitch nil :font "Lucida Grande" :height 175 :weight 'regular)


(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  ;(setq-default line-spacing 0.5) ;; 0.2 means 20% extra space
  (visual-line-mode 1))


(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
;(font-lock-add-keywords 'org-mode
;			  '(("^ *\\([-]\\) "
;			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


  ;; Set faces for heading levels with colors
  (set-face-attribute 'org-level-1 nil :font "Lucida Grande" :weight 'bold    :height 1.1 ) ;:foreground "purple")
  (set-face-attribute 'org-level-2 nil :font "Lucida Grande" :weight 'bold    :height 1.1 ) ;:foreground "black")
  (set-face-attribute 'org-level-3 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) ;:foreground "yellow")
  (set-face-attribute 'org-level-4 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) ;:foreground "green")
  (set-face-attribute 'org-level-5 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) ;:foreground "blue")
  (set-face-attribute 'org-level-6 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) ;:foreground "purple")
  (set-face-attribute 'org-level-7 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) ;:foreground "magenta")
  (set-face-attribute 'org-level-8 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) ;:foreground "cyan")


;  ;; Set faces for heading levels
;  (dolist (face '((org-level-1 . 2.0)
;                  (org-level-2 . 1.4)
;                  (org-level-3 . 1.3)
;                  (org-level-4 . 1.0)
;                  (org-level-5 . 1.1)
;                  (org-level-6 . 1.1)
;                  (org-level-7 . 1.1)
;                  (org-level-8 . 1.1)))
;    (set-face-attribute (car face) nil :font "Helvetica" :weight 'regular :height (cdr face)))
;					; (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit '(shadow fixed-pitch) :height 1.0)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch) :height 0.9)
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  )



(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-files
	'("~/RoamNotes/Tasks.org"
	  "~/RoamNotes/Birthdays.org"
	  ))
  (setq org-hide-emphasis-markers t)
  (setq org-hide-block-startup t)
  (efs/org-font-setup)

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)


  (setq org-todo-keywords
	'((sequence "TODO(t)" "The ONE thing(o)" "Someday Maybe(s)" "Waiting(w)" "|" "DONE(d!)")
	  ;(sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)"))
	  ))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  ;;
  (setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ;;("@errand" . ?E)
       ;;("@home" . ?H)
       ;;("@work" . ?W)
       ("meeting" . ?m)
       ("planning" . ?p)
       ("teaching" . ?t)
       ("HGC" . ?H)
       ("4b" . ?f)
       ("publish" . ?P)
       ("note" . ?n)
       ("question" . ?q)))


  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "The ONE thing"
            ((org-agenda-overriding-header "The ONE Thing")))
      (todo "TODO"
            ((org-agenda-overriding-header "Open Items")))
      (todo "Waiting"
            ((org-agenda-overriding-header "Waiting on")))
      ;;(tags-todo "agenda/Waiting" ((org-agenda-overriding-header "Waiting on")))
      ))

    ("t" "To do"
     ((todo "TODO"
            ((org-agenda-overriding-header "Open Items")))))

    ("o" "The ONE Thing"
     ((todo "The ONE thing"
	    ((org-agenda-overriding-header "The ONE Thing")))))

    ("s" "Someday Maybe"
     ((todo "Someday Maybe"
	    ((org-agenda-overriding-header "Someday Maybe")))))

    ;; The + [tag-name] means that the tag is required the - [tag-name] means that the tag is excluded
    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ;("w" "Workflow Status"
    ; ((todo "WAIT"
    ;        ((org-agenda-overriding-header "Waiting on External")
    ;         (org-agenda-files org-agenda-files)))
    ;  (todo "REVIEW"
    ;        ((org-agenda-overriding-header "In Review")
    ;         (org-agenda-files org-agenda-files)))
    ;  (todo "PLAN"
    ;        ((org-agenda-overriding-header "In Planning")
    ;         (org-agenda-todo-list-sublevels nil)
    ;         (org-agenda-files org-agenda-files)))
    ;  (todo "BACKLOG"
    ;        ((org-agenda-overriding-header "Project Backlog")
    ;         (org-agenda-todo-list-sublevels nil)
    ;         (org-agenda-files org-agenda-files)))
    ;  (todo "READY"
    ;        ((org-agenda-overriding-header "Ready for Work")
    ;         (org-agenda-files org-agenda-files)))
    ;  (todo "ACTIVE"
    ;        ((org-agenda-overriding-header "Active Projects")
    ;         (org-agenda-files org-agenda-files)))
    ;  (todo "COMPLETED"
    ;        ((org-agenda-overriding-header "Completed Projects")
    ;         (org-agenda-files org-agenda-files)))
    ;  (todo "CANC"
    ;        ((org-agenda-overriding-header "Cancelled Projects")
					;         (org-agenda-files org-agenda-files)))))
    ))

  (setq org-capture-templates
    `(("t" "Tasks / Projects")

      ;; %? is for the cursor /  %U is the time stamp  / %a is the link to the file / %i is the current region
      ("tt" "Task" entry (file+olp "~/RoamNotes/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ;;("j" "Journal Entries")
      ;;("jj" "Journal" entry
      ;;     (file+olp+datetree "~/RoamNotes/Journal.org")
      ;;     "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
      ;;     ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
      ;;     :clock-in :clock-resume
      ;;     :empty-lines 1)
      ;;("jm" "Meeting" entry
      ;;     (file+olp+datetree "~/RoamNotes/Journal.org")
      ;;     "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
      ;;     :clock-in :clock-resume
      ;;     :empty-lines 1)

      ;;("w" "Workflows")
      ;;("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
      ;;   "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

      ;;("m" "Metrics Capture")
      ;;("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
      ;; "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)

      ))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  )


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  ;(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))
  (org-bullets-bullet-list '("" "-" "" "" "" "" "")))


(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 150
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))



(setq org-latex-create-formula-image-program 'dvipng) ;; or 'dvisvgm for SVG output
(setq org-export-with-broken-links t)  ;; Allow all broken links

; This unbinds the Alt-Left and Alt-Right keys in Org-mode, which will make them fall back to the global Emacs keybindings (moving by word).					;
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "<M-left>") nil)
  (define-key org-mode-map (kbd "<M-right>") nil))


;
;(setq org-pretty-entities t)


; ;; Set the calendar to open in a side window at the top of the screen
(add-to-list 'display-buffer-alist
             '("\\*Calendar\\*"
               (display-buffer-in-side-window)
               (side . top)
               (window-height . 20)))

(setq org-agenda-span 'day)


(define-prefix-command 'org-roam-prefix-map)
(global-set-key (kbd "C-c n") 'org-roam-prefix-map)


(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-dailies-directory   "Journal/")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
   '(("d" "default" entry
      (file "~/RoamNotes/Templates/DailyTemplate.org")
      :target (file+head "%<%d-%B-%Y-%A>.org" "#+title: %<%d %B %Y %A>\n")))
   )
  ;;(org-roam-capture-templates
  ;; '(("d" "default" plain
  ;;    "%?"
  ;;    :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org" "#+title: ${title}\n")
  ;;    :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  ;; Configure backlinks buffer to always appear at the bottom
  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (slot . 0)
                 (window-width . 0.33)
                 (window-height . 0.4)
                 (window-parameters . ((no-delete-other-windows . t)))))
  (org-roam-setup))
(org-roam-db-autosync-mode)

(global-set-key (kbd "s-d") 'org-roam-dailies-goto-today)
(global-set-key (kbd "s-c") 'org-roam-dailies-goto-date)
(global-set-key (kbd "s-a") (lambda () (interactive) (org-agenda nil "d")))
(global-set-key (kbd "C-s-{") 'org-roam-dailies-find-previous-note)
(global-set-key (kbd "C-s-}") 'org-roam-dailies-find-next-note)


(require 'org-roam-dailies)
