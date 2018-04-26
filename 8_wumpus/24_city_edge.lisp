;; Use "Graph util" created in Chaptar7
(load "25_graph_util")

(defparameter *congestion-city-nodes* nil)
(defparameter *congestion-city-edges* nil)
(defparameter *visited-nodes* nil)
(defparameter *node-num* 30)
(defparameter *edge-num* 45)
(defparameter *worm-num* 3)
(defparameter *cop-odds* 15)

(defun random-node ()
    (1+ (random *node-num*)))

(defun edge-pair (a b)
    (unless (eql a b)
        (list (cons a b) (cons b a))))

(defun make-edge-list ()
    (apply #'append (loop repeat *edge-num*
            collect (edge-pair (random-node) (random-node)))))

;; これが、コンジェスチョンシティの道路の仕組み
(make-edge-list)

;; ここで、孤児ができる可能性がある
(loop repeat 10
    collect 1)

(loop for n from 1 to 10
    collect n)

;; では、この孤児を作らないようにコードを書き加える

(defun direct-edges (node edge-list)
    (remove-if-not (lambda (x)
            (eql (car x) node))
        edge-list))

(defun get-connected (node edge-list)
    (let ((visited nil))
        (labels ((traverse (node)
                (unless (member node visited)
                    (push node visited)
                    (mapc (lambda (edge)
                            (traverse (cdr edge)))
                        (direct-edges node edge-list)))))
        (traverse node))
    visited))

