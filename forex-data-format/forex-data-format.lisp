(in-package :forex-data-format)

;; vectors are giving the best performance, and lowest memory consumption.
;; this is required for processing (and keeping data in memory for further processing) huge amount of tick data.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tick : utime, ask, bid, ask-vol, bid-vol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(declaim (inline utime ask bid ask-vol bid-vol))

;;
(defmethod utime-part((tick-or-candle vector) part)
  (utime-part (utime tick-or-candle) part))


;; first cell utime
(defun utime (tick-or-candle) (svref tick-or-candle 0))
;;
(defun (setf utime) (val tick) (setf (svref tick 0) val))

;; second cell ask value
(defun ask (tick) (svref tick 1))
;;
(defun (setf ask) (val tick) (setf (svref tick 1) val))

;; third cell bid value
(defun bid (tick) (svref tick 2))
;;
(defun (setf bid) (val tick) (setf (svref tick 2) val))

;; before last cell ask-volume
(defun ask-vol (tick-or-candle) 
  (svref tick-or-candle (- (length tick-or-candle) 2)))
;;
(defun (setf ask-vol) (val tick-or-candle) (setf (svref tick-or-candle (- (length tick-or-candle) 2)) val))

;; last cell bid-volume
(defun bid-vol (tick-or-candle) 
  (svref tick-or-candle (- (length tick-or-candle) 1)))
;;
(defun (setf bid-vol) (val tick-or-candle) (setf (svref tick-or-candle (- (length tick-or-candle) 1)) val))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; candle :  utime (close-time), open, high, low, close, ask-vol, bid-vol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(declaim (inline opening-price high-price low-price closing-price))

;;
(defun opening-price (candle) (svref candle 1))
(defun (setf opening-price) (val candle) (setf (svref candle 1) val))
  
;;
(defun high-price (candle) (svref candle 2))
(defun (setf high-price) (val candle) (setf (svref candle 2) val))

;;
(defun low-price (candle) (svref candle 3))
(defun (setf low-price) (val candle) (setf (svref candle 3) val))

;;
(defun closing-price (candle) (svref candle 4))
(defun (setf closing-price) (val candle) (setf (svref candle 4) val))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(declaim (inline make-tick make-candle))

;;
(defun make-tick (utime ask bid ask-vol bid-vol)
  (vector utime ask bid ask-vol bid-vol))

;;
(defun make-candle (utime opening-price high-price low-price closing-price ask-vol bid-vol)
  (vector utime opening-price high-price low-price closing-price ask-vol bid-vol))

