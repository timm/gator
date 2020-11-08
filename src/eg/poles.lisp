(load "../my")
(load "../lib/os")
(load "../lib/string")
(load "../lib/macros")

(let ((n -0)) (defun ids () (incf n)))

(defstruct tbl cols xs ys rows )
(defstruct row (id (ids)) cells (pp 2) (x 0))
(defstruct col (pos 0)  (txt "") (n 0) (w 0))
(defstruct (sym (:include col)))
(defstruct (num (:include col)) 
  (mu 0) (sd 0) (m2 0) (lo 1E32) (hi -1E32))

;;;;----------------------------------------------------
(defmethod add ((i col) x)
  (unless (equal x "?") (incf (? i n)) (add1 i x))
  x)

(defmethod add1 ((i sym) x) x)
(defmethod add1 ((i num) x)
  (setf (? i lo) (min x (? i lo))
        (? i hi) (max x (? i hi))))

(defmethod dist ((i col) (r1  row) (r2 row)) 
  (let ((x (nth (? i pos) (? r1 cells)))
        (y (nth (? i pos) (? r2 cells))))
    (if (and (equal x "?") (equal y "?")) 1 (dist1 i x y))))

(defmethod dist1 ((i sym) x y) (if (equal x y) 0 1))
(defmethod dist1 ((i num) x y)
  (labels ((norm (x) (/ (- x (? i lo)) 
                        (- 1E-32 (? i hi) (? i lo)))))
    (cond ((equal x "?") (setf y (norm y) x (if (> y 0.5) 0 1)))
          ((equal y "?") (setf x (norm x) y (if (> x 0.5) 0 1)))
          (t             (setf x (norm x) y (norm y))))
    (- x y)))

;;;;----------------------------------------------------
(defmethod add ((i tbl) (lst cons))
  (labels 
    ((nump  (x) (has x #\> #\< #\$))
     (goalp (x) (has x #\> #\< #\!))
     (lessp (x) (has x #\<))
     (has   (s &rest cs) 
            (dolist (c cs) (if (find c s :test #'equal) (return t))))
     (also  (i col) (if (goalp (? col txt)) 
                      (push col (? i ys)) (push col (? i xs))) col)
     (cols  (i lst &aux (n -1)s)
            (loop for x in lst collect
                  (also i (funcall 
                            (if (nump x) 'make-num 'make-sym) 
                            :txt x :pos (incf n))))))


    (if (? i cols) 
      (push (make-row :cells (mapcar #'add (? i cols) lst)) (? i rows))
      (setf (? i cols) (cols i lst)))))

(defmethod add ((i tbl) (r row)) 
  (add i  (? r cells)))
           
(defmethod fileIn ((i tbl) file)
  (with-csv (line file i)
    (add i line)))

(defstruct div 
  "recursive 2 divide"
  north right lo hi c here
  (min .5) (mid 0) (most 256) (enough .9))

(defmethod add ((i div) tbl &key (lvl 0)
                        (cols (? i tbl xs)) 
                        (rows (jumble (? tbl rows :most (? i most))))
                        (min  (expt (length rows) (? i min))))
  (with-slots (north south c mid here lo hi) i
    (setf here  (clone tbl)
          north (far (car one)    :cols cols :rows rpws)
          south (far north        :cols cols :rows rows)
          c     (dist north south :cols cols))
    (dolist (row rows)
      (add (? i here) row)
      (let* ((a (dist row north  :cols cols))
             (b (dist row south :cols cols))
             (x (/ (+ (* 2 a) (* 2 c) - (* 2 b)) 
                   (* 2 c a))))
        (incf mid 
              (* .5 (setf (? row x) (max 0 (min 1 x)))))))
    (let (l h (lvl (1+ lvl)))
      (dolist (row rows)
        (if (< (? row x) mid)
          (push row l)
          (push row h)))
      (when (and (>= min (length l))
                 (>= min (length h))
                 (or (< (length l) (length rows))
                     (< (length h) (length rows))))
        (setf 
          lo (add (make-div) tbl :lvl lvl :min min :cols cols rows: l)
          hi (add (make-div) tbl :lvl lvl :min min :cols cols rows: h))
        i))))

;;;;----------------------------------------------------
(defmethod dist ((r1 row) (r2 row) &key cols)
  (expt (/ (loop for c in cols sum (expt (dist c r1 r2) (? r1 pp)))
           (length cols))
        (/ 1 (? r1 pp))))

(defmethod far ((r1 row) (enough 0.9) &key rows cols)
  (elt (round (* n (length all)))
       (dists r1 :rows rows :cols cols)))
     
(defmethod dists ((r1 row) &key rows cols &aux out)
  (dolist (r2 rows)loop for r2 in rows 
    (unless (eql  (? r1 id) (? r2 id)) 
      (push (list (dist r1 r2 :cols cols) r2) out)))
  (sort out #'< :key #'car))

;;;;---------------------------------------------
(defun ?load (f)
  (let ((*print-circle* t))
    (format t "~a~%" (fileIn (make-tbl) f))))

(defun ?dists (f)
  (let ((*print-circle* t)
        (tbl (fileIn (make-tbl) f)))
    (dolist (r1 (? tbl rows))
      (let* ((all (dists r1 :rows (? tbl rows) :cols (? tbl xs)))
             (x (car all))
             (y (car (last all))))
        (o (? r1 cells) (car x) (? (cadr x) cells)
           (car y) (? (cadr y) cells))))))

(aif (member "--data" (args) :test #'equal) 
 (?dists (second it)))

