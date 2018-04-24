
(defun dot-name(exp)
    (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string exp)))

(dot-name 'living-room)
;; "LIVING_ROOM"
(dot-name 'foo!)
;; "FOO_"

;; dotが受け付けない文字を全てアンダースコアに変換

;; もしかして、この辺って正規表現？
;; 正規表現っぽいもの
