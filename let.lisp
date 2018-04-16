;; local変数の定義
;; ブロック内でのみ有効
;; let
(let ((a 5)
    (b 6))
    (+ a b))

;; これは、a = 5, b = 6という変数を定義。
;; a + bが、結果として得られる。


;; local関数の定義
;; flet
(flet (
    (f (n)
        (+ n 10))
    )
    (f 5))

;; 書式は、
;; (flet ((関数名 (引数)
;;     関数本体...s))
;;     本体....)

;; ブロックの初めで、関数を定義する(fという名前)
;; これを、処理本体で、利用している。

;; 一つのfletコマンドで、複数のローカル関数を一緒に宣言するには、単にコマンドの最初の部分に複数の宣言を書く。
(flet (
    (f (n)
        (+ n 10))
    (g (n)
        (- n 3)))
    (g (f 5)))

;; ローカル関数の中で、同じスコープで定義されるローカル関数名を使用したい場合は、labelsコマンド
;; 形式は fletと同じ
;; 再帰？
(labels (
    (a (n)
        (+ n 5))
    (b (n)
        (+ (a n) 6)))
    (b 10))
;; 21
