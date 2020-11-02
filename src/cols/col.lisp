; vim: noai:ts=2:sw=2:et:

(load "../my")
(load "../lib/ok")

(defstruct col (pos 0)  (txt "") (n 0))

(defmethod add ((i col) (xs list))
  (dolist (x xs i) (add i x)))
 
(defmethod add ((i col) x) 
  (unless (equal x "?") (add1 i x))
  x)
