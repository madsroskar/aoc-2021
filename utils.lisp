(defun read-input-from-file (file-name) (mapcar #'parse-integer (uiop:read-file-lines file-name)))

(defun print-results (part-one &optional part-two)
  "Print the results of the puzzle(s) for the day."
  (format nil "~%Part 1: ~d~%Part 2: ~d~%" part-one part-two)
  )
