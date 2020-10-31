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

_Synopsis:_ <b>`(klass-slots it)`</b>  
What are the slots of a class?

<ul>
<details><summary>(..)</summary>

```lisp
(defun klass-slots (it) "" (sb-mop:class-slots (class-of it)))
```
</details></ul>

### klass-slot-definition-name

_Synopsis:_ <b>`(klass-slot-definition-name x)`</b>  
What is a slot's name?

<ul>
<details><summary>(..)</summary>

```lisp
(defun klass-slot-definition-name (x) "" (sb-mop:slot-definition-name x))
```
</details></ul>

### args

_Synopsis:_ <b>`(args)`</b>  
What are the command line args?

<ul>
<details><summary>(..)</summary>

```lisp
(defun args () "" *posix-argv*)
```
</details></ul>

### stop

_Synopsis:_ <b>`(stop)`</b>  
How to halt the program?

<ul>
<details><summary>(..)</summary>

```lisp
(defun stop () "" (exit))
```
</details></ul>

### sh

_Synopsis:_ <b>`(sh cmd)`</b>  
Run a shell command

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
