;; condは、カッコをたくさん使う代わりに、三目のprognが使えて、複数の分岐もかける。
;; それに加えて、続けていくつもの条件を評価することもできる。

(defvar *arch-enemy* nil)

(defun pudding-eater (person)
    (cond ((eq person 'henry) (setf *arch-enemy* 'stupid-lisp-alien)
            '(curse you lisp alien - you ate my pudding))
        ((eq person 'johnny) (setf *arch-enemy* 'unless-old-johnny)
            '(i hope you choked on my pudding johnny))
        (t '(why you eat my pudding stranger?))))

(pudding-eater 'johnny)
;; (I HOPE YOU CHOKED ON MY PUDDING JOHNNY)

*arch-enemy*
;; UNLESS-OLD-JOHNNY

(pudding-eater 'geroge-clooney)
;; (WHY YOU EAT MY PUDDING STRANGER?)

(pudding-eater 'henry)
;; (CURSE YOU LISP ALIEN - YOU ATE MY PUDDING)
