<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# ./lib/string.lisp
- [cells](#cells) : Split a string into a list of cells, trimming whitespace.
- [lines](#lines) : Split a string into a list of lines, trimming whitespace.
- [with-csv](#with-csv) : Iterate over a csv file, returning a list of cells for each row.

--------

### cells

Split a string into a list of cells, trimming whitespace.
 <ul>
<details><summary>(..)</summary>

```lisp
(defun cells (s &optional (lo 0) (hi (position #\, s :start (1+ lo))))
  ""
  (cons (string-trim '(#\  #\tab #\newline) (subseq s lo hi))
        (if hi
            (cells s (1+ hi)))))
```
</details></ul>

### lines

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

Iterate over a csv file, returning a list of cells for each row.
 <ul>
<details><summary>(..)</summary>

```lisp
(defmacro with-csv ((line file) &body body &aux (str (gensym)))
  ""
  `(let (,line)
     (with-open-file (,str ,file)
       (while (setf ,line (read-line ,str nil))
        (when (> (length ,line) 0) (setf ,line (cells ,line)) ,@body)))))
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
