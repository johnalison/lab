
(require 'limited)

(defvar johns-refill-mode nil
  "Mode variable for refill minor mode.")
(make-variable-buffer-local 'johns-refill-mode)


(defun johns-refill-mode (&optional arg)
  "Refill minor mode."
  (interactive "P")
  (setq johns-refill-mode
	(if (null arg)
	    (not johns-refill-mode)
	  (> (prefix-numeric-value arg) 0)))
  ;(add-hook 'after-change-functions nil t)
  (if johns-refill-mode
      (add-hook 'after-change-functions 'refill nil t)
    (remove-hook 'after-change-functions 'refill t)))


(if (not (assq 'johns-refill-mode minor-mode-alist))
    (setq minor-mode-alist
	  (cons '(johns-refill-mode " Johns Refill")
		minor-mode-alist)))




(defun refill (start end len)
  "After a text change, refill the current paragraph."
  (let ((left (if (zerop len)
		  start
		(save-excursion
		  (max (progn
			 (goto-char start)
			 (beginning-of-line 0)
			 (point))
		       (progn
			 (goto-char start)
			 (backward-paragraph 1)
			 (point)))))))
    (if (or (and (zerop len)
		 (same-line-p start end)
		 (short-line-p end))
	    (and (eq (char-syntax (preceding-char))
		     ?\ )
		 (looking-at "\\s *$")))
	nil
      (save-excursion
	(fill-region left end nil nil t)))))



;(defun before-2nd-word-p (pos)
;  "Does POS lie before the second word on the line?"
;  (save-excursion
;    (goto-char pos)
;    (beginning-of-line)
;    (skip-syntax-forward (concat "^ "
;				  (char-to-string
;				   (char-syntax ?\n))))
;    (skip-syntax-forward " ")
;    (< pos (point))))


(defun same-line-p (start end)
  "Are START and END on the same line?"
  (save-excursion
    (goto-char start)
    (end-of-line)
    (<= end (point))))


(defun short-line-p (pos)
  "Does line containing POS stay within 'fill-column'?"
  (save-excursion
    (goto-char pos)
    (end-of-line)
    (<= (current-column) fill-column)))
