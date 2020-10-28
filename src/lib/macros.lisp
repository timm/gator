; vim: noai:ts=2:sw=2:et:

(defmacro while (test &body body) `(do () ((not ,test)) ,@body))

(defmacro getr (how obj f &rest fs)
  (if fs `(getr ,how (,how ,obj ',f) ,@fs) `(,how ,obj ',f)))

(defmacro ? (x &rest fs) `(getr  slot-value ,x ,@fs))

(defmacro doitems ((one pos lst &optional out) &body body )
  `(let ((,pos -1))
     (dolist (,one ,lst ,out) (incf ,pos) ,@body)))
