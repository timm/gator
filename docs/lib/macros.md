<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./lib/macros.lisp](/src/./lib/macros.lisp)
- [?](#?) : Simple accessors to nested slots.
- [do-items](#do-items) : Iterate over all positions and items in a list.
- [hop](#hop) : Iterate over `key` `values` in a `hash` table, executing `body`.
- [has!](#has!) : Return alist`'s entry for `x` (and if needed, create it using `init`)

## Macros

Convenience macros.

### ?

_Synopsis:_ <b>`(? x &rest fs)`</b>  
Simple accessors to nested slots.
  
  e.g.

      * (macroexpand '(? x address suburb zipcode))
      (SLOT-VALUE (SLOT-VALUE (SLOT-VALUE X 'ADDRESS) 'SUBURB) 'ZIPCODE)
  
  

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro ? (x &rest fs) "" `(getr slot-value ,x ,@fs))
```
</details></ul>

### do-items

_Synopsis:_ <b>`(do-items (n item lst &optional out) &body body)`</b>  
Iterate over all positions and items in a list.

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro do-items ((n item lst &optional out) &body body)
  ""
  `(let ((,n -1))
     (dolist (,item ,lst ,out) (incf ,n) ,@body)))
```
</details></ul>

### hop

_Synopsis:_ <b>`(hop (key value) over hash do &body body)`</b>  
Iterate over `key` `values` in a `hash` table, executing `body`.

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro hop ((key value) over hash do &body body)
  ""
  `(maphash #'(lambda (,key ,value) ,@body) ,hash))
```
</details></ul>

### has!

_Synopsis:_ <b>`(has! alist x &key else (test #'equal))`</b>  
Return alist`'s entry for `x` (and if needed, create it using `init`)

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro has! (alist x &key else (test #'equal))
  ""
  `(or (assoc ,x ,alist :test ,test)
       (car (setf ,alist (cons (cons ,x ,else) ,alist)))))
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
