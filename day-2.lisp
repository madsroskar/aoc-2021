(load "utils.lisp")

(defparameter *example-input* (list "forward 5" "down 5" "forward 8" "up 3" "down 8" "forward 2"))
(defparameter *input* (read-input-from-file "day-2.txt" #'string))

(defun get-updated-horizontal-position (current direction amount)
  "Update a CURRENT horizontal position, if DIRECTION is 'forward', add AMOUNT"
  (if (string-equal direction "forward") (+ current amount) (+ 0 current)))

(defun get-updated-depth (current direction amount)
  "Update a CURRENT depth, if DIRECTION is 'up' or 'down' with AMOUNT"
  (cond ((string-equal direction "up") (- current amount))
        ((string-equal direction "down") (+ current amount))
        (t (+ 0 current))))

(defun get-updated-position (current update)
  "Get an updated position as a list with (horizontal-position depth)"
  (let* ((da (uiop/utility:split-string update :max 2 :separator " "))
         (direction (car da))
         (amount (parse-integer (car (cdr da)))))
    (list
     (get-updated-horizontal-position (car current) direction amount)
     (get-updated-depth (cadr current) direction amount)
     )))

(defun iterate-positions (course &optional (current-position (list 0 0)))
  "For a list of steps in a course, find updated positions horizontally and in depth.
This takes a starting position, and updates the position accoringly, once per item
in the course list. If no position is passed, it assumes a starting position of
horizontal: 0, depth: 0"
  (if (>= (length course) 1)     ;; If there's at least one item in the course,
      (iterate-positions        ;; Iterate through positions
       (cdr course)             ;; With all course items except the first
       (get-updated-position    ;; and an updated position
        current-position        ;; calculated with the current position
        (car course)))          ;; and the first item in the course
      current-position))        ;; OR return the current position

;; (Horizontal Depth)
(defun part-one (input)
  (reduce #'* (iterate-positions input)))


(print-results (part-one *input*)) ;; 2039256
