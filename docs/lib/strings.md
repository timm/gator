<a name=top>
<img align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/lisplogo_256.png">

; find cells , seperated by commoam words in lines in csv file
(defun cells (s &optional  (lo 0) (hi (position #\m  s :start (1+ lo))))
  (cons (string-trim '(#\Space #\Tab #\Newline) (subseq s lo hi))
        (if hi (cells s (1+ hi)))))

(defun lines (s &optional (lo 0) (hi (position #\Newline s :start (1+ lo))))
  (cons (cells (subseq s lo hi))
        (if hi (lines s (1+ hi)))))

(defmacro with-csv ((line file) &body body)
  (let ((str (gensym)))
    `(with-open-file (,str ,file)
       (while (setf ,line (read-line ,str nil))
              (setf ,line (words ,line))
              ,@body))))


