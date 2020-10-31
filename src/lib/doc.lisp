"##  My simple documenter

Convert lisp code to markdown.  Strings are printed
verbatim.  defuns, defmacros, defmethods, defclass,
defstructs get their doco string pulled, then topped with a
&lt;h3> heading. And a table of contents is added to the top of
page.

Note: 30 lines of code! :wink:

Usage: 

    cat file.lisp | lisp doc.lisp

The system is controlled by two variables:

- The `want` variable.
  An entry (e.g.) `(defun . 3)` says that we will display lists
  starting with `defun` if it has a doc string as element `3`
  (which means the fourth thing in the list).
- The `fmt` variable which controls how we render something's
  name and doc string.
"

(let ((want '((defun    . 3) (defclass  . 3)
              (defmacro . 3) (defstruct . 2) (defmethod . 3)))
      (fmt  
"~%### ~(~a~)~%~%~a~%~%Synopsis: <b>~(~S~)</b>~%~%<ul>~%<details><summary>(..)</summary>
~%```lisp~%~(~S~)~%```~%</details></ul>~%")
      thing)
 (format  t "~a" (with-output-to-string (main)
  (format t "~a" (with-output-to-string (top)
   (loop while (setf thing (read-preserving-whitespace t nil)) 
    do
    (when (stringp thing) 
      (format main "~%~a~%" thing))
    (when (listp thing)
      (when (member (car thing) want :key #'car)
        (let* ((x      (first  thing))
               (f      (second thing))
               (pos    (cdr (assoc x want)))
               (s      (elt    thing pos))
               (synopsis `(cons ,f (elt thing (1- pos)))))
          (when (stringp s)
            (setf (elt thing pos) "")
            (format main fmt f s synopsis thing)
            (format top "- [~(~a~)](#~(~a~)) : ~a~%" 
                    f f (subseq s 0 (position #\Newline s)))))))))))))
