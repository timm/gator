(load "../lib/macros")

(defstruct m-box (left 0) (right 0) (width 0) (height 0))

(defmethod initialize-instance :around ((mb m-box) &key (left 0) (top 0) (width 0) (height 0))
  (progn setf top (* top 100))
  (print `(left ,left))
  (call-next-method mb :left left :top top :width 1 :height 1))


(print (make-instance 'm-box :left 17  :top -34 ))


;(print (make-m-box :left 10))
