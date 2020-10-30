<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# ./stats/abcd.lisp
- [abcd](#abcd) : holder for results of one class
- [print-object](#print-object) : Print an abcd
- [adds](#adds) : Given actual and predicted, update one set of results.
- [update](#update) : Reset all the derived cacls of this result.
- [abcds](#abcds) : Holder for mutiple results
- [known](#known) : Ensure that resuts for `x` exists. 
- [adds](#adds) : Given actual and predicted, update all results.

--------

### abcd

holder for results of one class
 <ul>
<details><summary>(..)</summary>

```lisp
(defstruct abcd "" target (a 0) (b 0) (c 0) (d 0) acc pf prec pd f g)
```
</details></ul>

### print-object

Print an abcd
 <ul>
<details><summary>(..)</summary>

```lisp
(defmethod print-object ((i abcd) str)
  ""
  (with-slots (target pf prec pd f g n c d acc)
      (update i)
    (format str "target: ~a n: ~a pf: ~a prec: ~a pd: ~a f: ~a g: ~a acc: ~a"
            target (+ c d) (round (* 100 pf)) (round (* 100 prec))
            (round (* 100 pd)) (round (* 100 f)) (round (* 100 g))
            (round (* 100 acc)))))
```
</details></ul>

### adds

Given actual and predicted, update one set of results.
 <ul>
<details><summary>(..)</summary>

```lisp
(defmethod adds ((i abcd) actual predicted)
  ""
  (with-slots (a b c d target)
      i
    (if (eql actual target)
        (if (eql predicted actual)
            (incf d)
            (incf b))
        (if (eql predicted target)
            (incf c)
            (incf a)))))
```
</details></ul>

### update

Reset all the derived cacls of this result.
 <ul>
<details><summary>(..)</summary>

```lisp
(defmethod update ((i abcd) &aux notpf (zip (float (expt 10 -32))))
  ""
  (with-slots (a b c d acc pf prec pd f g n)
      i
    (setf acc (/ (+ a d) (+ zip a b c d))
          pf (/ c (+ zip a c))
          prec (/ d (+ zip c d))
          pd (/ d (+ zip b d))
          notpf (- 1 pf)
          f (/ (* 2 prec pd) (+ zip prec pd))
          g (/ (* 2 notpf pd) (+ zip notpf pd)))
    i))
```
</details></ul>

### abcds

Holder for mutiple results
 <ul>
<details><summary>(..)</summary>

```lisp
(defstruct abcds "" (yes 0) (no 0) all)
```
</details></ul>

### known

Ensure that resuts for `x` exists. 
   Set `a` to everything missed so far.
 <ul>
<details><summary>(..)</summary>

```lisp
(defmethod known ((i abcds) x)
  ""
  (with-slots (yes no all)
      i
    (unless (getf all x)
      (setf all (append `(,x ,(make-abcd :target x :a (+ yes no)) all))))))
```
</details></ul>

### adds

Given actual and predicted, update all results.
 <ul>
<details><summary>(..)</summary>

```lisp
(defmethod adds ((i abcds) actual predicted)
  ""
  (with-slots (yes no all)
      i
    (known i actual)
    (known i predicted)
    (if (equalp actual predicted)
        (incf yes)
        (incf no))
    (do-pairs (target result all) (adds result actual predicted))))
```
</details></ul>

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
