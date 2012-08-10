(in-package :function-maps)

;; prints stream
(defun print-listener-instance (&optional (stream *standard-output*)) 
  (lambda (el) (print el stream)))

;; have multiple instances of collectors.
(defun collect-listener()
  (let ((result '()))
    (lambda(el)
      (case el 
	(:get (reverse result))
	((:refresh :fresh :new) (setq result '()))
	((:pprint :show :print) (pprint (reverse result)))
	(t (push el result) nil)))))
      
