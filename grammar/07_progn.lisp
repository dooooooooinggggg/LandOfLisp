(defvar *number-was-odd* nil)

(if (oddp 5)

    ;; 本来ifでは一つのことしかできないが、prognを使って、複数のことをしている。s
    (progn(setf *number-was-odd* t)
        'odd-number)
    'even-number)

*number-was-odd*
