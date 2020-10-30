<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# ./lib/macros.lisp
- [while](#while) : A simple while loop.
- [getr](#getr) : Recursive accessor.
- [?](#?) : Simple accessors to nested slots.
- [do-items](#do-items) : Iterate over all positions and items in a list.
- [do-keyval](#do-keyval) : Iterate over all the keys and values in a hash table.
- [do-pairs](#do-pairs) : Iterate over all the keys and values in a property list.

# Macros

Convenience macros.

## while

A simple while loop.

<ul><details>

```lisp
(defmacro while (test &body body)
  "a simple while loop."
  `(do () ((not ,test)) ,@body))
```
</details></ul>

## getr

Recursive accessor.

<ul><details>

```lisp
(defmacro getr (how obj f &rest fs)
  "recursive accessor."
  (if fs
      `(getr ,how (,how ,obj ',f) ,@fs)
      `(,how ,obj ',f)))
```
</details></ul>

## ?

Simple accessors to nested slots.

<ul><details>

```lisp
(defmacro ? (x &rest fs)
  "simple accessors to nested slots."
  `(getr slot-value ,x ,@fs))
```
</details></ul>

## do-items

Iterate over all positions and items in a list.

<ul><details>

```lisp
(defmacro do-items ((n item lst &optional out) &body body)
  "iterate over all positions and items in a list."
  `(let ((,n -1))
     (dolist (,item ,lst ,out) (incf ,n) ,@body)))
```
</details></ul>

## do-keyval

Iterate over all the keys and values in a hash table.

<ul><details>

```lisp
(defmacro do-keyval ((k v h &optional out) &body body)
  "iterate over all the keys and values in a hash table."
  `(progn (maphash #'(lambda (,k ,v) ,@body) ,h) ,out))
```
</details></ul>

## do-pairs

Iterate over all the keys and values in a property list.

<ul><details>

```lisp
(defmacro do-pairs ((k v lst &optional out) &body body)
  "iterate over all the keys and values in a property list."
  (let ((tmp (gensym)))
    `(let ((,tmp ,lst))
       (while ,tmp
        (let ((,k (car ,tmp)) (,v (cadr ,tmp)))
          ,@body
          (setq ,tmp (cddr ,tmp))))
       ,out)))
```
</details></ul>
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
