(load "../my")
(got "../cols/num")
(got "../cols/sym")
(got "../cols/tab")
(got "../stats/abcd")

(defstruct nb 
  "Naive Bayes"
  all some (m 1) (k 2))

(demethod add ((i nb) lst)

(defmethod fileIn ((i tab) file)
  (let ((log (make-abcd)))
    (with 
