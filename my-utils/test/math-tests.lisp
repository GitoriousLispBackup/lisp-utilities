(in-package :my-utils-tests)

;;
(def-suite :my-utils-test-suite-math)
(in-suite :my-utils-test-suite-math)


;;
(test test-mean ()
      (is (= 1 (mean '(1))))
      (is (= 3/2 (mean '(1 2))))
      (is (= 2 (mean '(1 2 3)))))

;;
(test test-weighted-mean ()
      (is (= 1 (weighted-mean '(1) '(3))))
      (is (= 16/10 (weighted-mean '(1 2) '(4 6))))
      (is (= 2 (weighted-mean '(1 2 3) '(5 5 5)))))

;;
(test test-mode ()
      (is (equal '((1 . 1)) (multiple-value-list (mode '(1)))))
      (is (equal '((2 . 3) (1 . 1)) (multiple-value-list (mode '(1 2 2 2)))))
      (is (equal '(2 . 4) (mode '(1 2 2 2 2 3 3 3))))
      (is (equal '(5 . 4) (mode '(1 2 2 3 3 3 5 5 5 5)))))


;;
(test test-median ()
      (is (= 1 (median '(1))))
      (is (= 2 (median '(1 3))))
      (is (= 2 (median '(1 3 2))))
      (is (= 5/2 (median '(1 3 2 4)))))

(test test-quartile ()
      (is (equal '(11) (quartile '(11))))
      (is (equal '(1 5) (quartile '(1 5))))
      (is (equal '(3) (quartile '(1 3 5))))
      (is (equal '(3 5) (quartile '(1 3 5 7))))
      (is (equal '(3 5 7) (quartile '(1 3 5 7 9)))))
      
;;
(test test-standard-deviation ()
      (is (= 0 (standard-deviation '(1))))
      (is (= 0 (standard-deviation '(1 1))))
      (is (= (sqrt 2) (standard-deviation '(1 3 3 5)))))
      
;;
(test derivative ()
      (is (equal '()    (derivative '())))
      (is (equal '()    (derivative '(1))))
      (is (equal '(1)   (derivative '(1 2))))
      (is (equal '(1 3) (derivative '(1 2 5))))

      (is (equal '()    (derivative-n '() 1)))
      (is (equal '()    (derivative-n '(1) 1)))
      (is (equal '(1)   (derivative-n '(1 2) 1)))
      (is (equal '(1 3) (derivative-n '(1 2 5) 1)))

      (is (equal '(2)   (derivative-n '(1 2 5) 2))))


