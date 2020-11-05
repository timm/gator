; vim: noai:ts=2:sw=2:et:

(load "../my")
(load "../lib/ok")
(load "../cols/col")

(defstruct (num (:include col)) 
  (mu 0) (sd 0) (m2 0) (lo 1E32) (hi -1E32))

(defmethod add1 ((i num) (x number)) 
  (with-slots (n lo hi mu m2 sd) i
    (setf  n (1+  n)
           d (-   x  mu)
          lo (min lo x)
          hi (max hi x)
          mu (+   mu (/ d n))
          m2 (+   m2 (*  d (- x mu)))
          sd (cond ((<  n 2) 0)
                   ((< m2 0) 0)
                   (t (sqrt (/ m2 (- n 1)))))))
  x)
o
unc _Like(i,row,y, n,    prior,like,c,x,f) {
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
