
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

(defun describe-location(location nodes)
    (cadr (assoc location nodes)))

;; (describe-location 'living-room *nodes*)

(defun describe-path (edge)
    `(there is a ,(caddr edge) going ,(cadr edge) from here.))

;; (describe-path '(garden west door))

(defun describe-paths (location edges)
    (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))
;; これは、一般的なプログラミング言語では、for文に値するものである。
;; describe-pathsを実行するには以下の方法をとる。
;; (describe-paths 'living-room *edges*)

;; 次のように実行される。
;; 1. 関係するエッジを見つける。
;; 2. エッジをその描写へと変換する
;; 3. 得られた描画同士をくっつける

;; describe-pathの一番内側を見てみる。

(cdr (assoc 'location *edges*))
;; ((GARDERN WEST DOOR) (ATTIC UPSTAIRS LADDER))

;; ここで得られた結果を、その描写へと変換。
(mapcar #'describe-path '((GARDERN WEST DOOR) (ATTIC UPSTAIRS LADDER)))
;; ((THERE IS A DOOR GOING WEST FROM HERE.) (THERE IS A LADDER GOING UPSTAIRS FROM HERE.))

;; mapcarは、よく使われる関数で、引数に他の関数とリストを受け取って、リストの要素の数だけ関数を呼び出す。
;; このように、他の関数を引数として受け取る関数を高階関数と呼ぶ。
;; また、#' -> #'car -> (function car)
;; このような内部的な変換が行われる。

;; common lispでは、関数を値として扱う場合には、functionオペレータを明示しなければならない。

(apply #'append (mapcar #'describe-path '((GARDERN WEST DOOR) (ATTIC UPSTAIRS LADDER)))))
;; 全て分解するとこうなる。↑

;; append関数と、describe-pathがそれぞれapplyとmapcarに渡されている。
;; この二つは、最初に引数に、関数を受け取るように設計されている。

;; appendにはくっつけたいっリストを一つずつ別々の引数として、渡す必要がある。
;; が、いくつ結果が返ってくるかなどわからない。

;; そこで、applyを使う。
;; applyでは、関数とリストを渡すと、あたかもそのリストの各要素を引数として関数を呼び出したかのような挙動をする。




