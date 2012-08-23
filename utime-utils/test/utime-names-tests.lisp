(in-package :utime-utils-tests)

(def-suite :utime-names-test-suite)
(in-suite :utime-names-test-suite)

;;
(test testing-day-of-week-equal
  (is-true (same-dow (utime-dow "2011.12.5") :monday))
  (is-true (same-dow :tuesday (utime-dow "2011.12.6")))
  (is-true (same-dow (utime-dow "2011.12.7") :wednesday))

  (is-true (same-dow (utime-dow "2011.12.8") :thursday))
  (is-true (same-dow :friday (utime-dow "2011.12.9")))
  (is-true (same-dow (utime-dow "2011.12.16") (utime-dow "2011.12.9")))
  (is-true (same-dow (utime-dow "2011.12.10") :saturday))

  (is-true (same-dow (utime-dow "2011.12.11") :sunday))
  (is-true (same-dow :mon :monday))
  (is-true (same-dow :pazartesi :mon)))

;;
(test testing-same-month
  (is-true (same-month (utime-month "2012.06.11") (utime-month "1984.6.20")))
  (is-true (same-month (utime-month "2012.06.11") :june))
  (is-true (same-month :jan 1))
  (is-true (same-month :jan 1))
  (is-true (same-month :january :jan))
  (is-true (same-month :ocak :jan))
  (is-true (same-month :sep :sept)))

;;
(test testing-month-alias
  (is (equal
       (elt *month-names* 0)
       (month-alias :jan)))
  (is (equal
       (elt *month-names* 0)
       (month-alias 1)))
  (is (equal
       (elt *month-names* 0)
       (month-alias :OCAK)))

  (is (equal
       (elt *month-names* 11)
       (month-alias :dec)))
  (is (equal
       (elt *month-names* 11)
       (month-alias 12)))
  (is (equal
       (elt *month-names* 11)
       (month-alias :ARALIK))))

;;
(test testing-dow-alias
  (is (equal
       (elt *day-names* 0)
       (dow-alias :monday)))
  (is (equal
       (elt *day-names* 0)
       (dow-alias 0)))
  (is (equal
       (elt *day-names* 0)
       (dow-alias :PAZARTESI)))

  (is (equal
       (elt *day-names* 6)
       (dow-alias :sunday)))
  (is (equal
       (elt *day-names* 6)
       (dow-alias 6)))
  (is (equal
       (elt *day-names* 6)
       (dow-alias :PAZAR))))

;;
(test testing-month-range
  (is (equal
       (list :may :june :july)
       (mapcar #'second (month-range :may :july :encode nil))))
  
  (is (equal
       (list 4 5 6 7 8 9 10 11 12 1 2 3)
       (month-range 4 3)))
  
  (is (equal 
       (list 4)
       (month-range 4 4))))

;;
(test testing-day-of-week-range
  (is (equal
       (list :SUNDAY :MONDAY :TUESDAY)
       (mapcar #'second (dow-range :SUNDAY :TUESDAY :encode nil))))
  
  (is (equal
       (list 4 5 6 0 1 2 3)
       (dow-range 4 3)))
  
  (is (equal
       (list 4)
       (dow-range 4 4))))

;;
(test test-first-monday
      (let ((first-monday (first-monday-of-year "2012")))
	(is-true (same-dow  (utime-dow first-monday) :monday))
	(is-true (< (utime-day first-monday) 7))))
	
