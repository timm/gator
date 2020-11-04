(load "../lib/string")

;#+a(let ((s "I like, traffic lights.  I like traffic lights.  Especially when,     they are green")) (dolist (line (lines s)) (format t "~&~a~%" line)))
(declaim (optimize speed)) 
 (require :sb-sprof)

(sb-sprof:with-profiling 
  (:max-samples 1 :report :flat :loop nil)
  (let ((n 0)) 
    (with-csv (lst "../../data/auto93000.csv") 
      (incf n (length lst)))
    (print n)))
