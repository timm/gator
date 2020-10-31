<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./stats/abcd.lisp](/src/./stats/abcd.lisp)
- [abcd](#abcd) : holder for results of one class
- [print-object](#print-object) : Print an abcd
- [adds](#adds) : Given want and got, update one set of results.
- [update](#update) : Reset all the derived cacls of this result.
- [abcds](#abcds) : Holder for mutiple results
- [adds](#adds) : Given want and got, update all results.

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
(defmethod print-object ((obj abcd) stream)
  ""
  (labels ((p (z)
             (round (* 100 z))))
    (with-slots (target pf prec pd f g n c d acc)
        (update obj)
      (format stream "#s~s"
              `(abcd :target ,target :pd ,(p pd) :pf ,(p pf) :prec ,(p prec) :f
                ,(p f) :g ,(p g) :n ,(+ c d) :acc ,(p acc))))))
```
</details></ul>

### adds

Given want and got, update one set of results.
 <ul>
<details><summary>(..)</summary>

```lisp
(defmethod adds ((obj abcd) want got)
  ""
  (with-slots (a b c d target)
      obj
    (if (eql want target)
        (if (eql got want)
            (incf d)
            (incf b))
        (if (eql got target)
            (incf c)
            (incf a)))))
```
</details></ul>

### update

Reset all the derived cacls of this result.
 <ul>
<details><summary>(..)</summary>

```lisp
(defmethod update ((obj abcd) &aux notpf (zip (float (expt 10 -32))))
  ""
  (with-slots (a b c d acc pf prec pd f g n)
      obj
    (setf acc (/ (+ a d) (+ zip a b c d))
          pf (/ c (+ zip a c))
          prec (/ d (+ zip c d))
          pd (/ d (+ zip b d))
          notpf (- 1 pf)
          f (/ (* 2 prec pd) (+ zip prec pd))
          g (/ (* 2 notpf pd) (+ zip notpf pd)))
    obj))
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

### adds

Given want and got, update all results.
 <ul>
<details><summary>(..)</summary>

```lisp
(defmethod adds ((obj abcds) want got)
  ""
  (with-slots (yes no all)
      obj
    (if (equalp want got)
        (incf yes)
        (incf no))
    (has! all want :else (make-abcd :target want :a (+ yes no)))
    (has! all got :else (make-abcd :target got :a (+ yes no)))
    (loop for (target . result) in all
          do (adds result want got))))
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
