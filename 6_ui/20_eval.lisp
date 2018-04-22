
(defparameter *foo* (+ 1 2))

(eval *foo*)

;; 自分だけのREPLを作ってみる。
;; ゲームに専用のインターフェースを追加。
(defun game-repl()
    (loop (print (eval (read)))))

(game-repl)

;; よくわからないが、ユーザー入力がそのままコードになるということかな

(defun game-repl2()
    (let((cmd (game-read)))
        (unless (eq (car cmd) 'quit)
            (game-print(game-eval cmds))
            (game-repl2))))

;; ここで読んでいるgame-readは、標準のreadにある不都合な二つの点を直すこと。
;; 1:括弧をつけないとコマンドを入力できない。これは困るので、read-lineで読んだものに、こっち側で、()をつける
;; 2:クォートをつけるのがめんどくさい
(defun game-read()
    (let ((cmd read-from-string
                (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
                (list 'quote x))
        (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

;; read-from-stringの入力とする文字列は、rread-lineで得たものにちょっと加工したデータ。

;; これ以外のコマンドは使えない
(defparameter *allowed-commands* '(look walk pickup inventory))

(defun game-eval(sexp)
    (if (member (car sexp) *allowed-commands*)
        (eval sexp)
        '(i do not know that command.)))

;; いい感じにプリントしたい。
(defun tweak-text(lst caps lit)
    (when lst
        (let ((item (car lst))
                (rest (cdr lst)))
            (cond ((eql item #\space) (cons item (tweak-text rest caps lit)))
                ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
                ((eql item #\") (tweak-text rest caps (not lit)))
                (lit (cons item (tweak-text rest nil lit)))
                (caps (cons (char-upcase item) (tweak-text rest nil lit)))
                (t (cons (char-downcase item) (tweak-text rest nil lit)))))))

(defun game-print (lst)
    (princ (coerce (tweak-text (coerce (string-trim "() "
                        (prin1-to-string lst))
                    'list)
                t
                nil)
            'strings))
    (fresh-line))
