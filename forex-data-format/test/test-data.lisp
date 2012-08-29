(in-package :forex-data-format-tests)

;;
(defun convert-ticks-string-to-utime (li)
  (mapcar (lambda (l) (setf (utime l) (utime-from-string (utime l))) l) (mapcar #'copy-seq li)))
;;
(defun convert-ticks-utime-to-string (li)
  (mapcar (lambda (l) (setf (utime l) (utime-to-string (svref l 0))) l) (mapcar #'copy-seq li)))

;;
(defun all-first-ticks (seconds ticks)
  (loop for tick in ticks and previous-tick in (cons nil ticks)
       when (forex-data-format::start-of-period-p tick previous-tick  seconds) collect tick))

;;
(defparameter *sample-tick-data-string* '(#("2010.01.03 22:04:20"     1.43025 1.4299	7.5	1.3)
					  #("2010.01.03 22:04:30"	1.4302	1.4299	2.5	1.3)
					  #("2010.01.03 22:04:30"	1.4302	1.42985	7.3	6.4)
					  #("2010.01.03 22:04:31"	1.4302	1.42985	7.3	1.2)
					  #("2010.01.03 22:04:31"	1.4302	1.42985	8.8	1.2)
					  #("2010.01.03 22:04:31"	1.4302	1.42985	8.8	1.2)
					  #("2010.01.03 22:04:31"	1.4301	1.4298	4.9	1.2)
					  #("2010.01.03 22:04:31"	1.4301	1.42975	5.7	1.2)
					  #("2010.01.03 22:04:31"	1.43015	1.42975	9.6	1  )
					  #("2010.01.03 22:04:32"	1.43005	1.42965	4.8	1.2)
					  #("2010.01.03 22:04:33"	1.43005	1.4297	4	1.2)
					  #("2010.01.03 22:04:33"	1.43005	1.4297	4	1.2)
					  #("2010.01.03 22:04:34"	1.43005	1.4297	3.2	1.2)
					  #("2010.01.03 22:04:34"	1.4301	1.4297	3.2	5.2)
					  #("2010.01.03 22:04:34"	1.4301	1.42975	3.2	1.2)
					  #("2010.01.03 22:04:35"	1.4301	1.42975	4	1.2)
					  #("2010.01.03 22:04:40"	1.43005	1.42975	4	1.2)
					  #("2010.01.03 22:04:40"	1.4301	1.4297	4	1.2)
					  #("2010.01.03 22:04:47"	1.4303	1.42965	4	4  )
					  #("2010.01.03 22:04:51"	1.4303	1.42965	7.6	5.2)
					  #("2010.01.03 22:04:55"	1.43025	1.4298	5.2	4  )
					  #("2010.01.03 22:04:56"	1.4303	1.42985	4	1.2)
					  #("2010.01.03 22:04:58"	1.4303	1.4299	1.6	1.2)
					  #("2010.01.03 22:04:59"	1.4303	1.4299	3.2	1.2)
					  #("2010.01.03 22:05:00"	1.43025	1.4299	4	1.2)
					  #("2010.01.03 22:05:10"	1.4303	1.4299	4	1.2)
					  #("2010.01.03 22:05:13"	1.4304	1.4299	10.8	5.2)
					  #("2010.01.03 22:05:55"	1.43035	1.4299	1.2	5.2)
					  #("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
					  #("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
					  #("2010.01.03 22:06:24"	1.4303	1.4299	2.4	1.2)
					  #("2010.01.03 22:06:25"	1.43035	1.4299	5.2	1.2)
					  #("2010.01.03 22:06:37"	1.4303	1.4299	4	2  )
					  #("2010.01.03 22:06:37"	1.43035	1.43	4.8	1.2)
					  #("2010.01.03 22:06:37"	1.4304	1.43	6.4	1.2)
					  #("2010.01.03 22:06:38"	1.4304	1.43	6.4	1.2)
					  #("2010.01.03 22:06:51"	1.4302	1.43	3	1.2)
					  #("2010.01.03 22:06:51"	1.43025	1.43	1	1.2)
					  #("2010.01.03 22:06:51"	1.4305	1.43	6.4	1  )
					  #("2010.01.03 22:06:54"	1.4304	1.43	6.6	1  )
					  #("2010.01.03 22:06:54"	1.4304	1.43	6.4	1  )
					  #("2010.01.03 22:06:55"	1.43035	1.43	1	1  )
					  #("2010.01.03 22:06:57"	1.43035	1.43	1	1  )
					  #("2010.01.03 22:07:08"	1.43035	1.43	1	1.2)
					  #("2010.01.03 22:07:12"	1.43035	1.43	1	1  )
					  #("2010.01.03 22:07:14"	1.43035	1.43	1	1.2)
					  #("2010.01.03 22:07:16"	1.43035	1.43	1	1.6)
					  #("2010.01.03 22:07:18"	1.43035	1.43	1	1.2)
					  #("2010.01.03 22:07:23"	1.43035	1.43	1	1.2)
					  #("2010.01.03 22:07:44"	1.43035	1.43	1	1.2)))

;;
(defparameter *sample-tick-data-utime* (convert-ticks-string-to-utime *sample-tick-data-string*))
