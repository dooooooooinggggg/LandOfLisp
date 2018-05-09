
;; lispは動的型付け言語

;; 型を調べるやつ

(numberp 5)

;; その他にも、いろいろある。
;; 165pに書いてある。

;; 例えば、addという関数も型ごとにかける
;; condは複数の分岐をかけるやつ
(defun add (a b)
    (cond ((and (numberp a) (numberp b)) (+ a b))
        ((and (listp a) (listp b)) (append a b))))

;; まぁ、いくつかの理由でこの書き方はおそらく採用されない。

;; よって、lispでは、型を限定した関数をかける
(defmethod add ((a number) (b number))
    (+ a b))

(defmethod add ((a list) (b list))
    (append a b))
;; こんな感じ。
