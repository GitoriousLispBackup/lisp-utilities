(in-package :cl-user)

;;
(defpackage :function-maps
  (:use :cl)
  (:import-from :my-utils :ensure-list)
  (:export 
   :compose
   :compose-serial
   :compose-parallel

   ;; utils
   :collect-listener)) 
