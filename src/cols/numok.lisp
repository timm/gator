(load "../my")
(load "../cols/num")

(let ((n (add (make-num)
               '(9 2  5 4 12  7 8 11 9 3 
                 7 4 12 5  4 10 9  6 9 4))))
  (ok (ish 3.06 (num-sd n)))
  (ok (ish 7    (num-mu n)))
)
