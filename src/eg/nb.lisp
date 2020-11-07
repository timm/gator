; vim: noai:ts=2:sw=2:et:

(load "../my")
(got "../cols/num")
(got "../cols/sym")
(got "../cols/tab")
(got "../stats/abcd")

(defstruct nb 
  "Naive Bayes"
  (all (make-tab)) few (skip 20) (m 1) (k 2) (log (make-abcd)))

(defmethod guess1((i nb)  lst n cols)
  (let* ((prior (/ (+ n (? i k)) 
                   (+ (length (? i all rows)) 
                      (* (? i k) (length (? i few))))))
         (like  (log prior)))
    (dolist (col cols like)
      (let ((val     (nth (? col pos0 lst))))
        (if (not (equal val "?"))
          (incf (log (like col val prior))))))))

(defmethod guess ((i nb)  lst &optional (cols (? i all cols))) 
  (let (out 
         (most most-negative-fixnum))  
    (loop for (k . tbl) in  (? i few) do
          (setf out (or out k))
          (let ((like (guess i lst cols) (? i all klass n) cols))
            (if (> like most)
              (setf most like 
                    out k))))
    out))

(defmethod data ((i nb) lst &aux (k (klass (? i all) lst)))
  (when (< (decf (? i skip)) 0) 
    (adds (? i log) want (guess i lst)))
  (add (? i all) lst)
  (add (cdr (assoc! l (? i few) want :if-needed (clone (? i all))))
       lst))

(defmethod fileIn ((i tab) file)
  (let ((log (make-abcd)))
    (with-csv (line file i) 
      (if (i all cols)
        (data i line)
        (header (? i all) line)))))

#|
func _Like(i,row,y, n,    prior,like,c,x,f) {
  prior = like = (n + i.K)/(i.nall + i.K*length(i.seen))
  like  = log(like)
  for(c in i.cols.x) {
      x = row[c]
      if(x != "?") {
        f = i.seen[y][c][x] 
        like +=  log((f + i.M*prior) / (n + i.M)) }}
  return like }

func _MostLiked(i,row,     y,like,most,out) {
  most = -10^32
  for(y in i.seen) {
    out = out ? out : y
    like = _Like(i, row, y, i.seen[y][i.cols.class][y])
    if (like > most) {
      most = like
      out  = y }}
  return out }
|#
