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
