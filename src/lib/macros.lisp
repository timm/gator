; vim: noai:ts=2:sw=2:et:
"## Macros

Convenience macros."

(defmacro while (test &body body) 
  "A simple while loop."
  `(do () ((not ,test)) ,@body))

(defmacro getr (how obj f &rest fs)
  (if fs `(getr ,how (,how ,obj ',f) ,@fs) `(,how ,obj ',f)))

(defmacro ? (x &rest fs) 
  "Simple accessors to nested slots."
  
  e.g.

      \* (macroexpand '(? x address suburb zipcode))
      (SLOT-VALUE (SLOT-VALUE (SLOT-VALUE X 'ADDRESS) 'SUBURB) 'ZIPCODE)
  
  "

  `(getr  slot-value ,x ,@fs))

(defmacro do-items ((n item lst &optional out) &body body )
  "Iterate over all positions and items in a list."
  `(let ((,n -1))
     (dolist (,item ,lst ,out) (incf ,n) ,@body)))

(defmacro do-keyval ((k v h &optional out) &body body )
  "Iterate over all the keys and values in a hash table."
  `(progn (maphash #'(lambda (,k ,v) ,@body) ,h) ,out))

(defmacro do-pairs ((k v lst &optional out) &body body)
  "Iterate over all the keys and values in a property list."
  (let ((tmp (gensym)))
    `(let ((,tmp ,lst))
       (while ,tmp
              (let ((,k (car  ,tmp))
                    (,v (cadr ,tmp)))
                ,@body
                (setq ,tmp (cddr ,tmp))))
       ,out)))
