- [klass-slots](#klass-slots) : what are the slots of a class?
- [klass-slot-definition-name](#klass-slot-definition-name) : what is a slot's name?
- [args](#args) : what are the command line args?
- [stop](#stop) : how to halt the program?
- [sh](#sh) : Run a shwll command

Operating system specific code.

## klass-slots

what are the slots of a class?

<ul><details>

```lisp
(defun klass-slots (it)
  "what are the slots of a class?"
  (sb-mop:class-slots (class-of it)))
```
</details></ul>

## klass-slot-definition-name

what is a slot's name?

<ul><details>

```lisp
(defun klass-slot-definition-name (x)
  "what is a slot's name?"
  (sb-mop:slot-definition-name x))
```
</details></ul>

## args

what are the command line args?

<ul><details>

```lisp
(defun args () "what are the command line args?" *posix-argv*)
```
</details></ul>

## stop

how to halt the program?

<ul><details>

```lisp
(defun stop () "how to halt the program?" (exit))
```
</details></ul>

## sh

Run a shwll command

<ul><details>

```lisp
(defun sh (cmd)
  "run a shwll command"
  (run-program "/bin/sh" (list "-c" cmd) :input nil :output *standard-output*))
```
</details></ul>
