(or (fboundp 'env)  (defun env  (x &optional d) (or #+CLISP (ext:getenv x) #+SBCL (sb-unix::posix-getenv x) d)))
(or (fboundp 'want) (defun uses (f)             (load (format nil "~a/~a" (env "Gator" ".") f))))
; # num
; 

(defstruct num (n 0) (mu 0) (sd 0) (m2 0))

