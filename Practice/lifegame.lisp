(defparameter *lifespan* 12)

(defparameter *width* 100)
(defparameter *height* 100)

(defparameter *prev_val* (make-array (* *width* *height*)))
(defparameter *next_val* nil)

(defun define_init_val ()
    (loop for i below (*  *width* *height*)
        do (
            (lambda ()
                (cond
                    ((not (or (= (mod i *width*) 0) (= (mod i *width*) (- *width* 1)) (< i *width*) (>= i (- (* *width* *height*) *width*))))
                        (setf (aref *prev_val* i) (random 2)))
                    (t (setf (aref *prev_val* i) 0)))
            )
        )
    )
    (princ *prev_val*)
)

(defun print-mold ()
    (loop for i below (*  *width* *height*)
        do (print-each i)
        do (print-fresh-line i)))

(defun print-fresh-line (i)
    (when (= (mod i *width*) (- *width* 1))
        (fresh-line )))

(defun print-each (i)
    ;; (princ i)
    ;; (fresh-line )
    (unless (or (= (mod i *width*) 0) (= (mod i *width*) (- *width* 1)) (< i *width*) (>= i (- (* *width* *height*) *width*)))
        (cond
            ((= (aref *prev_val* i) 1)
                (princ "+"))
            ((= (aref *prev_val* i) 0)
                (princ " "))
            (t (princ "e")))))

(defun life-span ()
    (sleep 1)
    (print-mold))

(defun main()
    (define_init_val)
    (loop for i below *lifespan*
        do (life-span)
        ))

(main)