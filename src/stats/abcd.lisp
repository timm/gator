; vim: noai:ts=2:sw=2:et:
; find cells (seperated by commans)  in lines in csv file

(defstruct abcd  
  "holder for results of one class"
  target (a 0) (b 0) (c 0) (d 0) acc pf prec pd f g)

(defmethod print-object ((obj abcd) stream)
  "Print an abcd"
  (labels ((p (z) (round (* 100 z))))
    (with-slots (target pf prec pd f g n c d acc) (update obj)
      (format 
        stream "#S~S" `(ABCD 
          :target ,target :pd ,(p pd)    :pf ,(p pf)  :prec ,(p prec) 
          :f ,(p f)       :g  ,(p g) :n  ,(+ c d) :acc  ,(p acc))))))

(defmethod adds ((obj abcd) want got)
  "Given want and got, update one set of results."
  (with-slots (a b c d target) obj
    (if (eql want target)
      (if (eql got want) (incf d) (incf b))
      (if (eql got target) (incf c) (incf a)))))

(defmethod update ((obj abcd) &aux notpf (zip (float (expt 10 -32))))
  "Reset all the derived cacls of this result."
  (with-slots (a b c d acc pf prec pd f g n) obj
    (setf acc   (/ (+ a d)        (+ zip a b c d))
          pf    (/ c              (+ zip a c    ))
          prec  (/ d              (+ zip c d    ))
          pd    (/ d              (+ zip b d    ))
          notpf (- 1 pf)
          f     (/ (* 2 prec pd)  (+ zip prec pd))
          g     (/ (* 2 notpf pd) (+ zip notpf pd)))
    obj))

;;;;----------------------------------------------------------
(defstruct abcds 
  "Holder for mutiple results"
  (yes 0) (no 0) all)

(defmethod adds ((obj abcds) want got)
  "Given want and got, update all results."
  (with-slots (yes no all) obj
    (if (equalp want got) 
      (incf yes) 
      (incf no))
    (has! all want :else (make-abcd :target want :a (+ yes no)))
    (has! all got  :else (make-abcd :target got  :a (+ yes no)))
    (loop for (target . result) in all do
      (adds result want got))))

