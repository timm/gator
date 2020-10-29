; vim: noai:ts=2:sw=2:et:
; find cells (seperated by commans)  in lines in csv file

(load "../lib/my")
(got  "../lib/macros")

(defun cells (s &optional  (lo 0) (hi (position #\,  s :start (1+ lo))))
  (cons (string-trim '(#\Space #\Tab #\Newline) (subseq s lo hi))
        (if hi (cells s (1+ hi)))))

(defun lines (s &optional (lo 0) (hi (position #\Newline s :start (1+ lo))))
  (cons (cells (subseq s lo hi))
        (if hi (lines s (1+ hi)))))

(defmacro with-csv ((line file) &body body &aux (str (gensym)))
  `(let (,line)
     (with-open-file (,str ,file)
       (while (setf ,line (read-line ,str nil))
         (when (> (length ,line) 0)
           (setf ,line (cells ,line))
           ,@body)))))

