"##  My simple documenter

Convert lisp code to markdown.  Strings are printed
verbatim.  defuns, defmacros, defmethods, defclass,
defstructs get their doco string pulled, they topped with a
<h2> heading. And a table of contents is added to the top of
page."

(let (thing
      (want '((defun    . 3) (defclass  . 3)
              (defmacro . 3) (defstruct . 2) (defmethod . 3)))
      (fmt  
"~%### ~(~a~)~%~%~a~% <ul>~%<details><summary>...</summary>
~%```lisp~%~(~S~)~%```~%</details></ul>~%")
      )
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
               (s      (elt    thing pos)))
          (when (stringp s)
            (setf (elt thing pos) "")
            (format main fmt f s thing)
            (format top "- [~(~a~)](#~(~a~)) : ~a~%" 
                    f f (subseq s 0 (position #\Newline s)))))))))))))
