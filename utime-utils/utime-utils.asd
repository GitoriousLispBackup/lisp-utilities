(in-package :cl-user)

;;
(defpackage :utime-utils.system
        (:use :cl :asdf))

;;
(in-package :utime-utils.system)

;;
(defsystem :utime-utils
  :depends-on (:my-utils :cl-ppcre)
  :components ((:file "packages")
	       (:file "utime-utils" :depends-on ("packages"))
	       (:file "utime-names" :depends-on ("packages"))))

;;
(defsystem :utime-utils-tests
  :depends-on (:utime-utils :fiveam)
  :components ((:module "test"
			:components ((:file "packages")
				     (:file "utime-utils-tests" :depends-on ("packages"))
				     (:file "utime-names-tests" :depends-on ("packages"))))))

;;
(defmethod perform ((op asdf:test-op) (system (eql (find-system :utime-utils))))
  (operate 'load-op :utime-utils-tests)
  (funcall (find-symbol (string :run!) :fiveam) :utime-utils-test-suite)
  (funcall (find-symbol (string :run!) :fiveam) :utime-names-test-suite))