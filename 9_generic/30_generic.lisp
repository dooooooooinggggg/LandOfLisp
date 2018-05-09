
;; データをgenericに扱うためのもの
;; 例えば、リストか、配列に入っている数値のグループを足し合わせたい。

;; こう言った際に、同じ機能のものを型の違いだけで、複数書かないとダメなのか。となる
;; 当然そんなことはない

;; 豊富にある。
;; 例として、ジェネリックライブラリ関数、型述語、defmethod、ジェネリックアクセサなど

;; これらの機能を使うと、defstructで作られたユーザー定義型に関しても、一つのコードで対応できるようになる。


;; 引数の型によらないコードを書くには、データのチェックを他の誰かにやってもらうのが楽。
;; もっともよく使われるのは、シーケンス関数

;; そのうちの一つが、length関数。

;; これはいろんな型を取れるね

;; 特に便利なものがreduce関数

(reduce #'+ '(3 4 6 5 2))


;; これあんまり意味がわからん
;; lambdaに、リストを渡している
(reduce (lambda (best item)
        ;; 偶数で、かつ、item > bestだった場合
        (if (and (evenp item) (> item best))
            item
            best))
    '(7 4 6 5 2)
    :initial-value 0)

(defun sum (lst)
    (reduce #'+ lst))

(sum '(1 2 3))

(sum (make-array 5 :initial-contents '(1 2 3 4 5)))

;; map

;; mapは、今までのmapcarとほぼ同じ動作をする。
;; 違いは、前者は、いろいろ受け取れるのに対して、mapcarは、リストしか扱えない
(map 'list
    (lambda (x)
        (if (eq x #\s)
            #\S
            x))
    "This is a string")
