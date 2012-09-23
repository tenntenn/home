;; 渡された文字列の先頭のコードを一つ増やして返す [例]"a"->"b"
(defun inc-char(str)
  (string (+ (string-to-char str) 1)))
;; 上のいろいろ版
(defun change-char(str func n)
    (string (funcall func (string-to-char str) n)))
;; 渡された数字(文字列での)を1加算して返す [例]"1"->"2"
(defun inc-num(str)
  (number-to-string (+ (string-to-int str) 1)))
;; 上のいろいろ版
(defun change-num(str func n)
  (number-to-string (funcall func (string-to-int str) n)))
;; アルファベットを数字に[例] a->0
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
;; 上の逆
(defun num->char(str)
  (let ((str2 ""))
    (mapc #'(lambda(x)
	      (setf str2(concat str2 (string (+ (- x ?0) ?a)))))
	  str)
    str2))
;; アルファベット
(defun num->char(str)
  (let ((str2 ""))
    (mapc #'(lambda(x)
	      (setf str2(concat str2 (string (+ (- x ?0) ?a)))))
	  str)
    str2))

;; 連番
(defun renban(x y)
  (concat x (change-num y #'+ replace-count)))