(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar


;; Set up the visible bell
(setq visible-bell nil)


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Set the fixed pitch face

(set-face-attribute 'default nil :height 150) ;; 12pt font

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 200 :weight 'regular)


(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))


(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
			  '(("^ *\\([-]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


  ;; Set faces for heading levels with colors
  (set-face-attribute 'org-level-1 nil :font "Helvetica" :weight 'bold :height 2.0 :foreground "black")
  (set-face-attribute 'org-level-2 nil :font "Helvetica" :weight 'bold :height 1.4 :foreground "black")
  (set-face-attribute 'org-level-3 nil :font "Helvetica" :weight 'regular :height 1.3 :foreground "yellow")
  (set-face-attribute 'org-level-4 nil :font "Helvetica" :weight 'regular :height 1.0 :foreground "green")
  (set-face-attribute 'org-level-5 nil :font "Helvetica" :weight 'regular :height 1.1 :foreground "blue")
  (set-face-attribute 'org-level-6 nil :font "Helvetica" :weight 'regular :height 1.1 :foreground "purple")
  (set-face-attribute 'org-level-7 nil :font "Helvetica" :weight 'regular :height 1.1 :foreground "magenta")
  (set-face-attribute 'org-level-8 nil :font "Helvetica" :weight 'regular :height 1.1 :foreground "cyan")


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
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))




(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-files
	'("~/RoamNotes/Tasks.org"))
  (setq org-hide-emphasis-markers t)
  (efs/org-font-setup))


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  ;(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))
  (org-bullets-bullet-list '("" "" "" "" "" "" "")))


(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 150
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))



(setq org-latex-create-formula-image-program 'dvipng) ;; or 'dvisvgm for SVG output
(setq org-export-with-broken-links t)  ;; Allow all broken links
