(defmacro getr (how obj f &rest fs)
  (if fs `(getr ,how (,how ,obj ',f) ,@fs) `(,how ,obj ',f)))

(defstruct mru all (init #'(lambda (z) (cons z 0))))

(defmethod touch ((m mru) x)
  (with-slots (all init) m
    (or (assoc x all :test #'equal)
        (car (setf all (cons (funcall init x) all))))))

(defstruct mru1 
   (new #'(lambda (z) (cons z 0)))
   (all (make-hash-table :test #'eql)))

(defun has (s  x)
  (or (gethash       x (slot-value s 'all))
      (setf (gethash x (slot-value s 'all))
            (funcall   (slot-value s 'new) x))))

(defstruct counts
  (new #'(lambda (z) (cons z 0)))
  (all (make-hash-table :test #'equal)))

(defstruct klass
  (new #'(lambda (z) (cons z (make-counts))))
  (all (make-hash-table :test #'equal)))

(defmacro have (x &rest fs)
  `(getr has ,x ,@fs))

(defun xx()
  (let ((m (make-mru)))
    (dotimes (i 1000 m) 
      (dotimes (i 16) (incf (cdr (touch m  'd))))
      (dotimes (i 2) (incf  (cdr (touch m  'a))))
      (dotimes (i 4) (incf (cdr (touch m  'b))))
      (dotimes (i 256) (incf (cdr (touch m  'h))))
      (dotimes (i 8) (incf (cdr (touch m  'c))))
      (dotimes (i 32) (incf (cdr (touch m  'e))))
      (dotimes (i 512) (incf (cdr (touch m  'i))))
      (dotimes (i 64) (incf (cdr (touch m  'f))))
      (dotimes (i 128) (incf (cdr (touch m  'g))))
      )))

(defun xx1()
  (let ((m (make-mru1)))
    (dotimes (i 1000 m) 
      (dotimes (i 16)  (incf  (cdr (has m  'd))))
      (dotimes (i 2)   (incf  (cdr (has m  'a))))
      (dotimes (i 4)   (incf  (cdr (has m  'b))))
      (dotimes (i 256) (incf  (cdr (has m  'h))))
      (dotimes (i 8)   (incf  (cdr (has m  'c))))
      (dotimes (i 32)  (incf  (cdr (has m  'e))))
      (dotimes (i 512) (incf  (cdr (has m  'i))))
      (dotimes (i 64)  (incf  (cdr (has m  'f))))
      (dotimes (i 128) (incf  (cdr (has  m  'g))))
      )))
(time (xx))
(time (xx1))
(print (xx))
(print (gethash 'i (mru1-all (xx1))))

