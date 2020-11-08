; vim: noai:ts=2:sw=2:et:
; find cells (seperated by commans)  in lines in csv file

(load "../my")
(got  "../lib/macros")
(got  "../lib/os")
(got  "../lib/list")

(defun o (&rest l) 
  "Easy print for a list of things."
  (format t "~{~a~^, ~}~%" l))

(defun readfrom (s)
  (let ((tmp (read-from-string s)))
    (if (typep tmp 'number) tmp s)))

(defun cli(&optional (all (copy-list (mapcar #'readfrom (args)))))
  (labels ((groupp (x) (and (stringp x) (>= (length x) 2) 
                            (equal "--" (subseq x 0 2)))))
    (let ((out '((main))))
      (dolist (x all out)
        (if (groupp x)
          (push `(,x) out)
          (setf (cdar out) (append (cdar out) (list x))))))))

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
    (let ((first t) prep width) ; memory across all lines
      (labels
        ((fromString (x) (cond(first         x)
                              ((equal x "?") x)
                              (t             (read-from-string x))))
         (wanted (xs fs &aux (f  (pop fs)) (x (pop xs)))
                 (if f (cons (funcall f x) (and xs (wanted xs fs))) 
                       (and xs (wanted xs fs))))
         (cells (str &optional (lo 0) (hi (position #\, str :start (1+ lo))))
                (cons (string-trim '(#\Space #\Tab #\Newline) (subseq str lo hi))
                      (and hi (cells str (1+ hi)))))
         (prep1 (x) (unless (eql #\? (char x 0)) 
                      (if (member (char x 0) '(#\< #\> #\$)) 
                        #'fromString #'identity))))
        (loop (let (vals tmp) ; memory of this time
                (if (setf tmp (read-line str nil))
                  (when (> (length tmp) 0)
                    (setf tmp  (cells tmp)
                          prep  (or prep (mapcar #'prep1 tmp))
                          vals  (wanted tmp prep)
                          width (or width (length vals)))
                    (assert (eql width (length vals)))
                    (funcall fun vals)
                    (setf first nil))
                  (return-from csv))))))))
