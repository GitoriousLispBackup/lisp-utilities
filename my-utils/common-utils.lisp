(in-package :my-utils)

;;
(defun cyclic-range-2 (i1 i2 seq)
  "using poisition of the elements"
  (if (<= i1 i2)
       (subseq seq i1 (1+ i2))
       (append (subseq seq i1) (subseq seq 0 (1+ i2)))))

;;
(defun cyclic-range (el1 el2 seq)
  (loop for el in (append seq seq)
     with started = nil and stopped = nil
     when (equal el1 el) do (setq started  t)
     when (and started (equal el2 el)) do (setq stopped  t)
     when started collect el into result
     when stopped do (return result)))
     
;;
(defun ensure-list-2 (li)
  (let ((l (ensure-list li)))
    (if (listp (first l))
	l
	(list l))))  

;;
(defun range-listener (&key (key #'identity))
  (let  (min max min-val max-val result last-range)
    (lambda (el)
      (let ((val (funcall key el)))
      (cond 
	((not min) ;; initial state, no min or max
	 (setq min el min-val val) 
	 (setq max el max-val val)
	 (values (setq result (list min max)) 
		 (setq last-range 0)
		 nil))
		 
	((< val min-val)
	 (setq min el min-val val)
	 (values (setq result (list max min)) 
		 (setq last-range (- min-val max-val))
		 t))

	((> val max-val)
	 (setq max el max-val val)
	 (values (setq result (list min max)) 
		 (setq last-range (- max-val min-val))
		 t))
	
	(t  (values result last-range nil)))))))
