(or (fboundp 'env)  (defun env  (x &optional d) (or #+CLISP (ext:getenv x) #+SBCL (sb-unix::posix-getenv x) d))) (or (fboundp 'want) (defun uses (f)             (load (format nil "~a/~a" (env "Gator" ".") f))))
; <a name=top>
; <img align=right src="https://raw.githubusercontent.com/timm/gator/main/docs/img/lisplogo_256.png">
; 
; # asdaasdad  asdas  
;     
(load "../my")
(got  "cols/num")
(defmethod aa(x) (+ x 1))
(print (make-num))
