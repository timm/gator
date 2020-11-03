<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./lib/string.lisp](/src/./lib/string.lisp)
- [o](#o) : Easy print for a list of things.
- [lines](#lines) : Split a string into a list of lines, trimming whitespace.
- [with-csv](#with-csv) : Iteratively  return cells per line, pruning ignored columns, maybe coerce strings to nums.

### o

_Synopsis:_ <b>`(o &rest l)`</b>  
Easy print for a list of things.

<ul>
<details><summary>(..)</summary>

```lisp
(defun o (&rest l) "" (format t "~{~a~^, ~}" l))
```
</details></ul>

### lines

_Synopsis:_ <b>`(lines s &optional (lo 0)
                 (hi (position #\newline s :start (1+ lo))))`</b>  
Split a string into a list of lines, trimming whitespace.

<ul>
<details><summary>(..)</summary>

```lisp
(defun lines (s &optional (lo 0) (hi (position #\newline s :start (1+ lo))))
  ""
  (cons (cells (subseq s lo hi))
        (if hi
            (lines s (1+ hi)))))
```
</details></ul>

### with-csv

_Synopsis:_ <b>`(with-csv (line file &optional out) &body body)`</b>  
Iteratively  return cells per line, pruning ignored columns, maybe coerce strings to nums.

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro with-csv ((line file &optional out) &body body)
  ""
  (let ((prep (gensym)) (str (gensym)) (tmp (gensym)) (size (gensym)))
    `(let (,line ,prep ,size)
       (with-open-file (,str ,file)
         (loop while (setf ,tmp (read-line ,str nil))
               do (when (> (length ,tmp) 0)
                    (setf ,tmp (cells ,tmp)
                          ,prep
                            (or ,prep
                                (mapcar
                                 #'(lambda (x)
                                     (unless (eql #\? (char x 0))
                                       (if (member (char x 0) '(#\< #\> #\:))
                                           #'read-from-string
                                           #'identity)))
                                 ,tmp)))
                    (let (,line)
                      (mapc
                       #'(lambda (x f)
                           (if f
                               (push (funcall f x) ,line)))
                       ,tmp ,prep)
                      (setf ,size (or ,size (length ,line)))
                      (assert (eql ,size (length ,line)))
                      ,@body))))
       ,out)))
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
