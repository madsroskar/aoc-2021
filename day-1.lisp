(load "utils.lisp")

(defparameter *example-input* '(199 200 208 210 200 207 240 269 260 263))
(defparameter *input* (read-input-from-file "day-1.txt"))

(defun find-increases (values)
  "Find the amount of elements in a list that is higher than the previous."
  (loop with previous-depth = (car values)
          for depth in values
          if (> depth previous-depth)
          collect 1 into increases
          do (setf previous-depth depth)
          finally (return (length increases))))

(defun part-one (input)
  "Count the times there's an increase"
  (find-increases input))

(defun values-by-triplets (values)
  "Recurse to return a list of triplet sums"
  (cond ((< (length values) 3) nil)
        (t (cons (reduce '+ (subseq values 0 3)) (values-by-triplets (cdr values)))))
  )

(defun part-two (input)
  "Count increases by triplets of values"
  (find-increases (values-by-triplets input)))

(print-results (part-one *input*) (part-two *input*))
