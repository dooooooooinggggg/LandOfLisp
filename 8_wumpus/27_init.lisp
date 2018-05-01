
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
