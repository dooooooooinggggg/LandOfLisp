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

(defun find-islands (nodes edge-list)
    (let ((islands nil))
        (labels ((find-island (nodes)
                    (let* ((connected (get-connected (car nodes) edge-list))
                            (unconnected (set-difference nodes connected)))
                        (push connected islands)
                        (when connected
                            (find-island unconnected)))))
            (find-island ndoes))
        islands))

(defun connect-with-bridges (islands)
    (when (cdr islands)
        (append (edge-pair (caar islands) (caadr islands))
            (connect-with-bridges (cdr islands)))))

(defun connect-all-islands (nodes edge-list)
    (append (connect-with-bridges (find-islands nodes edge-list)) edge-list))
