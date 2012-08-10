(in-package :pattern-streams)

;;
(defstruct (frequency-table 
	     (:conc-name ft-)
	     (:constructor make-frequency-table (&key (key #'identity)
						      (pattern-table (make-hash-table :test #'equal))
						      (pattern-class-table (make-hash-table :test #'equal))
						      (entry-count 0)
						      (pattern-test nil) 
						      (pattern-classifier #'length)
						      (grouper (group-n 20 :allow-incomplete t)))))
  key
  pattern-table 
  pattern-class-table
  entry-count
  pattern-test
  pattern-classifier
  grouper)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 
(defun feed-frequency-table (ft data)
  (mapl (lambda (x) (update-frequency-table ft x)) 
	(funcall (ft-grouper ft) 
		 (funcall (ft-key ft) data))))

;;
(defun feed-frequency-table-of-strings (ft data)
  (mapl (lambda (x) (update-frequency-table ft (apply #'concatenate 'string x)))
	(funcall (ft-grouper ft) (string data))))

;;
(defun update-frequency-table (ft pattern)
  (unless (and (ft-pattern-test ft) 
	       (not (funcall (ft-pattern-test ft) pattern)))
    (progn (incf (ft-entry-count ft))
	   (incf (gethash (funcall (ft-pattern-classifier ft) pattern) 
			  (ft-pattern-class-table ft) 
			  0))
	   (incf (gethash pattern (ft-pattern-table ft) 0)))))

;;
(defun reset-frequency-table (ft)
  (clrhash (ft-pattern-table ft))
  (clrhash (ft-pattern-class-table ft))
  (setf (ft-entry-count ft) 0)
  (funcall (ft-grouper ft) :reset))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
(defun pattern-class (ft pattern)
  (funcall (ft-pattern-classifier ft) pattern))

;;
(defun pattern-frequency (ft pattern)
  (gethash pattern (ft-pattern-table ft) 0))

;;
(defun pattern-class-frequency (ft pattern-class)
  (gethash pattern-class (ft-pattern-class-table ft) 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
(defun pattern-probability (ft pattern)
  (let ((n (ft-entry-count ft)))
    (if (plusp n) 
	(/ (pattern-frequency ft pattern) n)
	0)))

;;
(defun pattern-class-probability (ft pattern-class)
    (let ((n (ft-entry-count ft)))
    (if (plusp n) 
	(/ (pattern-class-frequency ft pattern-class) n)
	0)))

;;
(defun pattern-in-class-probability (ft pattern)
  (let ((n (pattern-class-frequency ft (pattern-class ft pattern))))
    (if (plusp n) 
	(/ (pattern-frequency ft pattern) n)
	0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dump-frequency-table (ft)
  (dump-hashtable (ft-pattern-table ft)))

;;
(defun dump-hashtable (ht)
  (loop for k being the hash-key using (hash-value v) of ht
       do (format t "~40a~40a~%" k v)))