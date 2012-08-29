(in-package :forex-data-format-tests)

(def-suite :forex-data-format-test-suite)
(in-suite :forex-data-format-test-suite)

;;
(defparameter *tick* (make-tick 2257596792 11 22 33 44))
(defparameter *candle* (make-candle 2257596793 12 23 34 45 56 67))

;;
(test tick-read
  (is (equal (utime *tick*) 2257596792))
  (is (equal (ask *tick*) 11))  
  (is (equal (bid *tick*) 22))
  (is (equal (ask-vol *tick*) 33))
  (is (equal (bid-vol *tick*) 44)))

;;
(test tick-setf
  (let ((*tick* (copy-seq *tick*)))
    (setf (utime *tick*) 1111)
    (is (equal (utime *tick*) 1111))
    
    (setf (ask *tick*) 2222)
    (is (equal (ask *tick*) 2222))

    (setf (bid *tick*) 3333)
    (is (equal (bid *tick*) 3333))

    (setf (ask-vol *tick*) 4444)
    (is (equal (ask-vol *tick*) 4444))

    (setf (bid-vol *tick*) 5555)
    (is (equal (bid-vol *tick*) 5555))))

;;
(test tick-utime-tests
  (is (equal (utime-second *tick*) (utime-second (utime *tick*))))
  (is (equal (utime-minute *tick*) (utime-minute (utime *tick*))))
  (is (equal (utime-hour *tick*) (utime-hour (utime *tick*))))
  (is (equal (utime-day *tick*) (utime-day (utime *tick*))))
  (is (equal (utime-month *tick*) (utime-month (utime *tick*))))
  (is (equal (utime-year *tick*) (utime-year (utime *tick*))))
  (is (equal (utime-dow *tick*) (utime-dow (utime *tick*)))))

;;
(test candle-read-tests
  (is (equal (utime *candle*) 2257596793))
  (is (equal (opening-price *candle*) 12))
  (is (equal (high-price *candle*) 23))
  (is (equal (low-price *candle*) 34))
  (is (equal (closing-price *candle*) 45))
  (is (equal (ask-vol *candle*) 56))
  (is (equal (bid-vol *candle*) 67)))
  
;;
(test candle-write-tests
  (let ((*candle* (copy-seq *candle*)))
    (setf (utime *candle*) 11111)
    (is (equal (utime *candle*) 11111))

    (setf (opening-price *candle*) 22222)
    (is (equal (opening-price *candle*) 22222))

    (setf (high-price *candle*) 33333)
    (is (equal (high-price *candle*) 33333))

    (setf (low-price *candle*) 44444)
    (is (equal (low-price *candle*) 44444))

    (setf (closing-price *candle*) 55555)
    (is (equal (closing-price *candle*) 55555))

    (setf (ask-vol *candle*) 66666)
    (is (equal (ask-vol *candle*) 66666))
    
    (setf (bid-vol *candle*) 66666)
    (is (equal (bid-vol *candle*) 66666))))
 
;;
(test candle-utime-tests
  (is (equal (utime-second *candle*) (utime-second (utime *candle*))))
  (is (equal (utime-minute *candle*) (utime-minute (utime *candle*))))
  (is (equal (utime-hour *candle*) (utime-hour (utime *candle*))))
  (is (equal (utime-day *candle*) (utime-day (utime *candle*))))
  (is (equal (utime-month *candle*) (utime-month (utime *candle*))))
  (is (equal (utime-year *candle*) (utime-year (utime *candle*))))
  (is (equal (utime-dow *candle*) (utime-dow (utime *candle*)))))
