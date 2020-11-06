<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./lib/string.lisp](/src/./lib/string.lisp)
- [o](#o) : Easy print for a list of things.
- [lines](#lines) : Split a string into a list of lines, trimming whitespace.
- [with-csv](#with-csv) : Iterate over a csv file, return a list of cells for each row.
- [csv](#csv) : Call `fun` on values found when splitting each line. 

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

_Synopsis:_ <b>`(with-csv (lst file &optional out) &body body)`</b>  
Iterate over a csv file, return a list of cells for each row.

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro with-csv ((lst file &optional out) &body body)
  ""
  `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out))
```
</details></ul>

### csv

_Synopsis:_ <b>`(csv file fun)`</b>  
Call `fun` on values found when splitting each line. 
  Skip columns starting with `?`. 
  Coerce strings to numbers (if needed).

<ul>
<details><summary>(..)</summary>

```lisp
(defun csv (file fun)
  ""
  (with-open-file (str file)
    (let ((first t) prep width)
      (labels ((fromstring (x)
                 (cond (first x) ((equal x "?") x) (t (read-from-string x))))
               (wanted (xs fs &aux (f (pop fs)) (x (pop xs)))
                 (if f
                     (cons (funcall f x) (and xs (wanted xs fs)))
                     (and xs (wanted xs fs))))
               (cells
                   (str &optional (lo 0) (hi (position #\, str :start (1+ lo))))
                 (cons (string-trim '(#\  #\tab #\newline) (subseq str lo hi))
                       (and hi (cells str (1+ hi)))))
               (prep1 (x)
                 (unless (eql #\? (char x 0))
                   (if (member (char x 0) '(#\< #\> #\$))
                       #'fromstring
                       #'identity))))
        (loop
         (let (vals tmp)
           (if (setf tmp (read-line str nil))
               (when (> (length tmp) 0)
                 (setf tmp (cells tmp)
                       prep (or prep (mapcar #'prep1 tmp))
                       vals (wanted tmp prep)
                       width (or width (length vals)))
                 (assert (eql width (length vals)))
                 (funcall fun vals)
                 (setf first nil))
               (return-from csv))))))))
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
