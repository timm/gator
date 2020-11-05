(load "../my")
(got "../cols/tab")

 (let ((*print-circle* t))
           (format t "~a" (fileIn (make-tab) "../../data/weather.csv")))

