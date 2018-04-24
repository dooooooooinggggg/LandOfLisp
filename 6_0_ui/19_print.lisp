
(print "foo")

;; "foo"
;; "foo"

;; 1個目が実際に表示した値。
;; 2個目は、replが評価した結果。

(prin1 "foo")
;; これは、改行なし

(defun say-hello ()
    (print "Please type your name:")
    (let ((name (read)))
        (prin1 "Nice to meet you ")
        (print name)))

(say-hello)

;; [6]> (say-hello)

;; "Please type your name:" bob
;; "Nice to meet you "
;; BOB
;; BOB
;; [7]> (say-hello)

;; "Please type your name:" "bob"
;; "Nice to meet you "
;; "bob"
;; "bob"

(defun add-five()
    (print "please enter a number:")
    (let ((num (read)))
        (print "When I add five I get")
        (print (+ num 5))))

(add-five)


(defun say-hello2 ()
    (princ "Please type your name:")
    (let ((name (read-line)))
        (princ "Nice to meet you ")
        (princ name)))

(say-hello2)
