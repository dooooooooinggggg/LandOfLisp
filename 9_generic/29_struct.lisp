
;; 構造体
(defstruct person
    name
    age
    waist-size
    favorite-color)

(defparameter *bob* (make-person :name "Bob"
        :age 35
        :waist-size 32
        :favorite-color "blue"))

;; make-personのpersonの部分は構造体に合わせて動的に生成される

;; また、ここから、ageを取り出したい場合、
(person-age *bob*)
;; とすればいい
;; setfも使える。このあたりは先ほどの配列と同じ

(defparameter *that-guy* #S(person :name "Bob" :age 35 :waist-size 32 :favorite-color "blue"))
(person-age *that-guy*)
;; 35
