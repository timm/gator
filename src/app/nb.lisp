; vim: noai:ts=2:sw=2:et:
; find cells (seperated by commans)  in lines in csv file

(load "../lib/my")
(got  "../lib/string")

(defmethod row ((self bayes) cells)
  (if first
    (header all cells)
    (row    all cells)))

(defun nb (f  &aux (all (abcd)) (tab ())) t))
  (let ((all (make-rows))
        some)
    (with-csv (cells f)

