;; 以下の関数の、説明。
;; この関数群は、このゲームの中で、もっとも面倒な関数で、関数ごとに説明があるので、それを理解しがてら解説していく。
;; 最終系を得るには、これまで作ったリストを、alistに変換していく必要がある。

(defun make-city-edges ()
    (let* ((nodes (loop for i from 1 to *node-num* ;; 2
                    collect i))
            (edge-list (connect-all-islands nodes (make-edge-list)))
            (cops (remove-if-not (lambda (x)
                        (zerop (random *cop-odds*)))
                    edge-list)))
        (add-cops (edges-to-alist edge-list) cops))) ;; 8

;; 2で、loopを使って、ノードのリストを作る。
;; これは単純に、1からnode-numまでのリスト。
;; 次に、ランダムなエッジのリスト(完全でない可能性がある。)を作り、それをconnect-all-islandに投げることで、全てを接続する。
;; copsは、警察官がいるエッジをランダムに選んでcopsに格納する。
;; zeropは、ゼロであるか判定

;; letでは、同時に定義されっる変数を参照することができないが、
;; let*となっているものは、それができる。

;; 8:変数を初期化できたら、それをalistに変換して、警官を配置する(関数に投げる)。

(defun edges-to-alist (edge-list)
    (mapcar (lambda (node1)
            (cons node1
                (mapcar (lambda (edge)
                        (list (cdr edge)))
                    (remove-duplicates (direct-edges node1 edge-list)
                        :test #'equal)))) ;; 16
        (remove-duplicates (mapcar #'car edge-list))))

;; これは、見ればわかるように、リストをalistに変換するもの
;; 例えば、これが小さい町で、リストがこんな感じ
'((1 . 2)(2 . 1)(2 . 3)(3 . 2))
;; だった場合、alistは以下のようになる。
'((1 (2)) (2 (1) (3)) (3 (2)))
;; となる。

;; エッジリストの起点を集めるには、各リストのcarをとったものをremove duplicateすればいい(なるほど！！！)
;; 16: デフォルトで、eqlを使うが、:test でパラメータを使うことで、他のものを使うこともできる。

(defun add-cops (edge-alist edges-with-cops)
    (mapcar (lambda (x)
            (let ((node1 (car x))
                    (node1-edges (cdr x)))
                (cons node1
                    (mapcar (lambda (edge)
                            (let ((node2 (car edge)))
                                (if (intersection (edge-pairs node1 node2)
                                        edges-with-cops
                                        :test #'equal)
                                    (list node2 'cops)
                                    edge)))
                        node1-edges))))
        edge-list))

(defun neighbors (node edge-alist)
    (mapcar #'car (cdr (assoc node edge-alist))))

;; 近接するノードを返すもの。
'((1 (2 COP)) (2 (1 COP) (3)) (3 (2)))
;; (assoc node edge-alist)
(2 (1 COP) (3))
;; (cdr (assoc node edge-alist))
((1 COP) (3))
;; それぞれの要素に対して、carとる。

(defun within-one (a b edge-alist)
    (member b (neighbors a edge-alist)))
;; ある場所が、その場所と近接しているかどうか。

(defun within-two (a b edge-alist)
    (or (within-one a b edge-alist)
        (some (lambda (x)
                (within-one x b edge-alist))
            (neighbors a edge-alist))))
;; 2個以内にその町があるのかどうか。
;; orはT or 偽を返す。
;; ある場所が、隣にあるかor一個のとこにあるか。
;; someは、要素あるかどうか。一個でもあったら真を返す。

(defun make-city-node (edge-alist)
    (let (
            (wumpus (random-node))                                ;; 2
            (glow-worms (loop for i below *worm-num*              ;; 3
                    collect (random-node))))                      ;; 4
        (loop for n from 1 to *node-num*                          ;; 5
            collect (append (list n)                              ;; 6
                (cond ((equal n wumpus) '(wumpus))                ;; 7
                    ((within-two n wumpus edge-alist) '(blood!))) ;; 8
                (cond ((member n glow-worms)                      ;; 9
                        '(glow-worm))                             ;; 10
                    ((some (lambda (worm)                         ;; 11
                                (within-one n worm edge-alist))   ;; 12
                            glow-worms)                           ;; 13
                        '(lights!)))                              ;; 14
                (when (some #'car (cdr (assoc n edge-alist)))     ;; 15
                    '(sirens!))))))                               ;; 16
;; 2,3で、ワンプスと、ヤクザがいるノードをランダムに選んでいる。
;; 5で、ノード番号をループさせ、各ノードを記述するリストを、情報をappendしつつ作ってく。
