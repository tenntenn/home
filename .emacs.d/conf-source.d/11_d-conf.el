;;D言語
(defun make-d-property()
  (interactive)
  ;; プロパティ名を聞く
  (setq property-name (read-from-minibuffer "プロパティ名は？" ""))

  ;; 型名を聞く
  (setq type-name (read-from-minibuffer (format "型は？[%s]" (capitalize property-name)) ""))
  (if (string= type-name "")
      (setq type-name (capitalize property-name)))

  ;; コメントを聞く
  (setq comment (read-from-minibuffer "コメントは？" ""))

  ;; ゲッタ
  (setq getter 
	(format "/**\n * %sを取得します.\n * @return %s\n */\npublic %s %s() {\n\treturn this.__%s;\n}\n\n"
		comment comment type-name property-name property-name))

  (insert getter)  

  ;; セッタ
  (setq setter
	(format "/**\n * %sを設定します.\n * @param %s %s\n */\npublic void %s(%s %s) {\n\tthis.__%s = %s;\n}"
		comment property-name comment property-name type-name property-name property-name property-name))

  (insert setter)  
  
)
(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(setq auto-mode-alist (cons '("\\.d\\'" . d-mode ) auto-mode-alist ))
;;(autoload 'dlint-minor-mode "dlint" nil t)
(add-hook 'd-mode-hook 
	  (lambda () 
	    ;;(dlint-minor-mode 1)
	    (local-set-key "\C-c5" 'make-d-property)
	    ))
