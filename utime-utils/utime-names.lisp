(in-package :utime-utils)

;;
(defconstant *month-names* '((:1 :january :jan :|OCAK|) 
			     (:2 :february :feb :|SUBAT|) 
			     (:3 :march :mar :|MART|) 
			     (:4 :april :apr :|NISAN|) 
			     (:5 :may :may :|MAYIS|) 
			     (:6 :june :jun :|HAZIRAN|) 
			     (:7 :july :jul :|TEMMUZ|) 
			     (:8 :august :aug :|AGUSTOS|) 
			     (:9 :september :sept :sep :|EYLUL|) 
			     (:10 :october :oct :|EKIM|) 
			     (:11 :november :nov :|KASIM|) 
			     (:12 :december :dec :|ARALIK|)))

;;
(defconstant *day-names*    '((:0 :monday :mon :|PAZARTESI|) 
			      (:1 :tuesday :tues :tu :tue :|SALI|) 
			      (:2 :wednesday :wed :|CARSAMBA|) 
			      (:3 :thursday :thurs :th :thu :thur :|PERSEMBE|) 
			      (:4 :friday :fri :|CUMA|) 
			      (:5 :saturday :sat :|CUMARTESI|) 
			      (:6 :sunday :sun :|PAZAR|)))

;;
(defun keyword-to-integer (kwd)
  (parse-integer (string kwd)))

;;
(defun utility-for-same (arg0 foo-for-keyword foo-for-string-or-utime)
  "same-* functions may accept a date string, utime or a keyword of names"
  (typecase arg0
    (keyword (keyword-to-integer (car (funcall foo-for-keyword arg0)))) 
    (t (funcall foo-for-string-or-utime arg0))))

;;
(defun same-month (arg0 arg1)
  (= (utility-for-same arg0 #'month-alias #'utime-month) 
     (utility-for-same arg1 #'month-alias #'utime-month)))

;;
(defun same-dow (arg0 arg1)
  (= (utility-for-same arg0 #'dow-alias #'utime-dow) 
     (utility-for-same arg1 #'dow-alias #'utime-dow)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defun month-alias (any)
  (or (find-if (lambda (li) (member any li)) *month-names*)
      (error "~a is not a valid representation for a month" any)))

;;
(defun dow-alias (any)
  (or (find-if (lambda (li) (member any  li)) *day-names*)
      (error "~a is not a valid representation for a day-of-week" any)))
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defun dow-range (any1 any2 &key (encode t))
  (let ((range (cyclic-range-2 (keyword-to-integer (car (dow-alias any1)))
			       (keyword-to-integer (car (dow-alias any2))) *day-names*)))
    (if encode
	(mapcar #'car range)
	range)))

;;
(defun month-range (any1 any2 &key (encode t))
  (let ((range (cyclic-range-2 (1-  (keyword-to-integer (car (month-alias any1))))
			       (1-  (keyword-to-integer (car (month-alias any2))))
			       *month-names*)))
    (if encode
	(mapcar #'car range)
	range)))

