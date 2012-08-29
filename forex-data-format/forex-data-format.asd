(in-package :cl-user)

;;
(defpackage :forex-data-format.system
        (:use :cl :asdf))

;;
(in-package :forex-data-format.system)

;;
(defsystem :forex-data-format
  :depends-on (:utime-utils :my-utils)
  :components ((:file "packages")
	       (:file "forex-data-format" :depends-on ("packages"))
	       (:file "ticks-to-candles" :depends-on ("packages" "forex-data-format"))))

;;
(defsystem :forex-data-format-tests
  :depends-on (:forex-data-format :fiveam)
  :components ((:module "test"
			:components ((:file "packages")
				     (:file "test-data" :depends-on ("packages"))
				     (:file "forex-data-format-tests" :depends-on ("packages"))
				     (:file "ticks-to-candles-tests-1" :depends-on ("packages" "test-data"))
				     (:file "ticks-to-candles-tests-2" :depends-on ("packages" "test-data"))))))

;;
(defmethod perform ((op asdf:test-op) (system (eql (find-system :forex-data-format))))
  (operate 'load-op :forex-data-format-tests)
  (funcall (find-symbol (string :run!) :fiveam) :forex-data-format-test-suite)
  (funcall (find-symbol (string :run!) :fiveam) :ticks-to-candles-test-suite))