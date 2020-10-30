; vim: noai:ts=2:sw=2:et:
; find cells (seperated by commans)  in lines in csv file


(defstruct abcd  target (a 0) (b 0) (c 0) (d 0) acc pf prec pd f g)

(defmethod print-object ((i abcd) str)
  (with-slots (target pf prec pd f g n c d acc) (update i)
    (format str "target: ~a n: ~a pf: ~a prec: ~a pd: ~a f: ~a g: ~a acc: ~a"
            target (+ c d) (round (* 100 pf)) (round (* 100 prec))
            (round (* 100 pd)) (round (* 100 f))
            (round (* 100 g))
            (round (* 100 acc)))))

(defmethod adds ((i abcd) actual predicted)
  (with-slots (a b c d target) i
    (if (eql actual target)
      (if (eql predicted actual) (incf d) (incf b))
      (if (eql predicted target) (incf c) (incf a)))))

(defmethod update ((i abcd) &aux notpf (zip (float (expt 10 -32))))
  (with-slots (a b c d acc pf prec pd f g n) i
    (setf acc   (/ (+ a d)        (+ zip a b c d))
          pf    (/ c              (+ zip a c    ))
          prec  (/ d              (+ zip c d    ))
          pd    (/ d              (+ zip b d    ))
          notpf (- 1 pf)
          f     (/ (* 2 prec pd)  (+ zip prec pd))
          g     (/ (* 2 notpf pd) (+ zip notpf pd)))
    i))

;;;;----------------------------------------------------------
(defstruct abcds (yes 0) (no 0) all)

(defmethod known ((i abcds) x)
  (with-slots (yes no all) i
    (unless (getf all x)
      (setf all 
            (append `(,x ,(make-abcd :target x :a (+ yes no)) all))))))

(defmethod adds ((i abcds) actual predicted)
  (with-slots (yes no all) i
    (known i actual)
    (known i predicted)
    (if (equalp actual predicted) 
      (incf yes ) 
      (incf no))
    (do-pairs (target result all)
      (adds result actual predicted))))

