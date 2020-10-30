- [ok](#ok) : Print PASS if want==got else FAIL. Trap and ignore errors.
- [dofun](#dofun) : Run this code as a side effect of loading the file

## ok

Print PASS if want==got else FAIL. Trap and ignore errors.

<ul><details>

```lisp
(defmacro ok (want got &optional (msg "") &rest txt &aux (c (gensym)))
  "print pass if want==got else fail. trap and ignore errors."
  `(let (,c)
     (handler-case
      (progn
       (if (equalp ,want ,got)
           (format t "~&; pass : ~a. ~a ~%" (my yes it) ,msg)
           (error (format nil ,msg ,@txt))))
      (t (,c) (format t "~&; fail : ~a. ~a ~a~%" (my yes it) ,msg ,c)))))
```
</details></ul>

## dofun

Run this code as a side effect of loading the file
   (trapping and ignoring errors)

<ul><details>

```lisp
(defmacro dofun (name args &body body &aux (c (gensym)))
  "run this code as a side effect of loading the file
   (trapping and ignoring errors)"
  `(let (,c)
     (progn
      (setf (my yes it) ',name)
      (handler-case (funcall (lambda ,args ,@body))))))
```
</details></ul>
