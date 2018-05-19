(loop for i
    below 5
    sum i)
;; 括弧が少ない、おかしい。

;; forはある範囲の値を移動していく、変数を宣言する。デフォルトでは、ゼロから始まってインクリメントしていく。
;; belowは、その値まできたら、forを止める指示をする。あたい自身は含まれない。
;; sumは与えられた式を合計する。内部的に積もり積もっていくイメージ？

;; 終点と始点を決めることもできる
(loop for i
    from 5
    to 10
    sum i)
;; この例では、5から10までの和。

(loop for i
    below 5
    do (print i))

;; doも使える。

;; whenは、それに続く部分を必要な時だけ実行するのに使う。
;; 下の例は、奇数だけ返すもの
(loop for i
    below 10
    when (oddp i)
    sum i)

;; ループを途中で脱出
(loop for i
    from 0
    do (print i)
    when (= i 5)
    return 'falafel)


;; collectは、一つ以上の値をリストにまとめてloopの値としたいときに使える。
;; 入力のリストの各要素を変更したいときに使う
(loop for i
    '(2 3 4 5 6)
    collect (* i i))

(loop for x below 10
    for y below 10
    collect (+ x y))

;; この場合は、二重に実行されない、二重に実行させたいなら、collectの中でやらないとダメ。
;; 以下のように
(loop for x below 10
    collect (loop for y below 10
        collect (+ x y)))

;; 要素数10個のリストを10こ作る。


;; こんな使い方もできる
(loop for i
    from 0
    for day
    in '(monday tuesday wednesday thursday friday saturday sunday)
    collect(cons (+ i 1) day))
