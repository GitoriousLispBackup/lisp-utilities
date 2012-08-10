(in-package :utime-utils)

(declaim (inline utime-second utime-minute utime-hour utime-day utime-month utime-year utime-dow))

(defparameter *default-timezone* 0)

;; time string format examples :  "2009.10.12 12:30" , "2009.10.12 12" , "2009.10.12" , "2009.10" , "2009"
(defun utime-from-string (datetime-string &optional (timezone *default-timezone*))
  (flet ((g (data default)
	     (if data
		 (read-from-string data)
		 default)))
    (let* (year month day hour minute second 
		(main-fields (cl-ppcre:split "\\s+" datetime-string))
		(d1 (split "\\." (first main-fields)))
		(d2 (split "\\:" (second main-fields))))
      (if (setq year (g (pop d1) nil))
	  (progn (setq month (g (pop d1) 1))
		 (setq day (g (pop d1) 1))
		 (setq hour (g (pop d2) 0))
		 (setq minute (g (pop d2) 0))
		 (setq second (g (pop d2) 0)))
	  (error "at least year info should be given"))
      (encode-universal-time second minute hour day month year timezone))))
		  
;;
(defmethod utime-to-string (universaltime &optional (timezone *default-timezone*))
  (multiple-value-bind (second minute hour day month year) 
      (decode-universal-time universaltime timezone) 
    (format nil "~4,'0D.~2,'0D.~2,'0D ~2,'0D:~2,'0D:~2,'0D" year month day hour minute second)))

;;
(defgeneric utime-part (data part))
  
;;
(defmethod utime-part ((utime number) part)
  (multiple-value-bind (second minute hour day month year day-of-week) 
      (decode-universal-time utime *default-timezone*)  
    (ecase part 
      (:second  second)
      (:minute  minute)
      (:hour  hour)
      (:day  day)
      (:month  month)
      (:year  year)
      ((:day-of-week  :dow) day-of-week)
      ((:doy :day-of-year) (utime-doy utime)))))


;;
(defmethod utime-part ((time-string string) part)
  (let ((utime (utime-from-string time-string)))
    (utime-part utime part)))

;;
(defun utime-second (utime) (utime-part utime :second))

;;
(defun utime-minute (utime) (utime-part utime :minute))

;;
(defun utime-hour (utime) (utime-part utime :hour))

;;
(defun utime-day (utime) (utime-part utime :day))

;;
(defun utime-month (utime) (utime-part utime :month))

;;
(defun utime-year (utime) (utime-part utime :year))

;;
(defun utime-dow (utime) (utime-part utime :dow))

;;
(defgeneric utime-doy (utime))

;;
(defmethod utime-doy ((utime number))
  ;; day of the year
  (1+ (truncate (- utime (start-of-year utime))
		86400)))

;;
(defmethod utime-doy ((utime-string string))
  (let ((utime (utime-from-string utime-string)))
    (utime-doy utime)))

;;
(defgeneric utime-merge (defaults &key year month day hour minute second 
		year+ month+ day+ hour+ minute+ second+))

;;
(defmethod utime-merge ((defaults number) &key year month day hour minute second 
		year+ month+ day+ hour+ minute+ second+)
  (multiple-value-bind (second-d minute-d hour-d day-d month-d year-d) (decode-universal-time defaults 0)
    (encode-universal-time 
     (+ (or second second-d) (or second+ 0))
     (+ (or minute minute-d) (or minute+ 0))
     (+ (or hour hour-d) (or hour+ 0))
     (+ (or day day-d) (or day+ 0))
     (+ (or month month-d) (or month+ 0))
     (+ (or year year-d)  (or year+ 0))
     0)))

;;
(defmethod utime-merge ((defaults-string string) &key year month day hour minute second 
		year+ month+ day+ hour+ minute+ second+)
  (let ((defaults (utime-from-string defaults-string)))
    (utime-merge defaults :year year :month month :day day :hour hour :minute minute :second second 
		:year+ year+ :month+ month+ :day+ day+ :hour+ hour+ :minute+ minute+ :second+ second+)))


;;
(defgeneric utime-generate (defaults &key 
			       year+  month+  day+  hour+  minute+  second+ 
			       year*  month*  day*  hour*  minute*  second*))


;;
(defmethod utime-generate ((defaults number) &key 
			   (year+ 1) (month+ 1) (day+ 1) (hour+ 1) (minute+ 1) (second+ 1)
			   (year* 1) (month* 1) (day* 1) (hour* 1) (minute* 1) (second* 1))
  
  (multiple-value-bind (second minute hour day month year)
      (decode-universal-time defaults *default-timezone*)
    (flatten
     (loop for y from 0 to (1- year*)
	collect (loop for m from 0 to (1- month*)
		   collect (loop for d from 0 to (1- day*)
			      collect (loop for ho from 0 to (1- hour*)
					 collect (loop for mi from 0 to (1- minute*)
						    collect (loop for se from 0 to (1- second*)
							       collect (encode-universal-time 
									(+ second (* se second+))
									(+ minute (* mi minute+))
									(+ hour (* ho hour+))
									(+ day (* d day+))
									(+ month (* m month+))
									(+ year (* y year+)) *default-timezone*))))))))))

;;
(defmethod utime-generate ((defaults-string string) &key 
			   (year+ 1) (month+ 1) (day+ 1) (hour+ 1) (minute+ 1) (second+ 1)
			   (year* 1) (month* 1) (day* 1) (hour* 1) (minute* 1) (second* 1))
  (let ((defaults (utime-from-string defaults-string)))
    (utime-generate defaults :year+ year+  :month+ month+  :day+ day+  :hour+ hour+  :minute+ minute+  :second+ second+ 
		    :year* year*  :month* month*  :day* day*  :hour* hour*  :minute* minute*  :second* second*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defun start-of-day (utime) (utime-merge utime :hour 0 :minute 0 :second 0))

;;
(defun start-of-month (utime) (utime-merge utime :day 1 :hour 0 :minute 0 :second 0))

;;
(defun start-of-year (utime) (utime-merge utime :month 1 :day 1 :hour 0 :minute 0 :second 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defgeneric first-monday-of-month (utime))

;;
(defmethod first-monday-of-month ((utime number))
  (let ((start (start-of-month utime)))
    (+ start (* (mod (- (utime-dow start)) 7) 86400))))

;;
(defmethod first-monday-of-month ((utime-string string))
  (let ((utime (utime-from-string utime-string)))
    (first-monday-of-month utime)))

;;
(defgeneric first-monday-of-year (utime))

;;
(defmethod first-monday-of-year ((utime number))
  (let ((start (start-of-year utime)))
    (+ start (* (* (mod (- (utime-dow start)) 7) 86400)))))

;;
(defmethod first-monday-of-year ((utime-string string))
  (let ((utime (utime-from-string utime-string)))
    (first-monday-of-year utime)))
