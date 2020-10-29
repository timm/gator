; vim: noai:ts=2:sw=2:et:

(defmacro ok (want got &optional (msg "") &rest txt)
  `(handler-case
     (if (not (equalp ,want ,got))
       (error (format nil ,msg ,@txt)))
     (t (c)
        (format t "; FAIL ~a" c))))

