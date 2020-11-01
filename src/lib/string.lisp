; vim: noai:ts=2:sw=2:et:
; find cells (seperated by commans)  in lines in csv file

(load "../my")
(got  "../lib/macros")

(defun o (&rest l) 
  "Easy print for a list of things."
  (format t "~{~a~^, ~}" l))

(defun cells (s &optional  (lo 0) (hi (position #\,  s :start (1+ lo))))
  "Split a string into a list of cells, trimming whitespace."
  (cons (string-trim '(#\Space #\Tab #\Newline) (subseq s lo hi))
        (if hi (cells s (1+ hi)))))

(defun lines (s &optional (lo 0) (hi (position #\Newline s :start (1+ lo))))
  "Split a string into a list of lines, trimming whitespace."
  (cons (cells (subseq s lo hi))
        (if hi (lines s (1+ hi)))))

(defmacro with-csv ((line file) &body body &aux (str (gensym)))
  "Iterate over a csv file, returning a list of cells for each row."
  `(let (,line)
     (with-open-file (,str ,file)
       (loop while (setf ,line (read-line ,str nil)) do
         (when (> (length ,line) 0)
           (setf ,line (cells ,line))
           ,@body)))))
