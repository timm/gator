"##  My simple documenter

No man is an island,  
Entire of itself,   
Every man is a piece of the continent,   
A part of the main.   
If a clod be washed away by the sea,   
Europe is the less.   
As well as if a promontory were.   
As well as if a manor of thy friend’s   
Or of thine own were:   
Any man’s death diminishes me,   
Because I am involved in mankind,   
And therefore never send to know for whom the bell tolls;   
It tolls for thee.
"

(defmacro while (test &body body) 
  "while loop"
   `(do () ((not ,test)) ,@body))

(defmacro getr (how obj f &rest fs)
  "recursive accessors"
  (if fs `(getr ,how (,how ,obj ',f) ,@fs) `(,how ,obj ',f)))

(defmacro ? (x &rest fs) 
  "emualte pythons dot notaion"
  `(getr  slot-value ,x ,@fs))

(defmacro do-items ((n item lst &optional out) &body body )
  "loop over lists"
  `(let ((,n -1))
     (dolist (,item ,lst ,out) (incf ,n) ,@body)))

(defmacro do-keyval ((k v h &optional out) &body body )
  "loop over hashes"
  `(progn (maphash #'(lambda (,k ,v) ,@body) ,h) ,out))

(defmacro do-pairs ((k v lst &optional out) &body body)
  "loop over property lists"
  (let ((tmp (gensym)))
    `(let ((,tmp ,lst))
       (while ,tmp
              (let ((,k (car  ,tmp))
                    (,v (cadr ,tmp)))
                ,@body
                (setq ,tmp (cddr ,tmp))))
       ,out)))

(defun line1(in) 
  "pull first line from string"
  (with-input-from-string (s in) (
     read-line s nil)))

(defun lisp2markdown()
  "Convert lisp code to markdown
  Strings are printed verbatim.
  defuns get their doco string pulled"
  (let (x)
    (format t "~%~a~%~%" 
      (with-output-to-string(body)
        (format t "~%Table of Contents~%~%~a~%" 
           (with-output-to-string (head)
             (while (setf x (read-preserving-whitespace t nil))
               (when (stringp x)
                 (format body "~%~a~%" x ))
               (when (listp x)
                 (when (member (car x) `(defun defmacro))
                   (format head "- [~(~a~)](#~(~a~)) : ~a~%"                  
                                (second x) (second x) (line1 (fourth x)))
                   (format body "~%~%## ~(~a~)~%~%~a~%~%<ul><details>~%~%```lisp~%~(~a~)~%```~%</details></ul>~%" 
                                (second x) (fourth x) x))))))))))


(lisp2markdown)
