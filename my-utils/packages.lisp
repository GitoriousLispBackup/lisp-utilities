(in-package :cl-user)

;;
(defpackage :my-utils
  (:use :cl :alexandria)
  (:export 
   :with-output-to-file
   :cyclic-range
   :cyclic-range-2
   :ensure-list-2

   :group-n :group 
   :collect :flush
   :make-buffer :buffer-buffer :buffer-first :buffer-last :buffer-length

   :mean :weighted-mean :mode :median 
   :sort-the-map
   :q1 :q3 :quartile 
   :standard-deviation
   :derivative :derivative-n

   :range-listener))
