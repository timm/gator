(load "../my")
(load "../cols/sym")

(let ((s (add* (make-sym) '(a a a a b b c))))
  (print (ent s))
)
