;; lambdaを使うと、名前を与えずに関数を作れる。
;; 例えば、渡した数を半分にする関数。
(defun half(x)
    (/ x 2))

#'half

(lambda (n) (/ n 2))

(mapcar (lambda (n) (/ n 2)) '(2 4 6))
;; これがマクロ
