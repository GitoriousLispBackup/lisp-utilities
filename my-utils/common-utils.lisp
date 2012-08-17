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
  (let  (min max min-val max-val result)
    (flet ((set-min (new-min)
	     (setq min new-min min-val (funcall key new-min))
	     (values (setq result (list max min)) t))
	   (set-max (new-max)
	     (setq max new-max max-val (funcall key new-max))
	     (values (setq result (list min max)) t)))
    (lambda (el)
      (let ((val (funcall key el)))
	(cond 
	  ((not min) 
	   (set-min el) (set-max el))
	  ((< val min-val)
	   (set-min el))
	  ((> val max-val)
	   (set-max el))
	  (t (values result nil))))))))
