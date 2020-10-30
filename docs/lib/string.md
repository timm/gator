<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# ./lib/string.lisp
- [cells](#cells) : (CONS
                     (STRING-TRIM
                      '(  	 
)
                      (SUBSEQ S LO HI))
                     (IF HI
                         (CELLS S (1+ HI))))
- [lines](#lines) : (CONS (CELLS (SUBSEQ S LO HI))
                          (IF HI
                              (LINES S (1+ HI))))
- [with-csv](#with-csv) : `(LET (,LINE)
                             (WITH-OPEN-FILE (,STR ,FILE)
                               (WHILE (SETF ,LINE (READ-LINE ,STR NIL))
                                (WHEN (> (LENGTH ,LINE) 0)
                                  (SETF ,LINE (CELLS ,LINE))
                                  ,@BODY))))

### cells

(CONS
 (STRING-TRIM
  '(  	 
)
  (SUBSEQ S LO HI))
 (IF HI
     (CELLS S (1+ HI))))

<ul><details><summary>...</summary>

```lisp
(defun cells)
```
</details></ul>

### lines

(CONS (CELLS (SUBSEQ S LO HI))
      (IF HI
          (LINES S (1+ HI))))

<ul><details><summary>...</summary>

```lisp
(defun lines)
```
</details></ul>

### with-csv

`(LET (,LINE)
   (WITH-OPEN-FILE (,STR ,FILE)
     (WHILE (SETF ,LINE (READ-LINE ,STR NIL))
      (WHEN (> (LENGTH ,LINE) 0) (SETF ,LINE (CELLS ,LINE)) ,@BODY))))

<ul><details><summary>...</summary>

```lisp
(defmacro with-csv)
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
