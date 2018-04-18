
(defparameter *nodes* '(
    (living-room (あなたはリビングにいます.
        ウィザードがソファーで大きな音を立てている.))
    (garden (あなたは庭にいます.
        あなたの前には井戸がある.))
    (attic (あなたは屋根裏にいます.
        角に巨大な溶接トーチがあります.))
))

(defparameter *edges* '(
    (living-room
        (西に扉庭への扉)
        (屋根裏への梯子)
    )
    (garden (東にリビングへの扉))
    (attic (床にリビングへの梯子))
))

(defparameter *objects* '(whiskey bucket frog chain))

(defparameter *object-locations* '(
    (whiskey living-room)
    (bucket living-room)
    (chain garden)
    (frog garden)
))

(defparameter *location* 'living-room)




(defun describe-location(location nodes)
    (cadr (assoc location nodes))
)
;; (describe-location 'living-room *nodes*)

(defun describe-path (edge)
    `(there is a ,(caddr edge) going ,(cadr edge) from here.)
)
;; (describe-path '(garden west door))

(defun describe-paths (location edges)
    (apply #'append (mapcar #'describe-path (cdr (assoc location edges))))
)
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
;; (describe-objects 'living-room *objects* *object-locations*)

(defun lock ()
    (append
        (describe-location *location* *nodes*)
        (describe-paths *location* *edges*)
        (describe-objects *location* *objects* *object-locations*)
    )
)

