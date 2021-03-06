(in-package :forex-data-format-tests)

(def-suite :ticks-to-candles-test-suite)
(in-suite  :ticks-to-candles-test-suite)

;;
(defun make-a-candle (utime-string ticks)
  (make-candle (utime-from-string utime-string)
	       (bid (first ticks))
	       (reduce #'max ticks :key #'bid)
	       (reduce #'min ticks :key #'bid)
	       (bid (car (last ticks)))
	       (reduce #'+ ticks :key #'ask-vol)
	       (reduce #'+ ticks :key #'bid-vol)))

;;
(test ticks-to-candles-2-mins 
  (let* ((ttc (ticks-to-candles 120))
	 (candles (remove :more (mapcar ttc *sample-tick-data-utime*))))
    (is (equalp candles nil))))

;;
(test ticks-to-candles-1-min 
  (let* ((ttc (ticks-to-candles 60))
	 (candles (remove :more (mapcar ttc *sample-tick-data-utime*)))
	 (ticks-for-5 '(#("2010.01.03 22:05:00"	1.43025	1.4299	4	1.2)
			 #("2010.01.03 22:05:10"	1.4303	1.4299	4	1.2)
			 #("2010.01.03 22:05:13"	1.4304	1.4299	10.8	5.2)
			 #("2010.01.03 22:05:55"	1.43035	1.4299	1.2	5.2)))
	 (ticks-for-6 '(#("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
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
			 #("2010.01.03 22:06:57"	1.43035	1.43	1	1  ))))
    
    (is (equalp (first candles) (make-a-candle "2010.01.03 22:06:00" ticks-for-5)))
    (is (equalp (car (last candles)) (make-a-candle "2010.01.03 22:07:00" ticks-for-6)))))

;;
(test ticks-to-candles-30-secs 
  (let* ((ttc (ticks-to-candles 30))
	 (candles (remove :more (mapcar ttc *sample-tick-data-utime*)))
	 (ticks-for-4.30 '(#("2010.01.03 22:04:30"	1.4302	1.4299	2.5	1.3)
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
			   #("2010.01.03 22:04:59"	1.4303	1.4299	3.2	1.2)))

	 (ticks-for-5.00 '(#("2010.01.03 22:05:00"	1.43025	1.4299	4	1.2)
			   #("2010.01.03 22:05:10"	1.4303	1.4299	4	1.2)
			   #("2010.01.03 22:05:13"	1.4304	1.4299	10.8	5.2)))

	 (ticks-for-5.30 '(#("2010.01.03 22:05:55"	1.43035	1.4299	1.2	5.2)))
	 
	 (ticks-for-6.00 '(#("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
			   #("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
			   #("2010.01.03 22:06:24"	1.4303	1.4299	2.4	1.2)
			   #("2010.01.03 22:06:25"	1.43035	1.4299	5.2	1.2)))

	 (ticks-for-6.30 '(#("2010.01.03 22:06:37"	1.4303	1.4299	4	2  )
			   #("2010.01.03 22:06:37"	1.43035	1.43	4.8	1.2)
			   #("2010.01.03 22:06:37"	1.4304	1.43	6.4	1.2)
			   #("2010.01.03 22:06:38"	1.4304	1.43	6.4	1.2)
			   #("2010.01.03 22:06:51"	1.4302	1.43	3	1.2)
			   #("2010.01.03 22:06:51"	1.43025	1.43	1	1.2)
			   #("2010.01.03 22:06:51"	1.4305	1.43	6.4	1  )
			   #("2010.01.03 22:06:54"	1.4304	1.43	6.6	1  )
			   #("2010.01.03 22:06:54"	1.4304	1.43	6.4	1  )
			   #("2010.01.03 22:06:55"	1.43035	1.43	1	1  )
			   #("2010.01.03 22:06:57"	1.43035	1.43	1	1  )))
	 
	 (ticks-for-7.00 '(#("2010.01.03 22:07:08"	1.43035	1.43	1	1.2)
			   #("2010.01.03 22:07:12"	1.43035	1.43	1	1  )
			   #("2010.01.03 22:07:14"	1.43035	1.43	1	1.2)
			   #("2010.01.03 22:07:16"	1.43035	1.43	1	1.6)
			   #("2010.01.03 22:07:18"	1.43035	1.43	1	1.2)
			   #("2010.01.03 22:07:23"	1.43035	1.43	1	1.2))))
    
    (is (equalp (first candles)  (make-a-candle "2010.01.03 22:05:00" ticks-for-4.30)))
    (is (equalp (second candles) (make-a-candle "2010.01.03 22:05:30" ticks-for-5.00)))
    (is (equalp (third candles)  (make-a-candle "2010.01.03 22:06:00" ticks-for-5.30)))
    (is (equalp (fourth candles) (make-a-candle "2010.01.03 22:06:30" ticks-for-6.00)))
    (is (equalp (fifth candles)  (make-a-candle "2010.01.03 22:07:00" ticks-for-6.30)))
    (is (equalp (car (last candles))  (make-a-candle "2010.01.03 22:07:30" ticks-for-7.00)))))

;;
(test ticks-to-candles-15-secs 
  (let* ((ttc (ticks-to-candles 15))
	 (candles (remove :more (mapcar ttc *sample-tick-data-utime*)))

	 (ticks-for-4.30 '(#("2010.01.03 22:04:30"	1.4302	1.4299	2.5	1.3)
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
			   #("2010.01.03 22:04:40"	1.4301	1.4297	4	1.2)))

	 (ticks-for-4.45 '(#("2010.01.03 22:04:47"	1.4303	1.42965	4	4  )
			   #("2010.01.03 22:04:51"	1.4303	1.42965	7.6	5.2)
			   #("2010.01.03 22:04:55"	1.43025	1.4298	5.2	4  )
			   #("2010.01.03 22:04:56"	1.4303	1.42985	4	1.2)
			   #("2010.01.03 22:04:58"	1.4303	1.4299	1.6	1.2)
			   #("2010.01.03 22:04:59"	1.4303	1.4299	3.2	1.2)))
	 
	 (ticks-for-5.00 '(#("2010.01.03 22:05:00"	1.43025	1.4299	4	1.2)
			   #("2010.01.03 22:05:10"	1.4303	1.4299	4	1.2)
			   #("2010.01.03 22:05:13"	1.4304	1.4299	10.8	5.2)))
	 
	 (ticks-for-5.45 '(#("2010.01.03 22:05:55"	1.43035	1.4299	1.2	5.2)))

	 (ticks-for-6.15 '(#("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
			   #("2010.01.03 22:06:21"	1.43035	1.4299	1.2	5.2)
			   #("2010.01.03 22:06:24"	1.4303	1.4299	2.4	1.2)
			   #("2010.01.03 22:06:25"	1.43035	1.4299	5.2	1.2)))

	 (ticks-for-6.30 '(#("2010.01.03 22:06:37"	1.4303	1.4299	4	2  )
			   #("2010.01.03 22:06:37"	1.43035	1.43	4.8	1.2)
			   #("2010.01.03 22:06:37"	1.4304	1.43	6.4	1.2)
			   #("2010.01.03 22:06:38"	1.4304	1.43	6.4	1.2)))

	 (ticks-for-6.45 '(#("2010.01.03 22:06:51"	1.4302	1.43	3	1.2)
			   #("2010.01.03 22:06:51"	1.43025	1.43	1	1.2)
			   #("2010.01.03 22:06:51"	1.4305	1.43	6.4	1  )
			   #("2010.01.03 22:06:54"	1.4304	1.43	6.6	1  )
			   #("2010.01.03 22:06:54"	1.4304	1.43	6.4	1  )
			   #("2010.01.03 22:06:55"	1.43035	1.43	1	1  )
			   #("2010.01.03 22:06:57"	1.43035	1.43	1	1  )))

	 (ticks-for-7.00 '(#("2010.01.03 22:07:08"	1.43035	1.43	1	1.2)
			   #("2010.01.03 22:07:12"	1.43035	1.43	1	1  )
			   #("2010.01.03 22:07:14"	1.43035	1.43	1	1.2)))
	 
	 (ticks-for-7.15 '(#("2010.01.03 22:07:16"	1.43035	1.43	1	1.6)
			   #("2010.01.03 22:07:18"	1.43035	1.43	1	1.2)
			   #("2010.01.03 22:07:23"	1.43035	1.43	1	1.2))))

    
    (is (equalp (nth 0 candles) (make-a-candle "2010.01.03 22:04:45" ticks-for-4.30)))
    (is (equalp (nth 1 candles) (make-a-candle "2010.01.03 22:05:00" ticks-for-4.45)))
    (is (equalp (nth 2 candles) (make-a-candle "2010.01.03 22:05:15" ticks-for-5.00)))
    (is (equalp (nth 3 candles) (make-a-candle "2010.01.03 22:06:00" ticks-for-5.45)))
    (is (equalp (nth 4 candles) (make-a-candle "2010.01.03 22:06:30" ticks-for-6.15)))
    (is (equalp (nth 5 candles) (make-a-candle "2010.01.03 22:06:45" ticks-for-6.30)))
    (is (equalp (nth 6 candles) (make-a-candle "2010.01.03 22:07:00" ticks-for-6.45)))
    (is (equalp (nth 7 candles) (make-a-candle "2010.01.03 22:07:15" ticks-for-7.00)))
    (is (equalp (car (last candles)) (make-a-candle "2010.01.03 22:07:30" ticks-for-7.15)))))