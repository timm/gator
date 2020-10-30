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

## cells

(CONS
 (STRING-TRIM
  '(  	 
)
  (SUBSEQ S LO HI))
 (IF HI
     (CELLS S (1+ HI))))

<ul><details>

```lisp
(defun cells (s &optional (lo 0) (hi (position #\, s :start (1+ lo))))
  (cons (string-trim '(#\  #\tab #\newline) (subseq s lo hi))
        (if hi
            (cells s (1+ hi)))))
```
</details></ul>

## lines

(CONS (CELLS (SUBSEQ S LO HI))
      (IF HI
          (LINES S (1+ HI))))

<ul><details>

```lisp
(defun lines (s &optional (lo 0) (hi (position #\newline s :start (1+ lo))))
  (cons (cells (subseq s lo hi))
        (if hi
            (lines s (1+ hi)))))
```
</details></ul>

## with-csv

`(LET (,LINE)
   (WITH-OPEN-FILE (,STR ,FILE)
     (WHILE (SETF ,LINE (READ-LINE ,STR NIL))
      (WHEN (> (LENGTH ,LINE) 0) (SETF ,LINE (CELLS ,LINE)) ,@BODY))))

<ul><details>

```lisp
(defmacro with-csv ((line file) &body body &aux (str (gensym)))
  `(let (,line)
     (with-open-file (,str ,file)
       (while (setf ,line (read-line ,str nil))
        (when (> (length ,line) 0) (setf ,line (cells ,line)) ,@body)))))
```
</details></ul>
