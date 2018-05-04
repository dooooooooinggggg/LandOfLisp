
(defun new-game()
    (setf *congestion-city-edges* (make-city-edges))
    (setf *congestion-city-nodes* (make-city-nodes *congestion-city-edges*))
    (setf *player-pos* (find-empty-node))
    (setf *visited-nodes* (list *player-pos*))
    (draw-city)
    (draw-known-city))

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

(defun draw-known-city ()
    (ugraph->png "known-city" (known-city-nodes) (known-city-edges)))


;; walkとchargeは、やることが似ているので、共通部分をくくり出す。

(defun walk (pos)
    (handle-direction pos nil))

(defun charge (pos)
    (handle-direction pos t))


;; これは、指定されたnode番号、posが、移動可能場所のリストにあるかどうかを調べる。
;; 移動可能かどうか、調べ、可能なら、handle-new-place関数を呼び出す。

(defun handle-direction (pos charging)
    (let ((edge (assoc pos
                    (cdr (assoc *player-pos* *congestion-city-edges*)))))
        (if edge
            (handle-new-place edge pos charging)
            (princ "That location doen not exsit!!"))))



(defun handle-new-place (edge pos charging)
    (let* (
            (node (assoc pos *congestion-city-nodes*))
            (has-worm (and
                    (member 'glow-worm node)
                    (not (member pos *visited-nodes*)))))
        (pushnew pos *visited-nodes*)
        (setf *player-pos* pos)
        (draw-known-city)
        (cond ((member 'cops edge) (princ "You ran into the cops. Game Over."))
            ((member 'wumpus node) (if charging
                    (princ "You found the Wumpus!")
                    (princ "You ran into the Wumpus")))
            (charging (princ "You wasted  your last bullet. Game Over."))
            (has-worm (let ((new-pos (random-node)))
                    (princ "You ran into a Glow Worm Gang! You are now at ")
                    (princ new-pos)
                    (handle-new-place nil new-pos nil))))))
