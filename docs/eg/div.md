<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./eg/div.lisp](/src/./eg/div.lisp)
- [div](#div) : recursive 2 divide
- [add](#add) : Reading data from disk, storing in `rows`, summarized the columns (see `cols`).
- [add](#add) : If reading from a `row`,  use the `row's `cells`.
- [filein](#filein) : Utility to read from discu
- [add](#add) : Skip 'do not know' values (marked with `?`).
- [add1](#add1) : Currently, we do not keep any symbolic column summaries.
- [add1](#add1) : Numeric columns are sumamrized with thei `lo` and `hi` value.
- [dist](#dist) : Normalized stance between two columns of two rows.
- [gap](#gap) : Distance between two rows, using `cols`.
- [far](#far) : Find a `row` in `rows`  far away from `r1`, ignoring outliers.
- [dists](#dists) : Sort all `rows` by their distance to `r1` (using `cols`).
- [grow](#grow) : Project `row` to point `x' between 2 distant points `north` and `south`.

### div

_Synopsis:_ <b>`(div . div)`</b>  
recursive 2 divide

<ul>
<details><summary>(..)</summary>

```lisp
(defstruct div
  ""
  north
  right
  lo
  hi
  c
  here
  (min 0.5)
  (mid 0)
  (most 256)
  (enough 0.9))
```
</details></ul>

### Tables: places to hold data

### add

_Synopsis:_ <b>`(add (i tbl) (lst cons))`</b>  
Reading data from disk, storing in `rows`, summarized the columns (see `cols`).

  First row names the columns. 
  - Column names containing `<` or `>` 
    are goals to be minimized or maximized.
  - Column names containing `<` or `>` 
    or `$` are `num`erics and the rest are `sym` bols.
  

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod add ((i tbl) (lst cons))
  ""
  (labels ((nump (x)
             (has x #\> #\< #\$))
           (goalp (x)
             (has x #\> #\< #\!))
           (lessp (x)
             (has x #\<))
           (has (s &rest cs)
             (dolist (c cs)
               (if (find c s :test #'equal)
                   (return t))))
           (also (i col)
             (if (goalp (? col txt))
                 (push col (? i ys))
                 (push col (? i xs)))
             col)
           (cols (i lst &aux (n -1) s)
             (loop for x in lst
                   collect (also i
                            (funcall
                             (if (nump x)
                                 'make-num
                                 'make-sym)
                             :txt x :pos (incf n))))))
    (if (? i cols)
        (push (make-row :cells (mapcar #'add (? i cols) lst)) (? i rows))
        (setf (? i cols) (cols i lst)))))
```
</details></ul>

### add

_Synopsis:_ <b>`(add (i tbl) (r row))`</b>  
If reading from a `row`,  use the `row's `cells`.

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod add ((i tbl) (r row)) "" (add i (? r cells)))
```
</details></ul>

### filein

_Synopsis:_ <b>`(filein (i tbl) file)`</b>  
Utility to read from discu

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod filein ((i tbl) file) "" (with-csv (line file i) (add i line)))
```
</details></ul>

### Queries Over Columns

### add

_Synopsis:_ <b>`(add (i col) x)`</b>  
Skip 'do not know' values (marked with `?`).

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod add ((i col) x)
  ""
  (unless (equal x "?") (incf (? i n)) (add1 i x))
  x)
```
</details></ul>

### add1

_Synopsis:_ <b>`(add1 (i sym) x)`</b>  
Currently, we do not keep any symbolic column summaries.

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod add1 ((i sym) x) "" x)
```
</details></ul>

### add1

_Synopsis:_ <b>`(add1 (i num) x)`</b>  
Numeric columns are sumamrized with thei `lo` and `hi` value.

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod add1 ((i num) x)
  ""
  (setf (? i lo) (min x (? i lo))
        (? i hi) (max x (? i hi))))
```
</details></ul>

### dist

_Synopsis:_ <b>`(dist (i col) (r1 row) (r2 row))`</b>  
Normalized stance between two columns of two rows.
   
  If both values are missing, assuming max distance. Else, use `dist`.

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod dist ((i col) (r1 row) (r2 row))
  ""
  (let ((x (nth (? i pos) (? r1 cells))) (y (nth (? i pos) (? r2 cells))))
    (if (and (equal x "?") (equal y "?"))
        1
        (dist1 i x y))))
```
</details></ul>

### Queries over rows

### gap

_Synopsis:_ <b>`(gap (r1 row) (r2 row) &key cols)`</b>  
Distance between two rows, using `cols`.

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod gap ((r1 row) (r2 row) &key cols)
  ""
  (expt
   (/
    (loop for c in cols
          sum (expt (dist c r1 r2) (? r1 pp)))
    (length cols))
   (/ 1 (? r1 pp))))
```
</details></ul>

### far

_Synopsis:_ <b>`(far (r1 row) &key (enough 0.9) rows cols)`</b>  
Find a `row` in `rows`  far away from `r1`, ignoring outliers.

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod far ((r1 row) &key (enough 0.9) rows cols)
  ""
  (elt (round (* n (length all))) (dists r1 :rows rows :cols cols)))
```
</details></ul>

### dists

_Synopsis:_ <b>`(dists (r1 row) &key rows cols &aux out)`</b>  
Sort all `rows` by their distance to `r1` (using `cols`).

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod dists ((r1 row) &key rows cols &aux out)
  ""
  (dolist (r2 rows)
   loop
   for
   r2
   in
   rows
    (unless (eql (? r1 id) (? r2 id))
      (push (list (gap r1 r2 :cols cols) r2) out)))
  (sort out #'< :key #'car))
```
</details></ul>

### Recursive 2-way slot

Find two distant points, divide data by their distance to those
two, recurs on each half.

### grow

_Synopsis:_ <b>`(grow (i div) tbl &key (lvl 0) (cols (? i tbl xs))
                 (rows (jumble (? tbl rows :most (? i most))))
                 (min (expt (length rows) (? i min))))`</b>  
Project `row` to point `x' between 2 distant points `north` and `south`.

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod grow
           ((i div) tbl
            &key (lvl 0) (cols (? i tbl xs))
            (rows (jumble (? tbl rows :most (? i most))))
            (min (expt (length rows) (? i min))))
  ""
  (with-slots (north south c mid here lo hi)
      i
    (setf here (clone tbl)
          north (far (car one) :cols cols :rows rpws)
          south (far north :cols cols :rows rows)
          c (dist north south :cols cols))
    (dolist (row rows)
      (add (? i here) row)
      (let* ((a (dist row north :cols cols))
             (b (dist row south :cols cols))
             (x (/ (+ (* a a) (* c c) - (* b b)) (* 2 c))))
        (incf mid (* 0.5 (setf (? row x) (max 0 (min 1 x)))))))
    (let (l h (lvl (1+ lvl)))
      (dolist (row rows)
        (if (< (? row x) mid)
            (push row l)
            (push row h)))
      (when
          (and (>= min (length l)) (>= min (length h))
               (or (< (length l) (length rows)) (< (length h) (length rows))))
        (setf lo (grow (make-div) tbl :lvl lvl :min min :cols cols :rows l)
              hi (grow (make-div) tbl :lvl lvl :min min :cols cols :rows h))
        i))))
```
</details></ul>

### Test suite

<hr>


## License

Gator   
&copy; 2020, Tim Menzies

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject
to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
