<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./lib/string.lisp](/src/./lib/string.lisp)
- [o](#o) : Easy print for a list of things.
- [lines](#lines) : Split a string into a list of lines, trimming whitespace.
- [cells](#cells) : Split `str` on comma, maybe skip some cells, trim whitespace.
- [xpect](#xpect) : stores expectation of columns
- [add](#add) : Return a row same size as row1. Skip columns staring with '?'
- [with-csv](#with-csv) : Iterate over a csv file, return a list of cells for each row.

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

### cells

_Synopsis:_ <b>`(cells str &optional want2skip (lo 0)
                 (hi (position #\, str :start (1+ lo))))`</b>  
Split `str` on comma, maybe skip some cells, trim whitespace.

<ul>
<details><summary>(..)</summary>

```lisp
(defun cells
       (str &optional want2skip (lo 0) (hi (position #\, str :start (1+ lo))))
  ""
  (if (car want2skip)
      (and hi (cells str (cdr want2skip) (1+ hi)))
      (cons (string-trim '(#\  #\tab #\newline) (subseq str lo hi))
            (and hi (cells str (cdr want2skip) (1+ hi))))))
```
</details></ul>

### xpect

_Synopsis:_ <b>`(xpect . xpect)`</b>  
stores expectation of columns

<ul>
<details><summary>(..)</summary>

```lisp
(defstruct xpect "" want2skip size)
```
</details></ul>

### add

_Synopsis:_ <b>`(add (obj xpect) str)`</b>  
Return a row same size as row1. Skip columns staring with '?'

<ul>
<details><summary>(..)</summary>

```lisp
(defmethod add ((obj xpect) str)
  ""
  (with-slots (want2skip size)
      obj
    (let ((lst (cells str want2skip)))
      (if size
          (assert (eql size (length lst)))
          (labels ((skip (x)
                     (eql #\? (char x 0))))
            (setf want2skip
                    (loop for x in lst
                          collect (skip x))
                  lst (remove-if #'skip lst)
                  size (length lst))))
      lst)))
```
</details></ul>

### with-csv

_Synopsis:_ <b>`(with-csv (lst file) &body body)`</b>  
Iterate over a csv file, return a list of cells for each row.

<ul>
<details><summary>(..)</summary>

```lisp
(defmacro with-csv ((lst file) &body body)
  ""
  (let ((mem (gensym)) (line (gensym)) (str (gensym)))
    `(let (,line (,mem (make-xpect)))
       (with-open-file (,str ,file)
         (loop while (setf ,line (read-line ,str nil))
               do (if (> (length ,line) 0)
                      (let ((,lst (add ,mem ,line)))
                        ,@body)))))))
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
