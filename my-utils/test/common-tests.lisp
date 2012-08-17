(in-package :my-utils-tests)

;;
(def-suite :my-utils-test-suite-commons)
;;
(in-suite :my-utils-test-suite-commons)

;;
(test ensure-list-2-test ()
      (is (equal '() (ensure-list-2 '())))
      (is (equal '((1)) (ensure-list-2 '(1))))
      (is (equal '((1)) (ensure-list-2 1)))
      (is (equal '((1)) (ensure-list-2 '((1)))))
      (is (equal '((1 2)) (ensure-list-2 '((1 2))))))	

;;
(test cyclic-range-test ()
      (is (equal '(a) (cyclic-range 'a 'a '(a b c d))))
      (is (equal '(d) (cyclic-range 'd 'd '(a b c d))))
      (is (equal '(a b c d) (cyclic-range 'a 'd '(a b c d))))
      (is (equal '(b c) (cyclic-range 'b 'c '(a b c d))))

      (is (equal '(b c d a) (cyclic-range 'b 'a '(a b c d))))
      (is (equal '(d a) (cyclic-range 'd 'a '(a b c d)))))

;;
(test cyclic-range-2-test ()
      (is (equal '(a) (cyclic-range-2 0 0 '(a b c d))))
      (is (equal '(d) (cyclic-range-2 3 3 '(a b c d))))
      (is (equal '(a b c d) (cyclic-range-2 0 3 '(a b c d))))
      (is (equal '(b c) (cyclic-range-2 1 2 '(a b c d))))

      (is (equal '(b c d a) (cyclic-range-2 1 0 '(a b c d))))
      (is (equal '(d a) (cyclic-range-2 3 0 '(a b c d)))))

;;
(test range-listener ()
      (let ((r (range-listener)))	
	(is (equal '(1 1) (funcall r 1)))
	(is (equal '(1 1) (funcall r 1)))
	(is (equal '(1 2) (funcall r 2)))
	(is (equal '(2 0) (funcall r 0)))
	(is (equal '(2 -1) (funcall r -1)))
	(is (equal '(-1 11) (funcall r 11)))
	(is (equal '(-1 11) (funcall r 10)))
	(is (equal '(-1 11) (funcall r -1)))))

;;
(test range-listener-test-2 ()
      (let ((r (range-listener :key #'car)))	
	(multiple-value-bind (li change) (funcall r '(1 a 3))	  
	  (is (equal li '((1 a 3) (1 a 3))))
	  (is-true change))
	
	(multiple-value-bind (li change) (funcall r '(1 3 r))	  
	  (is (equal li '((1 a 3) (1 a 3))))
	  (is-true (not change)))

	(multiple-value-bind (li change) (funcall r '(2 r d))	  
	  (is (equal li '((1 a 3) (2 r d))))
	  (is-true change))

	(multiple-value-bind (li change) (funcall r '(0 3 e))	  
	  (is (equal li '((2 r d) (0 3 e))))
	  (is-true change))

	(multiple-value-bind (li change) (funcall r '(-1 -11 -111))	  
	  (is (equal li '((2 r d) (-1 -11 -111))))
	  (is-true change))

	(multiple-value-bind (li change) (funcall r '(10 11 100 9))
	  (is (equal li '((-1 -11 -111) (10 11 100 9))))
	  (is-true change))))
	