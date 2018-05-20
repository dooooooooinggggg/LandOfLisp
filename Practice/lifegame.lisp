(defparameter *lifespan* 1000)

(defparameter *prev_val* nil)
(defparameter *next_val* nil)

(defun define_init_val(prev_val)
    )

(defun main()
    (define_init_val)
    (loop for i below *lifespan*
        (sleep 1)
        ))

(main)