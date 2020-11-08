;;; random stuff
(let* ((seed0      10013)
       (seed       seed0)
       (multiplier 16807.0d0)
       (modulus    2147483647.0d0))
  (labels ((park-miller-randomizer ()
              "cycle= 2,147,483,646 numbers"
              (setf seed (mod (* multiplier seed) modulus))
              (/ seed modulus)))
    (defun reset-seed ()  (setf seed seed0))
    (defun randf      (n) (* n (- 1.0d0 (park-miller-randomizer))))
    (defun randi      (n) (floor (* n (/ (randf 1000.0) 1000))))))
