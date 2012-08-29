(in-package :forex-data-format-tests)

(def-suite :ticks-to-candles-test-suite)
(in-suite  :ticks-to-candles-test-suite)

;;
(test start-of-period-2-minutes
  (is (equalp (convert-ticks-utime-to-string (all-first-ticks 120 *sample-tick-data-utime*))
		  '(#("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)))))

;;
(test start-of-period-1-minute
  (is (equalp (convert-ticks-utime-to-string (all-first-ticks 60 *sample-tick-data-utime*))
		  '(#("2010.01.03 22:05:00"	1.43025	1.4299	4	1.2)
		    #("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
		    #("2010.01.03 22:07:08"	1.43035	1.43	1	1.2)))))

;;
(test start-of-period-45-seconds
  (is (equalp (convert-ticks-utime-to-string (all-first-ticks 45 *sample-tick-data-utime*))
	      '(
		#("2010.01.03 22:04:30"	1.4302	1.4299	2.5	1.3)
		#("2010.01.03 22:05:55"	1.43035	1.4299	1.2	5.2)
		#("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
		#("2010.01.03 22:06:51"	1.4302	1.43	3	1.2)
		#("2010.01.03 22:07:44"	1.43035	1.43	1	1.2)))))

;;
(test start-of-period-30-seconds
  (is (equalp (convert-ticks-utime-to-string (all-first-ticks 30 *sample-tick-data-utime*))
		  '(#("2010.01.03 22:04:30"	1.4302	1.4299	2.5	1.3)
		    #("2010.01.03 22:05:00"	1.43025	1.4299	4	1.2)
		    #("2010.01.03 22:05:55"	1.43035	1.4299	1.2	5.2)
		    #("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
		    #("2010.01.03 22:06:37"	1.4303	1.4299	4	2  )
		    #("2010.01.03 22:07:08"	1.43035	1.43	1	1.2)
		    #("2010.01.03 22:07:44"	1.43035	1.43	1	1.2)))))

;;
(test start-of-period-15-seconds
  (is (equalp (convert-ticks-utime-to-string (all-first-ticks 15 *sample-tick-data-utime*))
	      '(
		#("2010.01.03 22:04:30"	1.4302	1.4299	2.5	1.3)
		#("2010.01.03 22:04:47"	1.4303	1.42965	4	4  )
		#("2010.01.03 22:05:00"	1.43025	1.4299	4	1.2)
		#("2010.01.03 22:05:55"	1.43035	1.4299	1.2	5.2)
		#("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
		#("2010.01.03 22:06:37"	1.4303	1.4299	4	2  )
		#("2010.01.03 22:06:51"	1.4302	1.43	3	1.2)
		#("2010.01.03 22:07:08"	1.43035	1.43	1	1.2)
		#("2010.01.03 22:07:16"	1.43035	1.43	1	1.6)
		#("2010.01.03 22:07:44"	1.43035	1.43	1	1.2))
)))

;;
(test start-of-period-1-seconds
  (is (equalp (convert-ticks-utime-to-string (all-first-ticks 1 *sample-tick-data-utime*))
	      (remove-duplicates *sample-tick-data-string* :key #'utime :test #'equalp :from-end t))))