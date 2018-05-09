(cons 1 (cons 2 (cons 3 nil)))
;; (1 2 3)

(cons 1 (cons 2 3))
;; (1 2 . 3)

;; 末尾の情報、本来nilになるべきところを、先頭の要素に向ける。
;; これをする際は、以下のコマンドを叩いて、REPLにそういうことをすることを知らせておかないといけない。
(setf *print-circle* t)

(defparameter foo (list 1 2 3))

(setf (cdddr foo) foo)
;; 要は、(1 2 3)というのは、
(cons 1 (cons 2 (cons 3 nil)))
;; となっていて、そのnilに、fooを代入しているということ

(defparameter *drink-order* '(
        (bill . double-espresso)
        (lisa . small-drip-coffee)
        (john . medium-latte)))

(assoc 'lisa *drink-order*)

(push '(lisa . large-mocha-with-whipped-cream) *drink-order*)

(assoc 'lisa *drink-order*)

;; 木構造データの可視化
(defparameter *house* '(
        (walls
            (mortar
                (cement)
                (water)
                (sand))
            (bricks))
        (windows
            (glass)
            (frame)
            (curtains))
        (roof (snigles)
            (chimney))))

;; グラフの可視化
(defparameter *nodes* '(
        (living-room (
                you are in the living-room.
                a wizard is snoring loudly on the couch.))
        (garden (
                you are in a beautiful garden.
                there is a well in front of you.))
        (attic (
                you are in the attic.
                there is a giant welding torch in the corner.))))
;; もともと上のような感じだった。
(defparameter *wizard-nodes* '(
        (living-room (
                you are in the living-room.
                a wizard is snoring loudly on the couch.))
        (garden (
                you are in a beauttiful gardeernn.
                there is a well in front of you.))
        (attic (
                you are in the attic.
                there is a giant welding torch in the corner.))))
;; 同じじゃん....


(defparameter *edges* '(
        (living-room
            (garden west door)
            (attic upstairs ladder))
        (garden
            (living-room east door))
        (attic
            (living-room downstairs ladder))))

(defparameter *wizard-edges* '(
        (living-room
            (garden west door)
            (attic upstairs ladder))
        (garden
            (living-room east door))
        (attic
            (living-room downstairs ladder))))
