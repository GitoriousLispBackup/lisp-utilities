(in-package :cl-user)

;;
(defpackage :my-utils.system
        (:use :cl :asdf))

;;
(in-package :my-utils.system)

;;
(defsystem :my-utils
  :depends-on (:alexandria)
  :components ((:file "packages")
	       (:file "macros" :depends-on ("packages"))
	       (:file "common-utils" :depends-on ("packages"))
	       (:file "math-utils" :depends-on ("packages"))
	       (:file "grouping" :depends-on ("packages"))))	       

;;
(defsystem :my-utils-tests
  :depends-on (:my-utils :fiveam)
  :components ((:module "test"
			:components ((:file "packages")
				     (:file "common-tests" :depends-on ("packages"))
				     (:file "math-tests" :depends-on ("packages"))
				     (:file "grouping-tests" :depends-on ("packages"))))))

;;
(defmethod perform ((op asdf:test-op) (system (eql (find-system :my-utils))))
  (operate 'load-op :my-utils-tests)
  (funcall (find-symbol (string :run!) :fiveam) :my-utils-test-suite-commons)
  (funcall (find-symbol (string :run!) :fiveam) :my-utils-test-suite-math)
  (funcall (find-symbol (string :run!) :fiveam) :my-utils-test-suite-grouping))