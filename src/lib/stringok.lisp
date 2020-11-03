(load "../lib/string")

;#+a(let ((s "I like, traffic lights.  I like traffic lights.  Especially when,     they are green")) (dolist (line (lines s)) (format t "~&~a~%" line)))
         
(csv "../../data/weather.csv" #'print) 

  ;        (format t "~&~a~%" line)) 
