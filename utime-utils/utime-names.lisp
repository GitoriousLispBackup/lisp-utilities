(in-package :utime-utils)

;;
(defparameter *month-names* '((1 :january :jan :|OCAK|) ; make sbcl happy about "redefined constants" 
			      (2 :february :feb :|SUBAT|) 
			      (3 :march :mar :|MART|) 
			      (4 :april :apr :|NISAN|) 
			      (5 :may :may :|MAYIS|) 
			      (6 :june :jun :|HAZIRAN|) 
			      (7 :july :jul :|TEMMUZ|) 
			      (8 :august :aug :|AGUSTOS|) 
			      (9 :september :sept :sep :|EYLUL|) 
			      (10 :october :oct :|EKIM|) 
			      (11 :november :nov :|KASIM|) 
			      (12 :december :dec :|ARALIK|)))

;;
(defparameter *day-names*    '((0 :monday :mon :|PAZARTESI|) ; make sbcl happy about "redefined constants" 
			       (1 :tuesday :tues :tu :tue :|SALI|) 
			       (2 :wednesday :wed :|CARSAMBA|) 
			       (3 :thursday :thurs :th :thu :thur :|PERSEMBE|) 
			       (4 :friday :fri :|CUMA|) 
			       (5 :saturday :sat :|CUMARTESI|) 
			       (6 :sunday :sun :|PAZAR|)))

;;
(defun same-dow (any1 any2)
  (equal (dow-alias any1) (dow-alias any2)))

;;
(defun same-month (any1 any2)
  (equal (month-alias any1) (month-alias any2)))

;;
(defun alias-util (any table)
  (or (find-if (lambda (li) (member any li)) table)
      (error "~a is not a valid representation" any)))

;;
(defun month-alias (any)
  (alias-util any *month-names*))

;;
(defun dow-alias (any)
  (alias-util any *day-names*))
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defun dow-range (any1 any2 &key (encode t))
  (let ((range (cyclic-range-2 (car (dow-alias any1))
			       (car (dow-alias any2))
			       *day-names*)))
    (if encode
	(mapcar #'car range)
	range)))

;;
(defun month-range (any1 any2 &key (encode t))
  (let ((range (cyclic-range-2 (1- (car (month-alias any1)))
			       (1- (car (month-alias any2)))
			       *month-names*)))
    (if encode
	(mapcar #'car range)
	range)))



