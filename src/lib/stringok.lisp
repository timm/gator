(load "../lib/string")

;#+a(let ((s "I like, traffic lights.  I like traffic lights.  Especially when,     they are green")) (dolist (line (lines s)) (format t "~&~a~%" line)))
         
(with-csv (lst "../../data/weather.csv")
   (print lst))

  ;        (format t "~&~a~%" line)) 
