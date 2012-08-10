(in-package :my-utils)

;;
(defun group-n (n &key allow-incomplete (reverse t))
  (let ((buffer '()))
    (flet ((return-buffer ()
	     (if reverse 
		 (reverse buffer) 
		 (copy-list buffer))))
      (lambda (x)
	(push x buffer)
	(if (< (length buffer) n)
	    (if allow-incomplete (return-buffer) :more)
	    (prog1
		(return-buffer)
	      (setf buffer (nbutlast buffer 1))))))))

;;
(defun group (on-data &key on-first on-group (keep 0))
  (let ((buff (make-buffer)))
    (flet ((on-group-handler (buff li keep)
	     (if on-group 
		 (funcall on-group (flush buff li keep) li buff)
		 (flush buff li keep)))
	   (on-first-handler (buff li)
	     (case on-first
	       ('nil (funcall on-data li buff))
	       (:collect  :collect)
	       (t (funcall on-first li buff)))))
      (lambda (li)
	(if (eq li :reset)
	    (setq buff (make-buffer))
	    (ecase 
		(if (null (buffer-first buff))
		       (on-first-handler buff li)
		       (funcall on-data li buff))
	      (:collect 
	       (collect buff li)
		:more)
	      (:flush-n-collect
	       (on-group-handler buff li keep))
	      (:flush-n-skip 
	       (on-group-handler buff nil keep))
	      (:skip :more)))))))

;; can not have nil values inside !
(defstruct buffer (buffer) (first) (last) (length 0))

;;
(defun collect (buffer element &optional no-set-first)
  (unless no-set-first 
    (when (null (buffer-buffer buffer))
      (setf (buffer-first buffer) element)))
  (setf (buffer-last buffer) element)
  (incf (buffer-length buffer))
  (push element (buffer-buffer buffer)))

;;
(defun flush (buffer &optional element (keep 0))
  (prog1 
      (reverse (buffer-buffer buffer))
    (let ((new-buff (let ((buff (buffer-buffer buffer)))
		      (if (>= keep 0) 
			  (loop repeat keep 
			     for i in buff
			     collect i)
			  (butlast buff (- keep))))))
      (setf (buffer-buffer buffer) new-buff)
      (setf (buffer-first buffer) (first new-buff))
      (setf (buffer-last buffer) (last new-buff))
      (setf (buffer-length buffer) (length new-buff))
      (when element (collect buffer element)))))
  

