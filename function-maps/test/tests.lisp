(in-package :function-maps-tests)

(def-suite :function-maps-test-suite)
(in-suite :function-maps-test-suite)

;;
(defun double (x) (* 2 x))

;;
(test collect-listener-test 
  (let ((col (collect-listener)))
    (funcall col 1)
    (is (equal '(1) (funcall col :get)))
    (funcall col 17)
    (is (equal '(1 17) (funcall col :get)))
    (funcall col 21)
    (is (equal '(1 17 21) (funcall col :get)))
    (funcall col :refresh)
    (is (equal '() (funcall col :get)))

    (funcall col 1)
    (is (equal '(1) (funcall col :get)))
    (funcall col 17)
    (is (equal '(1 17) (funcall col :get)))
    (funcall col 21)
    (is (equal '(1 17 21) (funcall col :get)))))

;;
(test compose-serial-test
  (let ((col (collect-listener)))
    (funcall (compose-serial '1+ '1+ '1+ col) 0)
    (is (equal '(3) (funcall col :get)))
    
    (funcall col :refresh)
    (funcall (compose '1+ '1+ '1+ col) 0)
    (is (equal '(3) (funcall col :get)))
    
    (funcall col :refresh)
    (funcall (compose 'double 'double '1+ col) 5)
    (is (equal '(21) (funcall col :get)))
    
    (funcall col :refresh)
    (funcall (compose-serial 'double 'double '1+ col) 5)
    (is (equal  '(21) (funcall col :get)))))

;;
(test compose-parallel-test
  (let ((col (collect-listener)))
    (funcall (compose '(1+ 1-) col) 0)
    (is (equal '(1 -1) (funcall col :get)))

    (funcall col :refresh)
    (funcall (compose '(double double 1+) col) 5)
    (is (equal '(10 10 6) (funcall col :get)))

    (funcall col :refresh)
    (funcall (compose '(1- 1+) '(double 1+) col) 5)
    (is (equal '(8 5 12 7) (funcall col :get)))))
  
