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
	