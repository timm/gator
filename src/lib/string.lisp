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

; (defmacro with-csv ((lst file &optional out) &body body)
;   "Iterate over a csv file, return a list of cells for each row."
;   (let ((mem  (gensym)) (line (gensym)) (str (gensym)))
;     `(let (,line (,mem (make-inside-with-csv)))
;        (with-open-file (,str ,file)
;          (loop while (setf ,line (read-line ,str nil)) do
;                (if (> (length ,line) 0)
;                  (let ((,lst (add ,mem ,line)))
;                    ,@body)))
;          ,out))))
; 
; (defstruct inside-with-csv prep want2skip size)
; 
; (defmethod add ((i inside-with-csv) str)
;   (setf lst        (cells str)
;         (? i prep) (or (? i prep) 
;                        (loop for x in lst
;                              collect 
;                              (unless (eql #\? echar x 0)) 
;                                (if (member (char x 0) '(#\< #\> #\:)) 
;                                  #'read-from-string
;                                  #'identity))))
;         lst        (loop for x in lst 
;                          for y in (? i prep) 
;                          if  y collect (funcall y x))
;         (? i size) (or (? i size) (length lst)))
;   (assert (eql (? i size)  (length lst)))
;   lst)
; 
(defun cells (str &optional (lo 0) (hi (position #\, str :start (1+ lo))))
  (cons (string-trim '(#\Space #\Tab #\Newline) (subseq str lo hi))
        (and hi (cells str (1+ hi)))))

(defmacro with-csv ((line file &optional out) &body body)
  "Iteratively  return cells per line, pruning ignored columns, maybe coerce strings to nums."
  (let ((prep (gensym)) (str (gensym)) (tmp (gensym)) (size (gensym)))
    `(let (,line ,prep ,size)
       (with-open-file (,str ,file)
         (loop while (setf ,tmp (read-line ,str nil)) do
            (when (> (length ,tmp) 0)
              (setf ,tmp  (cells ,tmp)
                    ,prep (or ,prep 
                              (mapcar 
                                #'(lambda (x)
                                    (unless (eql #\? (char x 0)) 
                                      (if (member (char x 0) '(#\< #\> #\:)) 
                                        #'read-from-string
                                        #'identity))) 
                                ,tmp)))
              (let (,line)
                (mapc #'(lambda (x f) (if f (push (funcall f x) ,line))) 
                      ,tmp ,prep)
                (setf  ,size (or ,size  (length ,line)))
                (assert (eql ,size  (length ,line)))
                ,@body))))
       ,out)))
