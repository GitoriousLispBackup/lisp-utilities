(in-package :my-utils-tests)

;;
(def-suite :my-utils-test-suite-grouping)
(in-suite :my-utils-test-suite-grouping)

;;
(test test-group-n ()
      (let ((grp (group-n 3)))
	(is (equal '(:more :more (3 3 4) (3 4 5))
		   (loop for i in '(3 3 4 5) collect (funcall grp i)))))

      (let ((grp (group-n 3 :allow-incomplete t)))
	(is (equal '((1) (1 2) (1 2 3) (2 3 4))
		   (loop for i in '(1 2 3 4) collect (funcall grp i)))))

      (let ((grp (group-n 3 :allow-incomplete t :reverse nil)))
	(is (equal '((1) (2 1) (3 2 1) (4 3 2))
		   (loop for i in '(1 2 3 4) collect (funcall grp i))))))

;;
(test test-group-1 ()
      (let ((evens (group (lambda (el buff)
			    (declare (ignore buff))
			    (if (evenp el) 
				:collect 
				:flush-n-skip)))))
	(is (equal '((2 4 6) (16 18))
		   (remove :more (mapcar evens '(2 4 6 11 16 18 21)))))))

;;
(test test-group-2 ()
      ;; even numbers, with group count
      (let ((evens (group (lambda (el buff)
			    (declare (ignore buff))
			    (if (evenp el)
				:collect 
				:flush-n-skip))
			  :on-group (let ((x 0))
				      (lambda (grp li buff)
					(declare (ignore li buff))
					(cons (incf x) grp))))))
	
	(is (equal '((1 2 4 6 8 10) (2 12 14))
		   (remove :more (mapcar evens '(2 4 6 8 10 11 12 14 15)))))))

;;
(test test-group-3 ()
      ;; even numbers, packed in 3 
      (let ((evens (group (lambda (el buff)
			    (if (evenp el)
				(if (< (buffer-length buff) 3)
				    :collect
				    :flush-n-collect)
				:skip)))))	
	(is (equal '((2 4 6) (8 10 12) (14 16 18))
		   (remove :more (mapcar evens '(2 4 6 8 10 11 12 14 15 15 16 17 18 19 20)))))))

;;
(test test-group-4 ()
      ;; diff no more than 3 with first
      (let ((diff3-first (group (lambda (el buff)
				  (if (> (abs (- (buffer-first buff) el)) 3)
				      :flush-n-collect
				      :collect))
				:on-first :collect)))
	(is (equal '((1 2) (5) (9 11 8 7))
		   (remove :more (mapcar diff3-first '(1 2 5 9 11 8 7 111)))))))

;;
(test test-group-5 ()
      ;; diff no more than 3 with last
      (let ((diff3-last (group (lambda (el buff)
				 (if (> (abs (- (buffer-last buff) el)) 3)
				     :flush-n-collect
				     :collect))
			       :on-first :collect)))
	(is (equal '((1 2 5) (9 11) (2) (7 8))
		   (remove :more (mapcar diff3-last '(1 2 5 9 11 2 7 8 111)))))))

;;
(test test-group-2-2 ()
      ;; even numbers, with group count, with keep
      (let ((evens (group (lambda (el buff)
			    (declare (ignore buff))
			    (if (evenp el)
				:collect 
				:flush-n-skip))
			  :keep 2
			  :on-group (let ((x 0))
				      (lambda (grp el buff)
					(declare (ignore el buff))
					(cons (incf x) grp))))))
	
	(is (equal '((1 2 4 6 8 10) (2 8 10 12 14))
		   (remove :more (mapcar evens '(2 4 6 8 10 11 12 14 15)))))))

;;
(test test-group-3-2 ()
      ;; even numbers, packed in 3, with keep
      (let ((evens (group (lambda (el buff)
			    (if (evenp el)
				(if (< (buffer-length buff) 3)
				    :collect
				    :flush-n-collect)
				:skip))
			  :keep 2)))	
	(is (equal '((2 4 6) (4 6 8) (6 8 10) (8 10 12) (10 12 14) (12 14 16) (14 16 18))
		   (remove :more (mapcar evens '(2 4 6 8 10 11 12 14 15 15 16 17 18 19 20)))))))

;;
;;
(test test-group-2-3 ()
      ;; even numbers, with group count, with negative keep
      (let ((evens (group (lambda (el buff)
			    (declare (ignore buff))
			    (if (evenp el)
				:collect 
				:flush-n-skip))
			  :keep -1
			  :on-group (let ((x 0))
				      (lambda (grp el buff)
					(declare (ignore el buff))
					(cons (incf x) grp))))))
	
	(is (equal '((1 2 4 6 8 10) (2 4 6 8 10 12 14))
		   (remove :more (mapcar evens '(2 4 6 8 10 11 12 14 15)))))))

;;
(test test-group-3-3 ()
      ;; even numbers, packed in 3 , with negative keep
      (let ((evens (group (lambda (el buff)
			    (if (evenp el)
				(if (< (buffer-length buff) 3)
				    :collect
				    :flush-n-collect)
				:skip))
			  :keep -2)))	
	(is (equal '((2 4 6) (6 8 10) (10 12 14) (14 16 18))
		   (remove :more (mapcar evens '(2 4 6 8 10 11 12 14 15 15 16 17 18 19 20)))))))

;;
(test test-group-5-3 ()
      ;; diff no more than 3 with last with negative keep
      (let ((diff3-last (group (lambda (el buff)
				 (if (> (abs (- (buffer-last buff) el)) 3)
				     :flush-n-collect
				     :collect))
			       :keep -5
			       :on-first :collect)))
	(is (equal '((1 2 5) (9 11) (2) (7 8))
		   (remove :more (mapcar diff3-last '(1 2 5 9 11 2 7 8 111)))))))
