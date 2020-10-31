(defstruct mru all (init #'(lambda (z) (cons z 0))))

(defmethod touch ((m mru) x)
  (with-slots (all init) m
    (or (assoc x all :test #'equal)
        (car (setf all (cons (funcall init x) all))))))

(defun xx()
  (let ((m (make-mru)))
    (dotimes (i 200 m) 
      (dotimes (i 16) (incf (cdr (touch m  'd))))
      (dotimes (i 2) (incf (cdr (touch m  'a))))
      (dotimes (i 4) (incf (cdr (touch m  'b))))
      (dotimes (i 256) (incf (cdr (touch m  'h))))
      (dotimes (i 8) (incf (cdr (touch m  'c))))
      (dotimes (i 32) (incf (cdr (touch m  'e))))
      (dotimes (i 512) (incf (cdr (touch m  'i))))
      (dotimes (i 64) (incf (cdr (touch m  'f))))
      (dotimes (i 128) (incf (cdr (touch m  'g))))
      )))

(time (xx))
(print (xx))
