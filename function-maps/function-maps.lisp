(in-package :function-maps)

;; :MORE keyword is used as a break message.

;; each element of PARALLELS is a group of functions which run parallel, 
;; each combination of elements of PARALLELS (which are named as function-paths) connected as serials.
;;
(defun compose (&rest parallels)
  (apply #'compose-parallel (mapcar 
			     (lambda (path) (apply #'compose-serial path))
			     (function-paths parallels))))

;;    
(defun function-paths (parallels)
  (if (null parallels)
      '(nil)
      (loop for l in (ensure-list (car parallels)) 
	 append (mapcar (lambda (y) (cons l y)) 
			(function-paths (cdr parallels))))))

;;
(defun compose-serial (&rest funs)
  (labels ((cs (result funs)
	     (if (null funs)
		 result
		 (if (eq result :more)
		     :more
		     (cs (funcall (car funs) result) (cdr funs))))))
    (lambda (&optional x)
      (cs x funs))))

;;
(defun compose-parallel (&rest funs)
  (lambda (x) 
    (loop for f in funs
       do (if (eq x :more)
	      :more
	      (funcall f x)))))
		   