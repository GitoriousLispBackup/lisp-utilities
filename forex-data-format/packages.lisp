(in-package :cl-user)

;;
(defpackage :forex-data-format
  (:use :cl :utime-utils :my-utils)

  (:export 
   :make-tick 
   :make-candle

   :utime 
   :ask 
   :bid 
   :ask-vol 
   :bid-vol

   :opening-price
   :high-price
   :low-price
   :closing-price

   :ticks-to-candles
   ))
