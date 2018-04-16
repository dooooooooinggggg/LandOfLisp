;; シンボル同士は、eqで比較する。
(defparameter *fruit* 'apple)

(cond ((eq *fruit* 'apple) 'its-an-apple)
    (eq *fruit* 'orange) 'its-an-orange)

;; シンボル同士で、eqを使えるのに、eqを使わないのは、いけてない

;; シンボル同士の比較
(equal 'apple 'apple)
;; T

;; リスト同士の比較
(equal (list 1 2 3) (list 1 2 3))
;; T

;; 異なる方法で作られたリストでも、中身が同じなら、同一とみなされる。

;; 整数同士の比較
(equal 5 5)


;; eqlとか、equalpなどは、紛らわしい。

;; ここら辺は後で調べに帰って来ればいいか。
