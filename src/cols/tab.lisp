(load "../my")
(got "../lib/string")
(got "../cols/num")
(got "../cols/sym")

(defstruct tab "Table" (new t) xs ys cols rows)

(defmethod header ((i tab) pos txt)
  (labels ((nump  (s) (member (char s 0) '(#\< #\> #\$)))
           (goalp (s) (member (char s 0) '(#\< #\> #\!))))
    (push (make-instance (if (nump txt) 'num 'sym) 
                         :pos pos :txt txt 
                         :w (if (eql #\< (char txt 0)) -1 1))
          (slot-value i (if (goalp txt) 'ys  'xs)))))

(defmethod headers ((i tab) lst &aux (pos 0))
  (setf (? i cols) 
        (mapcar #'(lambda (x) (car (header i (incf pos) x ))) lst))
  i)

(defmethod clone ((i tab))
  (headers (make-tab) (loop for c in (? i cols) collect (? c txt))))

(defmethod data ((i tab) lst)
  (push (mapcar #'add (? i cols) lst) (? i rows)))

(defmethod fileIn ((i tab) file)
  (with-csv (line file i)
    (if (? i cols)
      (data i line)  
      (headers i line))))
