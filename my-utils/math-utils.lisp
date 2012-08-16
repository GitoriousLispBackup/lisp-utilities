(in-package :my-utils)


;;
(defun weighted-mean (li weigths)
  (assert (and li weigths))
  (/ (apply #'+ (mapcar #'* li weigths))
     (apply #'+ weigths)))

;;
(defun mode (li)
  (assert li)
  (let ((freq-map (make-hash-table)))
    (mapc (lambda (el) 
	    (incf (gethash el freq-map 0)))
	    li)
    (values-list (sort-the-map freq-map))))

;;
(defun sort-the-map (freq-map)
  (sort 
   (loop 
      for element being the hash-key of freq-map
      using (hash-value repeat)
      collect (cons element repeat))
   #'>
   :key #'cdr))

;;
(defun q1 (li)
  (assert li)
  (let ((q2 (median li)))
    (median (remove-if (lambda (val) (> val q2)) li))))

;;
(defun q3 (li)
  (assert li)
  (let ((q2 (median li)))
    (median (remove-if (lambda (val) (< val q2)) li))))

;;
(defun quartile (li)
  (let ((q1 (q1 li))
	(q3 (q3 li)))
    (remove-if (lambda (val) (or (< val q1) (> val q3))) li)))
      
;;
;(defun standard-deviation (li &optional (normalize nil) (sample nil))
;  (assert li)
;  (let ((l (length li)) 
;	(m (mean li)))
;    (/ (sqrt (/ (apply #'+ (mapcar #'(lambda (x) (expt (- m x) 2)) li))
;	      (if sample (1- l) l)))
;       (if normalize m 1))))

;;
(defun derivative (l)
  (if (null (cdr l))
      '()
      (cons (- (second l) (first l)) 
	    (derivative (cdr l)))))

;;
(defun derivative-n (l degree)
    (if (null l)
	'()
	(if (zerop degree)
	    l
	    (derivative-n (derivative l) (1- degree)))))

;;
  
