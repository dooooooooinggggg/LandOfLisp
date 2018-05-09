;; lispの配列。
(make-array 3)

;; 配列の大きさを指定する。
;; で、これは値なので、実際に使うのは、

(defparameter x (make-array 3))
;; みたいな感じ

;; arefで取り出す。
;; setfと組み合わせて使う。
x
(setf (aref x 1) 'foo)
x

;; lispの配列は、genericなセッターをサポートしていると言われている。

;; これは値を取り出すコードと代入するコードが同じ形でかけるということ。

;; リストと配列の違いに関して、よく見て行く。
;; まず、リストでできることのほとんどは、配列を用いても実装できる。

;; ただ、特定の要素にアクセスするとき、配列はリストより、早い。よって、両者の違いは、性能にある。
;; aref nthは、似ているが、nth(listのやつ)は、遅い。
;; コンスセルなので。

;; 一方、配列は、直接アクセスができるため、速さが一定で、リストに比べて、早い。




;; ハッシュテーブルはalistに似ている。
(make-hash-table ) ;; シンタックスハイライトを効かせるために、一文字空けてある。

(defparameter y (make-hash-table ))

;; gethashでm要素を取り出せる。

(gethash 'yup y)
;; NIL ;
;; NIL

;; 実行結果を見ると、値が二つ帰ってきていることがわかる。
;; これは、そういう機能で、一個めの値は、見つかった結果。
;; 2個目の値は、存在したかどうか。この場合は、nilが帰ってきている。(or T)

;; また、ハッシュテーブルも、配列と同様に、setfを用いて、値を代入する。


;; 数値を二つ返すものとして、roundという関数もある。これは、数値を丸める関数。
(round 2.4)
;; 2 ;
;; 0.4000001

;; 自作の関数で、値を二つ以上返したい場合は、values関数を使う。

(defun foo ()
    (values 3 7))

;; 二つ返して、かつ、その値をすぐに利用する場合、1個目しか評価されない

(+ (foo) 5)
;; 8

;; 二つ目の値を利用したい場合は、別の関数を利用する。
(multiple-value-bind (a b) (foo)
    (* a b))
;; 21

;; これで、二つの返り値をa,bにbindする。

;; ただ、この方式はあまり使われていない。
;; リストを返せばいいので。

;; ハッシュテーブル、どんなに大きくなっても、アクセス時間が一定

;; これを使って、少し改善する。
(defun hash-edges (edge-list)
    (let ((tab (make-hash-table )))
        (mapc (lambda (x)
                (let ((node (car x)))
                    (push (cdr x) (gethash node tab))))
            edge-list)
        tab))

(defun get-connected-hash (node edge-tab)
    (let ((visited (make-hash-table)))
        (labels ((traverse (node)
                    (unless (gethash node visited)
                        (setf (gethash node visited) t)
                        (mapc (lambda (edge)
                                (traverse edge))
                            (gethash node edge-tab)))))
            (traverse node))
        visited))
