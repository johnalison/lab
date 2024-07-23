(provide 'limited)

(defmacro limited-save-excursion (&rest subexprs)
  "Like save-excursion, but only restores the point."
  (let ((orig-point-symbol (make-symbol "orig-point")))
    `(let ((,orig-point-symbol (point-marker)))
       (unwind-protect
	   (progn ,@subexprs) 
	 (goto-char ,orig-point-symbol)))))


