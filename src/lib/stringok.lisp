(load "../lib/string")

(let ((n 0)) 
  (with-csv (lst "../../data/auto93.csv") 
    (incf n (length lst)))
  (format t "~&~a~%" n))
