; vim: noai:ts=2:sw=2:et:

(load "../my")
(load "../lib/ok")

(defstruct col (pos 0) (from 0) (txt "") (n 0))

(defmethod add* ((obj col) xs)
  (dolist (x xs obj) (add obj x)))
 
(defmethod add ((obj col) (x string)) 
  (unless (equal x "?") (add obj (read-from-string x)))
  x)
