"##  My simple documenter

Convert lisp code to markdown Strings are printed verbatim.  defuns
get their doco string pulled.  "

(let (thing
     (want '(defun defmacro defstruct defmethod))
     (fmt  "~%## ~(~a~)~%~%<ul><details>
            ~%```lisp~%~(~S~)~%```~%</details></ul>~%"))
 (format t "~a" (with-output-to-string (main)
  (format t "~a" (with-output-to-string (top)
   (loop while (setf thing (read-preserving-whitespace t nil)) 
    do
    (if (stringp thing) 
      (format main "~%~a~%" thing)
      (let ((f (second thing))
            (s (fourth thing)))
        (when (member (car thing) want)
          (format main fmt f s thing)
          (format top "- [~(~a~)](#~(~a~)) : ~a~%" 
            f f (subseq s 0 (position #\Newline s))))))))))))
