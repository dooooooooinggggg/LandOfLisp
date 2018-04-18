
(defparameter *nodes* '(
    (living-room (you are in the living room.
        a wizard is snoring loudly on the couch.))
    (garden (you are in a beautiful garden.
        there is a well in vront of you))
    (attic (you are in the attic.
        there is a giant welding torch in the corner))
))

(defparameter *edges* '(
    (living-room
        (gardern west door)
        (attic upstairs ladder)
    )
    (garden (living-room east door))
    (attic (living-room downstairs ladder))
))

(defparameter *objects* '(whiskey bucket frog chain))

(defparameter *object-locations* '(
    (whiskey living-room)
    (bucket living-room)
    (chain garden)
    (frog garden)
))




(defun describe-location(location nodes)
    (cadr (assoc location nodes)))
;; (describe-location 'living-room *nodes*)

(defun describe-path (edge)
    `(there is a ,(caddr edge) going ,(cadr edge) from here.))
;; (describe-path '(garden west door))

(defun describe-paths (location edges)
    (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))
;; (describe-paths 'living-room *edges*)

(defun objects-at (loc objs obj-locs)
    (labels (
        (at-loc-p (obj)
            (eq (cadr (assoc obj obj-locs)) loc)
        ))
        (remove if-not #'at-loc-p objs)
    )
)

;; (objects-at 'living-room *objects* *object-locations*)
(defun describe-objects (loc objs obj-loc)
    (labels (
        (describe-obj (obj)
            `(you see a ,obj on the floor.)
        )
        (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))
    ))
)

(describe-objects 'living-room *objects* *object-locations*)

;; 今までに作った3つの描写関数をまとめて、lockというコマンドで簡単に呼び出せるようにする。
;; まずは現在地を保持するグローバル変数を作る
;; デフォルトはliving-room
(defparameter *location* 'living-room)

(defun lock ()
    (append
        (describe-location *location* *nodes*)
        (describe-paths *location* *edges*)
        (describe-objects *location* *objects* *object-locations*)
    )
)

;; (lock)で呼び出せる

;; 歩き回るコードも書く。
(defun walk (direction)
    (let (
            (next (find direction
                (cdr (assoc *location* *edges*))
                :key #'cadr)
            )
        )
        (if next
            (progn (setf *location* (car next))
                (lock)
            )
            '(you cannot go that way.)
        )
    )
)

