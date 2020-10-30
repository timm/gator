<a name=top>
<img width=300 align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/gator.png">

# ./app/nb.lisp
Unhandled TYPE-ERROR in thread #<SB-THREAD:THREAD "main thread" RUNNING
                                  {10008B8083}>:
  The value
    T
  is not of type
    SEQUENCE

Backtrace for: #<SB-THREAD:THREAD "main thread" RUNNING {10008B8083}>
0: (POSITION #\Newline T)
1: ((LAMBDA NIL :IN "/Users/timm/gits/timm/gator/src/lib/doc.lisp"))
2: (SB-INT:SIMPLE-EVAL-IN-LEXENV (LET (THING (WANT (QUOTE (# # # # #))) (FMT "~%### ~(~a~)~%~%~a~%~%<ul><details><summary>...</summary>~%~%```lisp~%~(~S~)~%```~%</details></ul>~%")) (FORMAT T "~a" (WITH-OUTPUT-TO-STRING (MAIN) (FORMAT T "~a" (WITH-OUTPUT-TO-STRING # #))))) #<NULL-LEXENV>)
3: (EVAL-TLF (LET (THING (WANT (QUOTE (# # # # #))) (FMT "~%### ~(~a~)~%~%~a~%~%<ul><details><summary>...</summary>~%~%```lisp~%~(~S~)~%```~%</details></ul>~%")) (FORMAT T "~a" (WITH-OUTPUT-TO-STRING (MAIN) (FORMAT T "~a" (WITH-OUTPUT-TO-STRING # #))))) 1 NIL)
4: ((LABELS SB-FASL::EVAL-FORM :IN SB-INT:LOAD-AS-SOURCE) (LET (THING (WANT (QUOTE (# # # # #))) (FMT "~%### ~(~a~)~%~%~a~%~%<ul><details><summary>...</summary>~%~%```lisp~%~(~S~)~%```~%</details></ul>~%")) (FORMAT T "~a" (WITH-OUTPUT-TO-STRING (MAIN) (FORMAT T "~a" (WITH-OUTPUT-TO-STRING # #))))) 1)
5: ((LAMBDA (SB-KERNEL:FORM &KEY :CURRENT-INDEX &ALLOW-OTHER-KEYS) :IN SB-INT:LOAD-AS-SOURCE) (LET (THING (WANT (QUOTE (# # # # #))) (FMT "~%### ~(~a~)~%~%~a~%~%<ul><details><summary>...</summary>~%~%```lisp~%~(~S~)~%```~%</details></ul>~%")) (FORMAT T "~a" (WITH-OUTPUT-TO-STRING (MAIN) (FORMAT T "~a" (WITH-OUTPUT-TO-STRING # #))))) :CURRENT-INDEX 1)

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
