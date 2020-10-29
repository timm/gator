(load "../lib/macros")

(let ((n 0))
  (print (do-pairs (x y '(a 10 b 20 c 30) n)
                   (incf n y))))

