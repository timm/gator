(load "../my")
(load "../lib/ok")
(load "../stats/abcd")

(let ((a (make-abcds)))
  (print a)
  (dotimes(i 6) (adds a 'y 'y))
  (dotimes(i 2) (adds a 'n 'n))
  (dotimes(i 5) (adds a 'm 'm))
  (adds a 'm 'n)
  (print a))


=== Detailed Accuracy By Class ===
                TP Rate   FP Rate   Precision   Recall  F-Measure   ROC Area  Class
                  1         0          1         1         1          1        yes
                  1         0.083      0.667     1         0.8        0.938    no
                  0.833     0          1         0.833     0.909      0.875    maybe
Weighted Avg.    0.929     0.012      0.952     0.929     0.932      0.938


