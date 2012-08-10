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
(defun range-listener ()
  (let  (min max order)
    (lambda (el)
	(cond 
	  ((not min) 
	   (setq min el max el order 0))
	  ((< el min)
	   (setq min el)
	   (setq order -1))
	  ((> el max)
	   (setq max el)
	   (setq order 1)))
	(if (> order 0)
	    (list min max)
	    (list max min)))))
	     