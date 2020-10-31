<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./lib/os.lisp](/src/./lib/os.lisp)
- [klass-slots](#klass-slots) : What are the slots of a class?
- [klass-slot-definition-name](#klass-slot-definition-name) : What is a slot's name?
- [args](#args) : What are the command line args?
- [stop](#stop) : How to halt the program?
- [sh](#sh) : Run a shell command

## OS Tricks

Operating system specific code.

### klass-slots

What are the slots of a class?

Synopsis: <b>(cons klass-slots (it))</b>

<ul>
<details><summary>(..)</summary>

```lisp
(defun klass-slots (it) "" (sb-mop:class-slots (class-of it)))
```
</details></ul>

### klass-slot-definition-name

What is a slot's name?

Synopsis: <b>(cons klass-slot-definition-name (x))</b>

<ul>
<details><summary>(..)</summary>

```lisp
(defun klass-slot-definition-name (x) "" (sb-mop:slot-definition-name x))
```
</details></ul>

### args

What are the command line args?

Synopsis: <b>(cons args nil)</b>

<ul>
<details><summary>(..)</summary>

```lisp
(defun args () "" *posix-argv*)
```
</details></ul>

### stop

How to halt the program?

Synopsis: <b>(cons stop nil)</b>

<ul>
<details><summary>(..)</summary>

```lisp
(defun stop () "" (exit))
```
</details></ul>

### sh

Run a shell command

Synopsis: <b>(cons sh (cmd))</b>

<ul>
<details><summary>(..)</summary>

```lisp
(defun sh (cmd)
  ""
  (run-program "/bin/sh" (list "-c" cmd) :input nil :output *standard-output*))
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
