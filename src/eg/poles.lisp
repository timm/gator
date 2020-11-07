(load "../my")
(load "../lib/string")
(load "../lib/macros")

(defstruct tbl cols rows)
(defstruct col pos txt n)
(defstruct num (:include col) (lo  most-postiive-fixnum) (hi most-negative-fixnum))
(defstruct sym (:include col))

(defmethod add ((i col) x)
  (unless (equal x "?") (incf (? i n)) (add1 i x))
  x)

(defmethod add1 ((i sym) x) x)
(defmethod add1 ((i num) x)
  (setf (? i lo) (min x (? i lo))
        (? i hi) (max x (? i hi))))

(defmethod norm ((i sym) x) x)
(defmethod norm ((i num) x) x)

(labels 
  ((nump  (x) (has x #\> #\< #\$))
   (goalp (x) (has x #\> #\< #\!))
   (lessp (x) (has x #\<))
   (has   (s &rest cs) 
          (dolist (c cs) (if (find c s :test #'equal) (return t)))))

  (defmethod add ((i tbl) lst &aux (n -1))
    (labels ((head (s) (header1 i (make-instance (if (nump s) 'num 'sym) 
                                                 :txt s :pos (incf n)))))
      (if (? i cols) 
        (push (mapcar #'add (? i cols) lst) (? i rows))
        (setf (? i cols) (mapcar #'head lst)))))

  (defmethod header1 ((i tbl) new)
    (if (goalp (? new pos)) 
      (push new (? i ys)) 
      (push new (? i xs)))
    new)
  )


(defun main(file)
  (with-csv (line file)
    (print line)))

;(main "../../data/auto93.csv")
