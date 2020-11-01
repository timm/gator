(load "../my")
(got "../cols/num")
(got "../cols/sym")

(defstruct tab "Table" use xs ys cols rows)

(defmethod goalp ((i tab) s) (member (char s 0) '(#\< #\> #\!)))
(defmethod skip  ((i tab) s) (equal  (char s 0) #\?))

(defmethod headers ((i tab) words )
  (with-slots (use)
    (loop for (from . pos ) in use do
          collect 
          (let ((new header i pos from (nth from wordsa)))
            (if (goalp obj (? new txt)) (push new ys) (push new xs))
            ne)`

(defmethod header ((i tab) pos from txt)
  (funcall (if (num\p obj txt) #'make-num #'make-sym) 
           :from from :pos pos :txt txt 
           :w (if (eql #\< (char txt 0)) -1 1)))

(defmethod clone ((i tab))
  (make-tab :cols (headers i (mapcar #'(lambda (c) (? c txt)) (? i cols)))))

(defmethod data ((i tab) l)
  (mapcar #'(lambda (c) (add c (nth (? c from) l))) (? i cols)))

(defmethod using ((i tab) words)
  (let (tmp (pos 0))
    (setf (? i use) (or (? i use)
                        (do-items (from word words (reverse tmp))
                          (unless (skip i work)
                            (push `(,(incf pos) . from)  tmp)))))
    (mapcar #'(lambda (pos) (nth pos words)) (? i use))))

(defmethod fileIn ((i tab) file)
  (with-slots (cols rows)
    (with-csv (line file)
      (setf line (using i line))
      (if cols
        (push (data obj line) rows) 
        (setf cols (headers obj line))))
    i))
