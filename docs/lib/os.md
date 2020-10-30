<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# ./lib/os.lisp
- [klass-slots](#klass-slots) : what are the slots of a class?
- [klass-slot-definition-name](#klass-slot-definition-name) : what is a slot's name?
- [args](#args) : what are the command line args?
- [stop](#stop) : how to halt the program?
- [sh](#sh) : Run a shwll command

Operating system specific code.

### klass-slots

what are the slots of a class?

<ul><details>

```lisp
(defun klass-slots (it)
  "what are the slots of a class?"
  (sb-mop:class-slots (class-of it)))
```
</details></ul>

### klass-slot-definition-name

what is a slot's name?

<ul><details>

```lisp
(defun klass-slot-definition-name (x)
  "what is a slot's name?"
  (sb-mop:slot-definition-name x))
```
</details></ul>

### args

what are the command line args?

<ul><details>

```lisp
(defun args () "what are the command line args?" *posix-argv*)
```
</details></ul>

### stop

how to halt the program?

<ul><details>

```lisp
(defun stop () "how to halt the program?" (exit))
```
</details></ul>

### sh

Run a shwll command

<ul><details>

```lisp
(defun sh (cmd)
  "run a shwll command"
  (run-program "/bin/sh" (list "-c" cmd) :input nil :output *standard-output*))
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
