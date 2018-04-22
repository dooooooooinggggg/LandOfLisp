
;; トップレベル変数で、場所の描画
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

;; (living-room (you are in the living room.
;;     a wizard is snoring loudly on the couch.))
;; 以上の使い方は、alistという構造で、日本語でいうと、連想リスト

;; リストから、キーを元に欲しい要素を抜き出すassoc関数もある。
;; (assoc 'garden *nodes*)
;; ->(GARDEN (YOU ARE IN A BEAUTIFUL GARDEN. THERE IS A WELL IN VRONT OF YOU))
;; 上のようにやると、結果が返ってくる

;; assocを使うと、場所を描画するdescribe-location関数は簡単に書ける。

(defun describe-location(location nodes)
    (cadr (assoc location nodes)))
;; この関数を使うには、場所とリストを渡す。
(describe-location 'living-room *nodes*)

;; ここで、describe関数が、関数の中で直接*nodes*を参照していないのには理由がある。
;; これは、関数型プログラミングスタイルで書かれているからである。
;; 外の世界をみないで、引数と、関数内で定義したもののみを見る。

(defun describe-path (edge)
    `(there is a ,(caddr edge) going ,(cadr edge) from here.))
;; これを使うためのコードは、
(describe-path '(garden west door))

;; 準クォート
;; 準クォートを使うには、これまでコードモードからデータモードに切り替えに使っていた'の代わりに、バッククォートを使う。
;; バッククォートを使った準クォートの中では、カンマを使うことで、一部分だけをコードモードに戻せる。


