(in-package :cl-user)

;;
(defpackage :pattern-streams
  (:use :cl)
  (:import-from :my-utils :group-n)
  (:export 
   :frequency-table
   :make-frequency-table
   :feed-frequency-table
   :feed-frequency-table-of-strings
   
   :update-frequency-table
   :reset-frequency-table

   :pattern-class
   :pattern-frequency
   :pattern-class-frequency
   
   :pattern-probability
   :pattern-class-probability
   :pattern-in-class-probability))
