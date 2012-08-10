(in-package :my-utils)

;;
(defmacro with-output-to-file (file-name &body body &aux (stream (gensym)) (done (gensym)))
  `(let ((,stream (open ,file-name :direction :output :if-exists :rename-and-delete))
	 (,done nil))
     (unwind-protect
	  (locally (declare (special *standard-output*))
	    (let ((*standard-output* ,stream))
	      ,@body
	      (setq ,done t)))
       (when ,stream (close ,stream :abort (null ,done))))))
