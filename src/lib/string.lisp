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

(defmacro with-csv ((lst file &optional out) &body body)
  "Iterate over a csv file, return a list of cells for each row."
  (let ((mem  (gensym)) (line (gensym)) (str (gensym)))
    `(let (,line (,mem (make-inside-with-csv)))
       (with-open-file (,str ,file)
         (loop while (setf ,line (read-line ,str nil)) do
               (if (> (length ,line) 0)
                 (let ((,lst (add ,mem ,line)))
                   ,@body)))
         ,out))))

; some slave functions for with-csv
(defstruct inside-with-csv want2skip prep size)

(defmethod add ((obj inside-with-csv) str)
  (with-slots (want2skip size prep) obj
    (let ((lst (cells str want2skip prep)))
      (if size ; first time through, "size" is nil
        (assert (eql size  (length lst)))
        (labels ((skip (x) (eql #\? (char x 0)))
                 (prep (x) (if (member (char x 0) '(#\< #\> #\:)) 
                               #'read-from-string 
                               #'identity)))
          (setf want2skip  (mapcar    #'skip lst)
                lst        (remove-if #'skip lst)
                prep       (mapcar    #'prep lst)
                size       (length lst))))
      lst)))

; Split `str` on comma, maybe skip some cells, trim whitespace.
(defun cells (str &optional want2skip  prep
                  (lo 0) (hi (position #\, str :start (1+ lo))))
  (labels 
    ((cell1() (and hi (cells str (cdr want2skip) (cdr prep) (1+ hi))))
     (word () (funcall (or (car prep) #'identity) 
                        (string-trim '(#\Space #\Tab #\Newline) 
                                     (subseq str lo hi)))))
    (if (car want2skip) (cell1) (cons (word) (cell1)))))
