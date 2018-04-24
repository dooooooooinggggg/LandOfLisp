

(defparameter *wizard-nodes* '(
        (living-room (
                you are in the living-room.
                a wizard is snoring loudly on the couch.))
        (garden (
                you are in a beauttiful gardeernn.
                there is a well in front of you.))
        (attic (
                you are in the attic.
                there is a giant welding torch in the corner.))))


(defparameter *wizard-edges* '(
        (living-room
            (garden west door)
            (attic upstairs ladder))
        (garden
            (living-room east door))
        (attic
            (living-room downstairs ladder))))




(defun dot-name(exp)
    (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string exp)))

(dot-name 'living-room)
;; "LIVING_ROOM"
(dot-name 'foo!)
;; "FOO_"

;; dotが受け付けない文字を全てアンダースコアに変換

;; もしかして、この辺って正規表現？
;; 正規表現っぽいもの

;; complementは、補集合を表すもの

;; グラフのノードにラベルをつける
(defparameter *max-label-length* 30)

(defun dot-label (exp)
    (if exp
        (let ((s (write-to-string exp :pretty nil)))
            (if (> (length s) *max-label-length*)
                (concatenate 'string (subseq s 0 (- *max-label-length* 3)) "...")
                s))
    ""))

(defun nodes->dot (nodes)
    (mapc (lambda (node)
        (fresh-line)
        (princ (dot-name (car node)))
        (princ "[label=\"")
        (princ (dot-label node))
        (princ "\"];"))
    nodes))

(nodes->dot *wizard-nodes*)

;; Break 3 [8]> (nodes->dot *wizard-nodes*)
;; LIVING_ROOM[label="(LIVING-ROOM (YOU ARE IN TH..."];
;; GARDEN[label="(GARDEN (YOU ARE IN A BEAUT..."];
;; ATTIC[label="(ATTIC (YOU ARE IN THE ATTI..."];


;; ((LIVING-ROOM (YOU ARE IN THE LIVING-ROOM. A WIZARD IS SNORING LOUDLY ON THE COUCH.))
;;  (GARDEN (YOU ARE IN A BEAUTTIFUL GARDEERNN. THERE IS A WELL IN FRONT OF YOU.))
;;  (ATTIC (YOU ARE IN THE ATTIC. THERE IS A GIANT WELDING TORCH IN THE CORNER.)))

;; エッジをDOTフォーマットに変換する。
(defun edges->dot (edges)
    (mapc (lambda (node)
            (mapc (lambda (edge)
                    (fresh-line)
                    (princ (dot-name (car node)))
                    (princ "->")
                    (princ (dot-name (car edge)))
                    (princ "[label=\"")
                    (princ (dot-label (cdr edge)))
                    (princ "\"];"))
                (cdr node)))
        edges))


;; Break 3 [8]> (edges->dot *wizard-edges*)
;; LIVING_ROOM->GARDENlabel="(WEST DOOR)"];
;; LIVING_ROOM->ATTIClabel="(UPSTAIRS LADDER)"];
;; GARDEN->LIVING_ROOMlabel="(EAST DOOR)"];
;; ATTIC->LIVING_ROOMlabel="(DOWNSTAIRS LADDER)"];
;; ((LIVING-ROOM (GARDEN WEST DOOR) (ATTIC UPSTAIRS LADDER)) (GARDEN (LIVING-ROOM EAST DOOR))
;;  (ATTIC (LIVING-ROOM DOWNSTAIRS LADDER)))

;; DOTデータを完成させる
(defun graph->dot (nodes edges)
    (princ "digraph{")
    (nodes->dot nodes)
    (edges->dot edges)
    (princ "}"))

(graph->dot *wizard-nodes* *wizard-edges*)

;; Break 4 [9]> (graph->dot *wizard-nodes* *wizard-edges*)
;; digraph{
;; LIVING_ROOM[label="(LIVING-ROOM (YOU ARE IN TH..."];
;; GARDEN[label="(GARDEN (YOU ARE IN A BEAUT..."];
;; ATTIC[label="(ATTIC (YOU ARE IN THE ATTI..."];
;; LIVING_ROOM->GARDENlabel="(WEST DOOR)"];
;; LIVING_ROOM->ATTIClabel="(UPSTAIRS LADDER)"];
;; GARDEN->LIVING_ROOMlabel="(EAST DOOR)"];
;; ATTIC->LIVING_ROOMlabel="(DOWNSTAIRS LADDER)"];}
;; "}"

(defun dot->png (fname thunk)
    (with-open-file (*standard-output*
            fname
            :direction :output
            :if-exists :supersede)
        (funcall thunk))
    (ext:shell (concatenate 'string "dot -Tpng -O " fname)))

;; LISPでは、引数を取らない関数をよく使う。
;; 今すぐに計算したくない計算がこれに当たる
;; サンク(thunk)というキーワードが出てくる。
;; コンソール出力は、副作用。

;; 直接渡すのではなく、サンクに包んで渡す。

;; ファイルへの出力。
(with-open-file (my-stream
        "tetsttfile.txt"
        :direction :output
        :if-exists :supersede)
    (princ "Hello File!" my-stream))

(defun dot->ping (fname thunk)
    (with-open-file (*standard-output*
            (concatenate 'string fname ".dot")
            :direction :output
            :if-exists :supersede)
        (funcall thunk))
    (ext:shell (concatenate 'string "dot -Tpng -O " fname)))

;; なんか、一時的に書き込まれるらしい
;; よくわからん

;; 最後に、全てのコードをまとめて、グラフにする。
(defun graph->png (fname nodes edges)
    (dot->png fname
        (lambda ()
            (graph->dot nodes edges))))

(graph->png "wizard.dot" *wizard-nodes* *wizard-edges*)


;; maplistっていうのが少し特殊
(defun uedges->dot (edges)
    (maplist (lambda (lst)
            (mapc (lambda (edge)
                    (unless (assoc (car edge) (cdr lst))
                        (fresh-line)
                        (princ (dot-name (caar lst)))
                        (princ "--")
                        (princ (dot-name (car edge)))
                        (princ "[label=\"")
                        (princ (dot-label (cdr edge)))
                        (princ "\"];")))
                (cdar lst)))
        edges))

(defun ugraph->dot (nodes edges)
    (princ "graph{")
    (nodes->dot nodes)
    (uedges->dot edges)
    (princ "}"))

(defun ugraph->png (fname nodes edges)
    (dot->png fname
        (lambda ()
            (ugraph->dot nodes edges))))

(ugraph->png "uwizard.dot" *wizard-nodes* *wizard-edges*)
