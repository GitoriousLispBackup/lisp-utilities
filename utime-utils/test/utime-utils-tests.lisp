(in-package :utime-utils-tests)

(def-suite :utime-utils-test-suite)
(in-suite :utime-utils-test-suite)

(defparameter atime (encode-universal-time 1 2 3 4 5 2011 0))
(defparameter atime-string "2011.5.4 03:02:01")

;;
(test test-utime-from-string 
  (is (equal (encode-universal-time 33 2 11 21 6 2007 0)
	     (utime-from-string "2007.06.21 11:02:33")))
  (is (equal (encode-universal-time 0 2 11 21 6 2007 0)
	     (utime-from-string "2007.06.21 11:02")))
  (is (equal (encode-universal-time 0 0 11 21 6 2007 0)
	     (utime-from-string "2007.06.21 11")))
  (is (equal (encode-universal-time 0 0 0 21 6 2007 0)
	     (utime-from-string "2007.06.21")))
  (is (equal (encode-universal-time 0 0 0 1 6 2007 0)
	     (utime-from-string "2007.06")))
  (is (equal (encode-universal-time 0 0 0 1 1 2007 0)
	     (utime-from-string "2007"))))

;;
(test test-utime-to-string 
  (is (equal "2007.06.21 11:02:33"
	     (utime-to-string (encode-universal-time 33 2 11 21 6 2007 0))))
  (is (equal "2007.06.21 11:02:00"
	     (utime-to-string (encode-universal-time 0 2 11 21 6 2007 0))))
  (is (equal "2007.06.21 11:00:00"
	     (utime-to-string (encode-universal-time 0 0 11 21 6 2007 0))))
  (is (equal "2007.06.21 00:00:00"
	     (utime-to-string (encode-universal-time 0 0 0 21 6 2007 0))))
  (is (equal "2007.06.01 00:00:00"
	     (utime-to-string (encode-universal-time 0 0 0 1 6 2007 0))))
  (is (equal "2007.01.01 00:00:00"
	     (utime-to-string (encode-universal-time 0 0 0 1 1 2007 0)))))

;;
(test utime-part-1 
  (is (equal (utime-part atime :second) 1))
  (is (equal (utime-part atime :minute) 2))
  (is (equal (utime-part atime :hour) 3))
  (is (equal (utime-part atime :day) 4))
  (is (equal (utime-part atime :month) 5))
  (is (equal (utime-part atime :year) 2011))
  (is (equal (utime-part atime :day-of-week) 2)))

(test utime-part-2
  (is (equal (utime-part atime-string :second) 1))
  (is (equal (utime-part atime-string :minute) 2))
  (is (equal (utime-part atime-string :hour) 3))
  (is (equal (utime-part atime-string :day) 4))
  (is (equal (utime-part atime-string :month) 5))
  (is (equal (utime-part atime-string :year) 2011))
  (is (equal (utime-part atime-string :day-of-week) 2)))

;;
(test utime-part-shorthands-1 
  (is (equal (utime-part atime :second) (utime-second atime)))
  (is (equal (utime-part atime :minute) (utime-minute atime)))
  (is (equal (utime-part atime :hour) (utime-hour atime)))
  (is (equal (utime-part atime :day) (utime-day atime)))
  (is (equal (utime-part atime :month) (utime-month atime)))
  (is (equal (utime-part atime :year) (utime-year atime)))
  (is (equal (utime-part atime :day-of-week) (utime-dow atime))))

;;
(test utime-part-shorthands-2 
  (is (equal (utime-part atime-string :second) (utime-second atime-string)))
  (is (equal (utime-part atime-string :minute) (utime-minute atime-string)))
  (is (equal (utime-part atime-string :hour) (utime-hour atime-string)))
  (is (equal (utime-part atime-string :day) (utime-day atime-string)))
  (is (equal (utime-part atime-string :month) (utime-month atime-string)))
  (is (equal (utime-part atime-string :year) (utime-year atime-string)))
  (is (equal (utime-part atime-string :day-of-week) (utime-dow atime))))

;;
(test testing-utime-dow ()
      (is (equal 0 (utime-dow "2011.10.3"))) ;; monday == 0
      (is (equal 1 (utime-dow "2011.10.04")))
      (is (equal 1 (utime-dow "2011.10.4")))
      (is (equal 3 (utime-dow "2011.10.5 23:59:60"))))

;;
(test testing-utime-doy ()
      (is (equal 1 (utime-doy "2011.1.1")))
      (is (equal 4 (utime-doy "2011.1.04")))
      ;; 2011 => jan = 31 , feb = 28 , march = 31
      (is (equal (+ 31 1) (utime-doy "2011.2.1")))
      (is (equal (+ 31 28 31 5) (utime-doy "2011.4.5 12:23:12")))
      (is (equal (+ 31 28 31 6) (utime-doy "2011.4.5 23:59:60"))))

;;
(test testing-utime-merge-modifications
  (is (equal (utime-from-string "2000.3.1 14:13:11")
	     (utime-merge "2000.3.1 14:13:00" :second 11)))

  (is (equal (utime-from-string "2000.3.1 14:06:00")
	     (utime-merge "2000.3.1 14:00:00" :minute 6)))

  (is (equal (utime-from-string "2000.3.1 21:00:00")
	     (utime-merge "2000.3.1 00:00:00" :hour 21)))

  (is (equal (utime-from-string "2000.3.1 21:15:23")
	     (utime-merge "2000.3.1 01:10:05" :hour 21 :minute 15 :second 23)))

  (is (equal (utime-from-string "2000.3.1 21:15:23")
	     (utime-merge "2000.3.4 01:10:05" :day 1 :hour 21 :minute 15 :second 23)))

  (is (equal (utime-from-string "2012.11.1 21:15:23")
	     (utime-merge "2000.3.4 01:10:05" :year 2012 :month 11 :day 1 :hour 21 :minute 15 :second 23)))
)

