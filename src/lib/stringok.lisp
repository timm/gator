(load "../lib/string")

(let ((s "I like, traffic lights.
          I like traffic lights.
          Especially when,     they are green"))
          (dolist (line (lines s))
            (format t "~&~a~%" line)))
         
(with-csv (line "../../data/weather.csv") 
  (print line))

  ;        (format t "~&~a~%" line)) 
