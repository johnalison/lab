C-x C-k C-i  ; Insert the keyboard macro counter value in the buffer
C-x ( ; start macro
C-x ) ; end macro
C-x e ; Apply macro
C-x C-k e; Edit macro


(global-set-key "\M-," 'point-to-top)
(global-set-key "\M-." 'point-to-bottom)
(global-set-key "\M-!" 'line-to-top)
(global-set-key "\M-_" 'unscroll)


# External Packages

git clone git@github.com:johnalison/obsidian.el.git
git clone git@github.com:johnalison/markdown-mode.git

