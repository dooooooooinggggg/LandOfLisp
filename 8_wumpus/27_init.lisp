
(defun new-game()
    (setf *conjestion-city-edges* (make-city-edges))
    (setf *conjestion-city-nodes* (make-city-nodes))
    (setf *player-pos* (find-empty-node))
    (setf *visited-nodes* (list *player-pos*))
    (draw-city))

(defun find-empty-node ()
    (let ((x (random-node)))
        (if (cdr (assoc x *conjestion-city-nodes*))
            (find-empty-node)
            x)))

(defun draw-city ()
    (ugraph->png "city" *conjestion-city-nodes* *conjestion-city-edges*))
