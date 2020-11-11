(load "../lib/maths")

(defun assocs (k l)
  (assoc k l :test #'equal))

(defun jumble (all &key most (key #'identity))
  (labels ((either (x y) (< .5E8 (randi 1E8))))
    (let ((tmp (sort all #'either :key key)))
      (if most
        (subseq tmp 0 (min most (length all)))
        tmp))))

(defun after (x lst &key (test #'equal))
  (cadr (member x lst :test test)))
