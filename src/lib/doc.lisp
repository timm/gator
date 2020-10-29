; vim: noai:ts=2:sw=2:et:

(load "../lib/macros")
(load "../lib/os")

(defun macrop (x)  (and (listp x) (eql (first x) 'defmacro)))
(defun funp (x)    (and (listp x) (eql (first x) 'defun)))
(defun strucpx)    (and (listp x) (eql (first x) 'defstruct)))

(let ((b4 :comment))
   (cond ((stringp s) (print s))
         ((macrop  s) (print  
     (string (print 1))

(defun reads (f)
  (with-open-file (s f)(while (setf x (read s nil)) (print x)))

(let ((cli (args)))
  (if (and cli (member "--makedoc" cli :test #'equalp))
    (readme)))
