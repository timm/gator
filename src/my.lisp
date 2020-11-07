; vim: noai:ts=2:sw=2:et:

(defvar *gotten* nil)

(defun got(&rest files) 
  (dolist (file files)
    (unless (member file  *gotten* :test #'equalp)
      (push file *gotten*)
      #-sbcl (load file)
      #+sbcl (handler-bind ((style-warning #'muffle-warning)) 
               (load file)))))

(got "../lib/macros")
;;;;

(defvar *my*
  '(ch (     skip  #\?
               less  #\<
               more  #\>
               num   #\$
               klass #\!)
    some (     max 512 
               step .5 
               cohen .3 
               trivial 1.05)
    id -1 
    seed 1
    yes   (    it ""
               pass 0
               fail 0)))

(defmacro my (&rest fs) `(getr getf *my* ,@fs))
