(in-package :cl-user)

;;
(defpackage :utime-utils
  (:nicknames :ut)
  (:use :cl)
  (:import-from :my-utils :cyclic-range-2 :flatten :ensure-list-2)
  (:import-from :cl-ppcre :split)

  (:export 

   :*default-time-zone*

   :*month-names*
   :same-month
   :month-alias
   :month-range

   :*day-names*
   :same-dow
   :dow-alias
   :dow-range

   :utime-to-string
   :utime-from-string

   :utime-second
   :utime-minute
   :utime-hour
   :utime-day
   :utime-dow ;; day of week
   :utime-month
   :utime-year
   :utime-part
   :utime-doy ;; day of year

   :start-of-day
   :start-of-month
   :start-of-year

   :first-monday-of-month
   :first-monday-of-year

   :utime-generate
   :utime-merge))
