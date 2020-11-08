(load "../lib/maths")

(defun assocs (k l)
  (cdr (assoc k l :test #'equal)))

(defun jumble (all &key most (key #'identity))
  (labels ((either () (< .5E8 (randi 1E8))))
    (let ((tmp (sort all #'either :key key)))
      (if most
        (subseq tmp 0 (min most (length all)))
        tmp))))