;;
(test testing-utime-merge-increments
  (is (equal (utime-from-string "2007.8.9 10:11:13") 
	     (utime-merge  "2007.8.9 10:11:12" :second+ 1)))

  (is (equal (utime-from-string "2007.8.9 10:13:12") 
	     (utime-merge "2007.8.9 10:11:12" :minute+ 2)))
  
  (is (equal (utime-from-string "2007.8.9 7:11:12") 
	     (utime-merge "2007.8.9 10:11:12" :hour+ -3)))

  (is (equal (utime-from-string "2007.8.3 10:11:12") 
	     (utime-merge "2007.8.9 10:11:12" :day+ -6)))

  (is (equal (utime-from-string "2007.10.9 10:11:12") 
	     (utime-merge "2007.8.9 10:11:12" :month+ 2)))

  (is (equal (utime-from-string "2008.8.9 10:11:12") 
	     (utime-merge  "2007.8.9 10:11:12" :year+ 1)))
  
  (is (equal (utime-from-string "2008.6.4 10:11:12") 
	     (utime-merge "2007.8.9 10:11:12" :year+ 1 :month+ -2 :day 1 :day+ 3)))
)

;;
(test testing-utime-merge-limits

  (is (equal (utime-from-string "2000.1.1 0:1:6")
	     (utime-merge "2000.1.1 0:0:0" :second+ 66)))

  (is (equal (utime-from-string "2000.1.1 23:58")
	     (utime-merge "2000.1.2 0:0:0" :second+ -120)))

  (is (equal (utime-from-string "2000.1.1 1:6:0")
	     (utime-merge "2000.1.1 0:0:0" :minute+ 66)))

  (is (equal (utime-from-string "2000.1.1 22:00")
	     (utime-merge "2000.1.2 0:0:0" :minute+ -120)))

  (is (equal (utime-from-string "2000.1.2 12:0:0")
	     (utime-merge "2000.1.2 0:0:0" :hour+ 12)))

  (is (equal (utime-from-string "2000.1.1 12:0:0")
	     (utime-merge "2000.1.2 0:0:0" :hour+ -12)))

  (is (equal (utime-from-string "2000.2.2 0:0:0")
	     (utime-merge "2000.1.1 0:0:0" :day+ 32)))

  ;;(is (equal (utime-from-string "1999.1.2") (utime-merge "2000.1.2 0:0:0" :month+ -12))) ;; error month are not fully able counting backward

  (is (equal (utime-from-string "1999.11.30")
	     (utime-merge "2000.1.1" :day+ -32)))

  (is (equal (utime-from-string "1998.1.1")
	     (utime-merge "2000.1.1" :year+ -2)))

  (is (equal (utime-from-string "1998.3.4 22:01")
	     (utime-merge "2000.1.1" :year+ -2 :month+ 1 :day+ 32 :hour+ -2 :minute+ 1)))
)

;;
(test utime-generate.1
  ;; intervals
  (is (equal (mapcar #'utime-from-string (list "2000.1.1 0:0:0"  
					       "2000.1.1 0:0:1"))
	     (utime-generate  "2000.1.1" :second* 2)))

  (is (equal (mapcar #'utime-from-string (list  "2000.1.1 0:0:0"
						"2000.1.1 0:0:5"
						"2000.1.1 0:0:10")) 
	     (utime-generate  "2000.1.1" :second+ 5 :second* 3)))

  (is (equal (mapcar #'utime-from-string (list  "2000.1.1 0:0:0" 
						"2000.1.1 0:0:1"
						"2000.1.1 0:1:0"  
						"2000.1.1 0:1:1"))
	     (utime-generate  "2000.1.1"  :second* 2 :minute* 2)))

  (is (equal (mapcar #'utime-from-string (list  "2000.1.1 0:0:0"  
						"2000.1.1 0:1:0"
						"2000.1.1 1:0:0"  
						"2000.1.1 1:1:0"
						"2000.1.1 2:0:0" 
						"2000.1.1 2:1:0"))
		   
	     (utime-generate  "2000.1.1" :second* 1 :minute* 2  :hour* 3)))

  (is (equal (mapcar #'utime-from-string (list  "2000.1.1 0:0:0"  
						"2000.1.1 0:0:1"
						"2000.1.1 0:1:0"
						"2000.1.1 0:1:1"
						"2000.1.1 1:0:0"  
						"2000.1.1 1:0:1"
						"2000.1.1 1:1:0"  
						"2000.1.1 1:1:1"
						"2000.1.2 0:0:0"  
						"2000.1.2 0:0:1"
						"2000.1.2 0:1:0"  
						"2000.1.2 0:1:1"
						"2000.1.2 1:0:0"  
						"2000.1.2 1:0:1"
						"2000.1.2 1:1:0"  
						"2000.1.2 1:1:1"))
	     (utime-generate  "2000.1.1" :minute* 2 :second* 2 :hour* 2 :day* 2))))


(test testing-first-monday-of-year ()
      (let ((moment (first-monday-of-year "2011.7.15")))
	(is (same-dow :monday (utime-dow moment)))
	(is (equal 2011 (utime-year moment)))
	(is (equal 1 (utime-month moment)))
	(is (<= (utime-day moment) 7))))

(test testing-first-monday-of-month ()
      (let ((moment (first-monday-of-month "2011.7.15")))
	(is (same-dow :monday (utime-dow moment)))
	(is (equal 2011 (utime-year moment)))
	(is (<= (utime-day moment) 7))))