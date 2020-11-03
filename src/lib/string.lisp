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

(defun cells (str &optional (lo 0) (hi (position #\, str :start (1+ lo))))
  "Split str on `,`; kill white space; return list of result."
  (cons (string-trim '(#\Space #\Tab #\Newline) (subseq str lo hi))
        (and hi (cells str (1+ hi)))))

(defun csv (file fun)
  "Call `fun` on values found when splitting each line. 
   Skip columns starting with `?`. 
   Coerce strings to numbers (if needed)."
  (with-open-file (str file) 
    (let (how n) ; memory across all lines
      (loop 
        (let (vals tmp) ; memory just for one line
          (labels 
            ((add  (x f) (if f (push (funcall f x) vals)))
             (how1 (x)   (unless (eql #\? (char x 0)) 
                           (if (member (char x 0) '(#\< #\> #\:)) 
                             #'read-from-string #'identity))))
            (if (setf tmp (read-line str nil))
              (when (> (length tmp) 0)
                (setf tmp  (cells tmp)
                      how  (or how (mapcar #'how1 tmp)))
                (mapc #'add tmp how)
                (setf n (or  n (length vals)))
                (assert (eql n (length vals)))
                (funcall fun vals))
              (return-from csv))))))))
