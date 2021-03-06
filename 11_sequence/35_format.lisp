(format t "Add onion rings for only ~$ dollars more!" 1.5)
;; 第一引数は、出力先
;; nil 出力する代わりに、生成されたテキストを文字列として返す。
;; t 結果をコンソールに出力
;; stream データを出力ストリームなるものに書き出す。

(princ (reverse
    (format nil "Add onion rings for only ~$ dollars more!" 1.5)))


(format t "I am printing ~s in the middle of this sentence." "foo")

(format t "I am printing ~a in the middle of this sentence." "foo")


(format t "I am printing ~10a in the middle of this sentence." "foo")

(format t "I am printing ~10@a in the middle of this sentence." "foo")

;; 数字
(format t "Tehe number 1000 in 16進数 is ~x" 1000)

(format t "Tehe number 1000 in 2進数 is ~b" 1000)

(format t "Tehe number 1000 in 10進数 is ~d" 1000)

(format t "|~{~<|~%|~,33:;~2d ~>~}|" (loop for x below 100 collect x))
