; vim: noai:ts=2:sw=2:et:

(defmacro while (test &body body) `(do () ((not ,test)) ,@body))

(defmacro getr (how obj f &rest fs)
  (if fs `(getr ,how (,how ,obj ',f) ,@fs) `(,how ,obj ',f)))

(defmacro ? (x &rest fs) `(getr  slot-value ,x ,@fs))

(defmacro do-items ((n item lst &optional out) &body body )
  `(let ((,n -1))
     (dolist (,item ,lst ,out) (incf ,n) ,@body)))

(defmacro do-keyval ((k v h &optional out) &body body )
  `(progn (maphash #'(lambda (,k ,v) ,@body) ,h) ,out))

(defmacro do-pairs ((k v lst &optional out) &body body)
  (let ((tmp (gensym)))
    `(let ((,tmp ,lst))
       (while ,tmp
              (let ((,k (car  ,tmp))
                    (,v (cadr ,tmp)))
                ,@body
                (setq ,tmp (cddr ,tmp))))
       ,out)))
