(in-package :forex-data-format)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; candles from tick stream, no buffering no conses.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(defun ticks-to-candles (seconds &key (price #'bid))
  (declare (optimize (debug 3)))
  (let (opening-price high-price low-price ask-vol bid-vol prev-tick tick-count)
    (labels (
	     (start-new-period (tick)
	       ;;(format t "starting ~t~a~%" (and tick (utime-to-string (utime tick))))                    ;;debug
	       (prog1
		   (close-previous-period)
		 (let ((p (funcall price tick)))
		   (setq opening-price p 
			 high-price p 
			 low-price p 
			 ask-vol (ask-vol tick) 
			 bid-vol (bid-vol tick)
			 tick-count 1))))

	     (feed-the-candle (tick)
	       ;;(format t "starting ~a~%" (utime-to-string (utime tick)))                                  ;;debug
	       (let ((p (funcall price tick)))
		 (when (> p high-price) (setq high-price p))
		 (when (< p low-price)  (setq low-price p))
		 (incf ask-vol (ask-vol tick))
		 (incf bid-vol (bid-vol tick))
		 (incf tick-count)
		 :more))

	     (close-previous-period ()
	       ;;(format t "closing  ~t~a~%~%" (and prev-tick (utime-to-string (utime prev-tick))))         ;;debug 
	       (if opening-price                                                                            ;; closing previous period if exists.
		   (values (make-candle (+ (utime prev-tick) 
					   (- seconds (mod (utime prev-tick) seconds)))                     ;; previous tick was inside prev period. 
					opening-price 
					high-price 
					low-price 
					(funcall price prev-tick) 
					ask-vol 
					bid-vol) tick-count)
		   :more)))
		     
    (lambda (tick)
      (prog1 
	  (cond 
	    ((start-of-period-p tick prev-tick seconds)
	     (start-new-period tick))
	    (opening-price
	     (feed-the-candle tick))
	    (t :more))
	(setq prev-tick tick))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helpers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(declaim (inline first-tick-p))

;;
(defun start-of-period-p (tick prev-tick seconds)
  (if prev-tick
     (and 
      (/= (utime prev-tick) (utime tick))                                  ;; same utime, previous already inluded or not eligable ...
      (or
       (< (mod (utime tick) seconds) (mod (utime prev-tick) seconds))      ;; we passed beginning (mod zero) of the candle interval.
       (>= (- (utime tick) (utime prev-tick)) seconds)))                   ;; we passed range of interval.
     (zerop (mod (utime tick) seconds))))                                  ;; exact start values for interval
