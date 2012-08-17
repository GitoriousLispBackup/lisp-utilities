(in-package :function-maps)

;; 
(defun collect-listener()
  (let ((result '()))
    (lambda(el)
      (case el 
	(:get (reverse result))
	((:refresh :fresh :new) (setq result '()))
	((:pprint :show :print) (pprint (reverse result)))
	(t (push el result) nil)))))
      
