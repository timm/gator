; vim: noai:ts=2:sw=2:et:

(load "~/.gator")
(got "lib/macros")

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
    seed 1
    yes   (    it ""
               pass 0
               fail 0)))

(defmacro my (&rest fs) `(getr getf *my* ,@fs))
