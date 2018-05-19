
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

;; これを踏まえ、モンスターたちも、structにする
(defstruct monster (health (randval 10)))
;; healthの次の要素は、初期値

(make-monster)

;; 攻撃を受けた時に、モンスターの体力を減らしていく関数
(defmethod monster-hit (m, x)
    (decf (monster-health m) x)
    (if (monster-dead m)
        (progn (princ "You killed the ")
            (princ (type-of m))
            (princ "! "))
        (progn (princ "You hit the ")
            (princ (type-of m))
            (princ ", knocking off ")
            (princ  x)
            (princ " health points!"))))

;; decfは、setfの仲間で、変数の中身を減らす。

;; type-of関数を使うことで、モンスターの種類を調べる。

(type-of 'foo)
;; SYMBOL
(type-of 5)
;; (INTEGER 0 281474976710655)
(type-of "foo")
;; (SIMPLE-BASE-STRING 3)
(type-of (make-monster))
;; MONSTER

(defmethod monster-show (m)
    (princ "A fierce ")
    (princ (type-of m)))

(defmethod monster-attack (m))
;; 定義完了

(defstruct (orc (:include monster)) (club-level (randval 8)))
(push #'make-orc *monster-builders*)

(defmethod monster-show ((m orc))
    (princ "A wicked orc with a level ")
    (princ (orc-club-level m))
    (princ " club"))

(defmethod monster-attack ((m orc))
    (let ((x (randval (orc-club-level m))))
        (princ "An orc swings his club at you and knocks off ")
        (princ x)
        (princ " of your health points. ")
        (decf *player-health* x)))

;; 手強いヒドラ

