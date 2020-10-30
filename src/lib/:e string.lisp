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

(format t "~a" (with-output-to-string (main)
  (format t "~a" (with-output-to-string (top)
    (while (setf x (read-preserving-whitespace t nil))
      (when (stringp x) 
        (format main "~%~a~%" x))
      (when (listp x)
        (let ((what (first  x))
              (fun   (second x))
              (doc   (fourth x)))
          (when (member what `(defun defmacro defstruct defmethod))
            (format top "- [~(~a~)](#~(~a~)) : ~a~%" fun fun 
                        (subseq 0 (position doc #\Newline)))
            (format main *body* fun doc x)))))))))
