(load "../my")
(got "../lib/ok")
(got "../cols/col")

(defstruct (sym (:include col)) seen (most 0) mode)

(defmethod add1 ((i sym) x)
  (with-slots (seen most mode n) i
    (setf n   (1+ n)
          a   (assoc! x seen :if-needed 0)
          now (incf (cdr  a)))
    (if (> now most) 
      (setf most n
            mode x)))
  x)

(defmethod ent ((i sym))
  (with-slots (seen n) i
    (- (loop for (k . v) in seen if (> v 0)
             sum (* (/ v n) (log (/ v n) 2))))))


(defmethod like ((i sym) x)
)
