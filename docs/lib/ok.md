<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./lib/ok.lisp](/src/./lib/ok.lisp)
- [ish](#ish) : T if `x` close to `y`.
- [ok](#ok) : Print PASS if want==got else FAIL. Trap and ignore errors.
- [dofun](#dofun) : Run this code as a side effect of loading the file

## Unit test engine

### ish

_Synopsis:_ <b>`(ish x y &optional (z 0.001))`</b>  
T if `x` close to `y`.

<ul>
<details><summary>(..)</summary>

```lisp
(defun ish (x y &optional (z 0.001)) "" (< (abs (/ (- x y) x)) z))
```
</details></ul>

### ok

_Synopsis:_ <b>`(ok want &optional (got t) (msg "") &rest txt &aux (c (gensym)))`</b>  
Print PASS if want==got else FAIL. Trap and ignore errors.

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro ok (want &optional (got t) (msg "") &rest txt &aux (c (gensym)))
  ""
  `(let (,c)
     (handler-case
      (progn
       (if (equalp ,want ,got)
           (format t "~&; pass : ~a. ~a ~%" (my yes it) ,msg)
           (error (format nil ,msg ,@txt))))
      (t (,c) (format t "~&; fail : ~a. ~a ~a~%" (my yes it) ,msg ,c)))))
```
</details></ul>

### dofun

_Synopsis:_ <b>`(dofun name args &body body &aux (c (gensym)))`</b>  
Run this code as a side effect of loading the file
   (trapping and ignoring errors)

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro dofun (name args &body body &aux (c (gensym)))
  ""
  `(let (,c)
     (progn
      (setf (my yes it) ',name)
      (handler-case (funcall (lambda ,args ,@body))))))
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
