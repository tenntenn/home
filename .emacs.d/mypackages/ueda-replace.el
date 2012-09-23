;; �n���ꂽ������̐擪�̃R�[�h������₵�ĕԂ� [��]"a"->"b"
(defun inc-char(str)
  (string (+ (string-to-char str) 1)))
;; ��̂��낢���
(defun change-char(str func n)
    (string (funcall func (string-to-char str) n)))
;; �n���ꂽ����(������ł�)��1���Z���ĕԂ� [��]"1"->"2"
(defun inc-num(str)
  (number-to-string (+ (string-to-int str) 1)))
;; ��̂��낢���
(defun change-num(str func n)
  (number-to-string (funcall func (string-to-int str) n)))
;; �A���t�@�x�b�g�𐔎���[��] a->0
(defun char->num(str)
  (let ((str2 ""))
    (mapc #'(lambda(x)
	      (setf str2(concat str2 (number-to-string 
				      (if (and (>= x ?a)(<= x ?z))
					  (- x ?a)
					(if (and (>= x ?A)(<= x ?Z))
					    (- x ?A)
					  0))))))
	  str)
    str2))
;; ��̋t
(defun num->char(str)
  (let ((str2 ""))
    (mapc #'(lambda(x)
	      (setf str2(concat str2 (string (+ (- x ?0) ?a)))))
	  str)
    str2))
;; �A���t�@�x�b�g
(defun num->char(str)
  (let ((str2 ""))
    (mapc #'(lambda(x)
	      (setf str2(concat str2 (string (+ (- x ?0) ?a)))))
	  str)
    str2))

;; �A��
(defun renban(x y)
  (concat x (change-num y #'+ replace-count)))