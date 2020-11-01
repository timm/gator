; vim: noai:ts=2:sw=2:et:

(load "../my")
(load "../lib/ok")
(load "../cols/col")

(defstruct (num (:include col)) 
  (mu 0) (sd 0) (m2 0) (lo 1E32) (hi -1E32))

(defmethod add ((obj num) (x number)) 
  (with-slots (n lo hi mu m2 sd) obj
    (setf  n (1+  n)
           d (-   x  mu)
          lo (min lo x)
          hi (max hi x)
          mu (+   mu (/ d n))
          m2 (+   m2 (*  d (- x mu)))
          sd (cond ((<  n 2) 0)
                   ((< m2 0) 0)
                   (t (sqrt (/ m2 (- n 1)))))))
  x)
