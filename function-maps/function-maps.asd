(in-package :cl-user)

;;
(defpackage :function-maps.system
        (:use :cl :asdf))

;;
(in-package :function-maps.system)

;;
(defsystem :function-maps
  :depends-on (:my-utils)
  :components ((:file "packages")
	       (:file "function-maps" :depends-on ("packages"))
	       (:file "collect-listener" :depends-on ("packages"))))

;;
(defsystem :function-maps-tests
  :depends-on (:function-maps :fiveam)
  :components ((:module "test"
			:components ((:file "packages")
				     (:file "tests" :depends-on ("packages"))))))

;;
(defmethod perform ((op asdf:test-op) (system (eql (find-system :function-maps))))
  (operate 'load-op :function-maps-tests)
  (funcall (find-symbol (string :run!) :fiveam) :function-maps-test-suite))