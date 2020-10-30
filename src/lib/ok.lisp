; vim: noai:ts=2:sw=2:et:

(load "../my")

(defmacro ok (want got &optional (msg "") &rest txt &aux (c (gensym)))
  "Print PASS if want==got else FAIL. Trap and ignore errors."
  `(let (,c) 
     (handler-case
       (progn 
         (if (equalp ,want, got)
           (format t "~&; PASS : ~a. ~a ~%" (my yes it) ,msg)
           (error (format nil ,msg ,@txt))))
       (t (,c)
          (format t "~&; FAIL : ~a. ~a ~a~%" (my yes it) ,msg ,c)))))

(defmacro dofun (name args &body body &aux (c (gensym)))
  "Run this code as a side effect of loading the file
   (trapping and ignoring errors)"
  `(let (,c) 
     (progn
       (setf (my yes it) ',name)
       (handler-case (funcall (lambda ,args ,@body))))))
