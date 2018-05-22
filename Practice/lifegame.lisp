(defparameter *lifespan* 12)

(defparameter *width* 100)
(defparameter *height* 100)

(defparameter *prev_val* (make-array (* *width* *height*)))
(defparameter *next_val* (make-array (* *width* *height*)))

(defun define_init_val ()
    (loop for i below (*  *width* *height*)
        do (
            (lambda ()
                (cond
                    ((not (or (= (mod i *width*) 0) (= (mod i *width*) (- *width* 1)) (< i *width*) (>= i (- (* *width* *height*) *width*))))
                        (setf (aref *prev_val* i) (random 2)))
                    (t (setf (aref *prev_val* i) 0))))))
    (princ *prev_val*))

(defun cp-next-to-prev ()
    (loop for i below (* *width* *height*)
        do ((lambda ()
            (setf (aref *prev_val* i) (aref *next_val* i))))
    )
)

(defun print-mold ()
    (loop for i below (*  *width* *height*)
        do (print-each i)
        do (print-fresh-line i)))

(defun print-fresh-line (i)
    (when (= (mod i *width*) (- *width* 1))
        (fresh-line )))

(defun print-each (i)
    (unless (or (= (mod i *width*) 0) (= (mod i *width*) (- *width* 1)) (< i *width*) (>= i (- (* *width* *height*) *width*)))
        (cond
            ((= (aref *prev_val* i) 1)
                (princ "+"))
            ((= (aref *prev_val* i) 0)
                (princ " "))
            (t (princ "e")))))

;; ・そのマスに生命体が存在し、周囲8マスに生命体が2体または3体存在するならば生存。
;; ・そのマスに生命体が存在し、周囲8マスに生命体が1体以下または4体以上存在するならば死滅。
;; ・そのマスに生命体が存在せず、周囲8マスに生命体が3体存在するならば誕生。

(defun next-gen (i)
    (let ((c 0))
        (unless (or (= (mod i *width*) 0) (= (mod i *width*) (- *width* 1)) (< i *width*) (>= i (- (* *width* *height*) *width*)))
            (setf c
                (
                    (lambda (counter-list)
                        (apply #'+ counter-list)
                    )
                    (list
                        (aref *prev_val* (- i 101))
                        (aref *prev_val* (- i 100))
                        (aref *prev_val* (- i 99))
                        (aref *prev_val* (- i 1))
                        (aref *prev_val* (+ i 1))
                        (aref *prev_val* (+ i 99))
                        (aref *prev_val* (+ i 100))
                        (aref *prev_val* (+ i 101)))))
            (cond
                ((= (aref *prev_val* 1))
                    (cond
                        ((or (= c 2) (= c 3))
                            (setf (aref *next_val* i) 1))
                        (t (setf (aref *next_val* i) 0))))
                ((= (aref *prev_val* 0))
                    (cond
                        ((= c 3)
                            (setf (aref *next_val* i) 1))
                        (t (setf (aref *next_val* i) 0))))))))

(defun new-gen()
    (loop for i below (* *width* *height*)
        do (next-gen i)))

(defun life-span (gen)
    (sleep 1)
    (princ (format nil "第~d世代" gen))
    (fresh-line )
    (print-mold)
    (new-gen)
    (cp-next-to-prev))

(defun main()
    (define_init_val)
    (loop for i below *lifespan*
        do (life-span i)))

(main)
