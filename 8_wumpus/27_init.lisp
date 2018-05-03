
(defun new-game()
    (setf *congestion-city-edges* (make-city-edges))
    (setf *congestion-city-nodes* (make-city-nodes))
    (setf *player-pos* (find-empty-node))
    (setf *visited-nodes* (list *player-pos*))
    (draw-city))

(defun find-empty-node ()
    (let ((x (random-node)))
        (if (cdr (assoc x *congestion-city-nodes*))
            (find-empty-node)
            x)))

(defun draw-city ()
    (ugraph->png "city" *congestion-city-nodes* *congestion-city-edges*))

(defun known-city-nodes ()
    (mapcar (lambda (node)
            (if (member node *visited-nodes*)
                (let ((n (assoc node *congestion-city-nodes*)))
                    (if (eql node *player-pos*)
                        (append n '(*))
                        n))
                (list node '?)))
        (remove-duplicates
            (append *visited-nodes*
                (mapcan (lambda (node)
                        (mapcar #'car
                            (cdr (assoc node
                                    *congestion-city-edges*))))
                    *visited-nodes*)))))

(defun known-city-edges ()
    (mapcar (lambda (node)
            (cons node (mapcar (lambda (x)
                        (if (member (car x) *visited-nodes*)
                            x
                            (list (car x))))
                    (cdr (assoc node *congestion-city-edges*)))))
        *visited-nodes*))
