(load "../my")
(got "../lib/ok")
(got "../cols/col")

(defstruct (sym (:include col)) seen (most 0) mode)

(defmethod add1 ((i sym) x)
  (with-slots (seen most mode n) i
    (setf n   (1+ n)
          a   (has! seen x :else 0)
          now (incf (cdr a)))
    (if (> now most) 
      (setf most n
            mode x)))
  x)

(defmethod ent ((i sym))
  (let ((e 0))
    (with-slots (seen n) i
      (loop for (k . v) in seen do
         (if (> v 0)
           (decf e (* (/ v n) (log (/ v n) 2))))))
    e))
