; vim: noai:ts=2:sw=2:et:
"## Macros

Convenience macros."

(defmacro getr (how obj f &rest fs)
  (if fs `(getr ,how (,how ,obj ',f) ,@fs) `(,how ,obj ',f)))

(defmacro ? (x &rest fs) 
  "Simple accessors to nested slots.    
  e.g.

      \* (macroexpand '(? x address suburb zipcode))
      (SLOT-VALUE (SLOT-VALUE (SLOT-VALUE X 'ADDRESS) 'SUBURB) 'ZIPCODE)
  
  "
  `(getr  slot-value ,x ,@fs))

(defmacro do-items ((n item lst &optional out) &body body )
  "Iterate over all positions and items in a list."
  `(let ((,n -1))
     (dolist (,item ,lst ,out) (incf ,n) ,@body)))

(defmacro hop ((key  value) over hash do  &body body)
  "Iterate over `key` `values` in a `hash` table, executing `body`."
  `(maphash #'(lambda (,key ,value) ,@body) ,hash))

(defmacro has! (alist x &key else (test #'equal))
  "Return alist`'s entry for `x` (and if needed, create it using `init`)"
  `(or (assoc ,x ,alist :test ,test)
       (car (setf ,alist 
                  (cons (cons ,x  ,else) 
                        ,alist)))))



