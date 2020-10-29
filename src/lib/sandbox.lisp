"##  My simple documenter

Convert lisp code to markdown Strings are printed verbatim.  defuns
get their doco string pulled.  "

(defvar *body* "## ~(~a~)

~a

<ul><details>

```lisp
~(~S~)
```
</details></ul>~%")

(defmacro while (test &body body) 
  "While loop"
   `(do () ((not ,test)) ,@body))

(defun line1(in) 
  "Pull first line from string"
  (with-input-from-string (s in) (read-line s nil)))

(format t "~a" (with-output-to-string(main)
  (format t "~a" (with-output-to-string (top)
    (while (setf x (read-preserving-whitespace t nil))
      (when (stringp x) 
        (format main "~%~a~%" x))
      (when (listp x)
        (let ((pre (first  x))
              (f   (second x))
              (a   (fourth x)))
          (when (member pre `(defun defmacro defstruct defmethod))
            (format top "- [~(~a~)](#~(~a~)) : ~a~%" f f (line1 a))
            (format main *body* f a x)))))))))
