(load "../my")
(got "../cols/num")
(got "../cols/sym")

(defstruct tab "Table" (new t) use xs ys cols rows)

(defmethod nump  ((i tab) s) (member (char s 0) '(#\< #\> #\:)))
(defmethod goalp ((i tab) s) (member (char s 0) '(#\< #\> #\!)))
(defmethod w     ((i tab) s) (if (eql #\< (char txt 0)) -1 1))
(defmethod skip  ((i tab) s) (equal  (char s 0) #\?))

(defmethod headers ((i tab) lst)
  (setf (? i cols)
     (let((n -1)) 
       (loop for x in lst collect (header i (incf n) x)))))

(defmethod header ((i tab) pos txt)
  (let* ((what (if (nump i txt) #'make-num #'make-sym))
         (new  (funcall what :pos pos :txt txt :w (w i txt))))
    (if (goalp i txt) (push new (? i ys)) (push new (? i xs)))
    new))

(defmethod clone ((i tab))
  (make-tab :cols 
     (headers i (loop for c in (? i cols) collect (? c txt)))))

(defmethod data ((i tab) lst)
  (push (loop for c in (? i cols) 
              for d in lst collect (add c d))) (? i rows))

(defmethod fileIn ((i tab) file)
  (with-csv (line file i)
    (if (? i cols)
      (data i line)  
      (headers i line))))
