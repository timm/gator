"Manage tables of rows and columns."

(load "../my")
(got "../lib/string")
(got "../cols/num")
(got "../cols/sym")

(defstruct tab "Table"  (keep t) cols klass! xs ys rows)

(labels ((nump   (s) (member (char s 0) '(#\< #\> #\$)))
         (klassp (s) (equal (char s 0) #\!))
         (goalp  (s) (member (char s 0) '(#\< #\> #\!))))

  (defmethod header ((i tab) pos txt)
    (let ((tmp (make-instance (if (nump txt) 'num 'sym) 
                         :pos pos :txt txt 
                         :w (if (eql #\< (char txt 0)) -1 1))))
      (if (klassp txt) (setf (? i klass!) tmp))
      (if (goalp txt)  (push tmp (? i ys)) (push tmp (? i xs)))))

  (defmethod headers ((i tab) lst &aux (pos 0))
    (setf (? i cols) 
          (mapcar #'(lambda (x) (car (header i (incf pos) x ))) lst))
    i)

  (defmethod clone ((i tab))
    (headers (make-tab :keep (? i keep)) 
             (loop for c in (? i cols) collect (? c txt))))

  (defmethod klass ((i tab) lst)
     (nth (? i klass pos) lst))

  (defmethod data ((i tab) lst)
    (let ((tmp (mapcar #'add (? i cols) lst)))
      (if (? i keep) (push tmp (? i rows)))))

  (defmethod fileIn ((i tab) file)
    (with-csv (line file i)
      (if (? i cols)
        (data i line)  
        (headers i line))))
  )
