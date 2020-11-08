<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# [./eg/nb.lisp](/src/./eg/nb.lisp)
Unhandled TYPE-ERROR in thread #<SB-THREAD:THREAD "main thread" RUNNING
                                  {10008B8083}>:
  The value
    T
  is not of type
    STREAM
  when binding STREAM

Backtrace for: #<SB-THREAD:THREAD "main thread" RUNNING {10008B8083}>
0: (SB-INT:SIMPLE-READER-ERROR T "unmatched close parenthesis") [more]
1: (SB-IMPL::READ-RIGHT-PAREN T #<unused argument>)
2: (SB-IMPL::READ-MAYBE-NOTHING T #\))
3: (SB-IMPL::%READ-PRESERVING-WHITESPACE T NIL NIL T)
4: (SB-IMPL::%READ-PRESERVING-WHITESPACE T NIL NIL NIL)
5: ((LAMBDA NIL :IN "/Users/timm/gits/timm/gator/src/lib/doc.lisp"))

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
