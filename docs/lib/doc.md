<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./lib/doc.lisp](/src/lib/os.lisp)

--------

##  My simple documenter

Convert lisp code to markdown.  Strings are printed
verbatim.  defuns, defmacros, defmethods, defclass,
defstructs get their doco string pulled, then topped with a
&nbsp;h3> heading. And a table of contents is added to the top of
page.

Usage: 

    cat file.lisp | lisp doc.lisp

The system is controlled by two variables:

- The `want` variable.
  An entry (e.g.) `(defun . 3)` says that we will display lists
  starting with `defun` if it has a doc string as element `3`
  (which means the fourth thing in the list).
- The `fmt` variable which controls how we render something's
  name and doc string.


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
