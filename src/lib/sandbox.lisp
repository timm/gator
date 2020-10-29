"##  My simple documenter

Convert lisp code to markdown
Strings are printed verbatim.
defuns get their doco string pulled.
"

(defmacro while (test &body body) 
  "while loop"
   `(do () ((not ,test)) ,@body))

(defun line1(in) 
  "pull first line from string"
  (with-input-from-string (s in) (
     read-line s nil)))

(defvar toc-txt "- [~(~a~)](#~(~a~)) : ~a~%")  
(defvar body-txt "

## ~(~a~)

~a

<ul><details>

```lisp
~(~S~)
```
</details></ul>~%"
) 

(defun show (x body toc)
  "low -level worker"
  (when (stringp x)
    (format body "~%~a~%" x ))
  (when (listp x)
    (when (member (car x) `(defun defmacro defstruct))
      (let ((f (second x))
            (a (fourth x)))
        (format toc  toc-txt  f f (line1 a))
        (format body body-txt f a x)))))

(defun fromStdio()
  (format t "~%~a~%~%" 
    (with-output-to-string(body)
      (format t "~%Contents~%~%~a~%"
        (with-output-to-string (toc)
          (let (x)
            (while (setf x (read-preserving-whitespace t nil))
              (show x body toc))))))))

(fromStdio)
