(if (member nil '(3 4 nil 6))
    'nil-is-in-the-list
    'nil-is-not-in-the-list)

(if (member nil '(3 4 nil))
    'nil-is-in-the-list
    'nil-is-not-in-the-list)
