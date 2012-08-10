(in-package :pattern-streams-tests)

(def-suite :pattern-streams-test-suite)
(in-suite :pattern-streams-test-suite)

;; 
(test simple-usage-tests-a 
  (let ((ft (make-frequency-table)))
    (feed-frequency-table ft 'a)

    (is (equal 1 (pattern-frequency ft '(a))))
    (is (equal 1 (pattern-class-frequency ft 1)))
    (is (equal 1 (pattern-probability ft '(a))))
    (is (equal 1 (pattern-in-class-probability ft '(a))))))
    
;;
(test simple-usage-tests-aa 
  (let ((ft (make-frequency-table)))
    (feed-frequency-table ft 'a)
    (feed-frequency-table ft 'a)

    (is (equal 2 (pattern-frequency ft '(a))))
    (is (equal 2 (pattern-class-frequency ft 1)))
    (is (equal 2/3 (pattern-probability ft '(a))))
    (is (equal 1 (pattern-in-class-probability ft '(a))))
    
    (is (equal 1 (pattern-frequency ft '(a a))))
    (is (equal 1 (pattern-class-frequency ft 2)))
    (is (equal 1/3 (pattern-probability ft '(a a))))
    (is (equal 1 (pattern-in-class-probability ft '(a a))))))

;;
(test simple-usage-tests-aaa
  (let ((ft (make-frequency-table)))
    (feed-frequency-table ft 'a)
    (feed-frequency-table ft 'a)
    (feed-frequency-table ft 'a)

    (is (equal 3 (pattern-frequency ft '(a))))
    (is (equal 3 (pattern-class-frequency ft 1)))
    (is (equal 1/2 (pattern-probability ft '(a))))
    (is (equal 1 (pattern-in-class-probability ft '(a))))
    
    (is (equal 2 (pattern-frequency ft '(a a))))
    (is (equal 2 (pattern-class-frequency ft 2)))
    (is (equal 1/3 (pattern-probability ft '(a a))))
    (is (equal 1 (pattern-in-class-probability ft '(a))))))

;;
(test simple-usage-tests-abc
  (let ((ft (make-frequency-table)))
    (feed-frequency-table ft 'a)
    (feed-frequency-table ft 'b)
    (feed-frequency-table ft 'c)

    (is (equal 1 (pattern-frequency ft '(a))))
    (is (equal 3 (pattern-class-frequency ft 1)))
    (is (equal 1/6 (pattern-probability ft '(a))))
    (is (equal 1/3 (pattern-in-class-probability ft '(a))))

    (is (equal 1 (pattern-frequency ft '(b))))
    (is (equal 1/6 (pattern-probability ft '(b))))
    (is (equal 1/3 (pattern-in-class-probability ft '(b))))
    
    (is (equal 1 (pattern-frequency ft '(c))))
    (is (equal 1/6 (pattern-probability ft '(c))))
    (is (equal 1/3 (pattern-in-class-probability ft '(c))))
    
    (is (equal 1 (pattern-frequency ft '(a b))))
    (is (equal 2 (pattern-class-frequency ft 2)))
    (is (equal 1/6 (pattern-probability ft '(a b))))
    (is (equal 1/2 (pattern-in-class-probability ft '(a b))))

    (is (equal 1 (pattern-frequency ft '(b c))))
    (is (equal 1/6 (pattern-probability ft '(b c))))
    (is (equal 1/2 (pattern-in-class-probability ft '(b c))))

    (is (equal 1 (pattern-frequency ft '(a b c))))
    (is (equal 1 (pattern-class-frequency ft 3)))
    (is (equal 1/6 (pattern-probability ft '(a b c))))
    (is (equal 1 (pattern-in-class-probability ft '(a b c))))))

;;
(test simple-usage-tests-reset
  (let ((ft (make-frequency-table)))
    (feed-frequency-table ft 'a)
    (feed-frequency-table ft 'a)
    (feed-frequency-table ft 'a)
    
    (reset-frequency-table ft)

    (is (equal 0 (pattern-frequency ft '(a))))
    (is (equal 0 (pattern-class-frequency ft 1)))
    (is (equal 0 (pattern-probability ft '(a))))
    (is (equal 0 (pattern-in-class-probability ft '(a))))))

;;
(test simple-usage-tests-strings
  (let ((ft (make-frequency-table)))
    (feed-frequency-table-of-strings ft #\O)
    (feed-frequency-table-of-strings ft #\f)
    (feed-frequency-table-of-strings ft "f")

    (is (equal 1 (pattern-frequency ft "Of")))
    (is (equal 2 (pattern-class-frequency ft 2)))
    (is (equal 1/6 (pattern-probability ft "Of")))
    (is (equal 1/2 (pattern-in-class-probability ft "Of")))

    (is (equal 1 (pattern-frequency ft "Off")))
    (is (equal 1 (pattern-class-frequency ft 3)))
    (is (equal 1/6 (pattern-probability ft "Off")))
    (is (equal 1 (pattern-in-class-probability ft "Off")))))

;;
(test simple-usage-tests-pattern-test
  (let ((ft (make-frequency-table :pattern-test (lambda (x) (not (equal x '(b)))))))
    (feed-frequency-table ft 'a)
    (feed-frequency-table ft 'b)
    (feed-frequency-table ft 'c)

    (is (equal 1 (pattern-frequency ft '(a))))
    (is (equal 2 (pattern-class-frequency ft 1)))
    (is (equal 1/5 (pattern-probability ft '(a))))
    (is (equal 1/2 (pattern-in-class-probability ft '(a))))))

