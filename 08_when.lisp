(defvar *number-is-odd* nil)

;; ifではなく、whenを使うことによって、暗黙のprogn
(when (oddp 5)
    (setf *number-is-odd* t)
    'odd-number)

*number-is-odd*

(unless (oddp 4)
    (setf *number-is-odd* nil)
    'even-number)

*number-is-odd*

;; あれ、ifは？
;; ああ、片っぽしか実行しない時のことか。
