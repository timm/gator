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
   `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out))

(defun csv (file fun)
  "Call `fun` on values found when splitting each line. 
   Skip columns starting with `?`. 
   Coerce strings to numbers (if needed)."
  (with-open-file (str file) 
    (let (prep width) ; memory across all lines
      (loop 
        (let (vals tmp) ; memory just for one line
          (labels 
            ((add  (x f) (if f (push (funcall f x) vals)))
             (prep1 (x)  (unless (eql #\? (char x 0)) 
                           (if (member (char x 0) '(#\< #\> #\:)) 
                             #'read-from-string #'identity)))
             (cells (str &optional (lo 0) 
                                   (hi (position #\, str :start (1+ lo))))
                    (cons (string-trim '(#\Space #\Tab #\Newline) 
                                       (subseq str lo hi))
                          (and hi (cells str (1+ hi))))))
            (if (setf tmp (read-line str nil))
              (when (> (length tmp) 0)
                (setf tmp  (cells tmp)
                      prep  (or prep (mapcar #'prep1 tmp)))
                (mapc #'add tmp prep)
                (setf width (or  width (length vals)))
                (assert (eql width (length vals)))
                (funcall fun vals))
              (return-from csv))))))))
