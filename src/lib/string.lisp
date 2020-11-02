; vim: noai:ts=2:sw=2:et:
; find cells (seperated by commans)  in lines in csv file

(load "../my")
(got  "../lib/macros")

(defun o (&rest l) 
  "Easy print for a list of things."
  (format t "~{~a~^, ~}" l))

(defun lines (s &optional (lo 0) (hi (position #\Newline s :start (1+ lo))))
  "Split a string into a list of lines, trimming whitespace."
  (cons (cells (subseq s lo hi))
        (if hi (lines s (1+ hi)))))

(defun cells (str &optional want2skip 
                (lo 0) (hi (position #\, str :start (1+ lo))))
  "Split `str` on comma, maybe skip some cells, trim whitespace."
  (if (car want2skip) 
    (and hi (cells str (cdr want2skip) (1+ hi)))
    (cons (string-trim '(#\Space #\Tab #\Newline) (subseq str lo hi))
          (and hi (cells str (cdr want2skip) (1+ hi))))))

(defstruct xpect "stores expectation of columns" want2skip size)

(defmethod add ((obj xpect) str)
  "Return a row same size as row1. Skip columns staring with '?'"
  (with-slots (want2skip size) obj
    (let ((lst (cells str want2skip)))
      (if size ; first time through, "size" is nil
        (assert (eql size  (length lst)))
        (labels ((skip (x) (eql #\? (char x 0))))
          (setf want2skip  (loop for x in lst collect (skip x))
                lst        (remove-if #'skip lst)
                size       (length lst))))
      lst)))

(defmacro with-csv ((lst file) &body body)
  "Iterate over a csv file, return a list of cells for each row."
  (let ((mem  (gensym)) (line (gensym)) (str (gensym)))
    `(let (,line (,mem (make-xpect)))
       (with-open-file (,str ,file)
         (loop while (setf ,line (read-line ,str nil)) do
            (if (> (length ,line) 0)
              (let ((,lst (add ,mem ,line)))
                ,@body)))))))
