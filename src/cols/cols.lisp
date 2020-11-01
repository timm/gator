(load "../my")
(got "../cols/macros")
(got "../cols/num")
(got "../cols/sym")

(defstruct cols all xs ys)

(defmethod goalp ((i cols) s) (member (char s 0) '(#\< #\> #\!)))
(defmethod nump  ((i cols) s) (member (char s 0) '(#\< #\> #\:)))

(defmethod add* ((i cols) words)
  (do-items (pos word words i) 
    (let ((new (funcall 
                  (if (nump obj word) #'make-num #'make-sym) 
                  :pos pos :txt txt 
                  :w (if (eql #\< (char txt 0)) -1 1))))
      (push new all)
      (if (goalp obj txt) (push new ys) (push new xs)) 


(defmethod get ((obj tab) (f string))
  (with-slots (rows cols) obj
    (with-csv (line f)
      (if cols
        (data obj line)
        (header obj line))))
  obj)
