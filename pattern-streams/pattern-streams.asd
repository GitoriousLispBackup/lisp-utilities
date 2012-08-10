(in-package :cl-user)

;;
(defpackage :pattern-streams.system
        (:use :cl :asdf))

;;
(in-package :pattern-streams.system)

;;
(defsystem :pattern-streams
  :depends-on (:my-utils)
  :components ((:file "packages")
	       (:file "frequency-table" :depends-on ("packages"))))

;;
(defsystem :pattern-streams-tests
  :depends-on (:pattern-streams :fiveam)
  :components ((:module "test" 
			:components ((:file "packages")
				     (:file "tests" :depends-on ("packages"))))))

;;
(defmethod perform ((op asdf:test-op) (system (eql (find-system :pattern-streams))))
  (operate 'load-op :pattern-streams-tests)
  (funcall (find-symbol (string :run!) :fiveam) :pattern-streams-test-suite))