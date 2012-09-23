;; TexLiveにパスを通す
(setq exec-path (cons "/usr/local/texlive/2010/bin/x86_64-darwin" exec-path))
(setenv "PATH"
		(concat '"/usr/local/texlive/2010/bin/x86_64-darwin:" (getenv "PATH")))

;;yatex-mode

;;↓min-outを使用しない場合、;;@ の行は不要です。
(require 'yatex)
(setq auto-mode-alist
     (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(setq tex-command "platex -sh")
(setq bibtex-command "pbibtex")
(setq dvi2-command "xdvi")

; dviからpdfを作成する%sはファイル名
(setq dviprint-command-format " /usr/texbin/dvipdfmx %s")
(defvar yatex-mode-hook
  '(lambda ()
     ;(setq outline-regexp LaTeX-outline-regexp)			    ;;@
     ;(outline-minor-mode 1)					    ;;@
     ))
(defvar yatex-mode-load-hook
  '(lambda ()
     ;(setq-default outline-prefix-char (concat YaTeX-prefix "\C-o"));;@
     ;(require 'min-out)						    ;;@
     ;;auctex 付属の min-out.el の場合これ↓
     ;(define-key outline-minor-keymap "\C-?" 'hide-subtree)	    ;;@
     ;;Emacs 付属の outline.el の場合これ↓
     ;(define-key outline-mode-prefix-map "\C-?" 'hide-subtree)
     ;(YaTeX-define-begend-key "ba" "abstract")
     ))
;;;
;; outline-minor-mode(使用しない場合は不要です)
;;;
;; (autoload 'outline-minor-mode "min-out" t)
;; (make-variable-buffer-local 'outline-prefix-char)
;; (make-variable-buffer-local 'outline-regexp)
;; (setq  default-outline-regexp "[*\^l]+")
;; (make-variable-buffer-local 'outline-level-function)
;; (setq-default outline-level-function 'outline-level-default)
;; (setq LaTeX-outline-regexp
;;   (concat "[ \t]*" (regexp-quote "\\")
;; 	  "\\(appendix\\|documentstyle\\|part\\|chapter\\|section\\|"
;; 	  "subsection\\|subsubsection\\|paragraph\\|subparagraph\\)"
;;           "\\*?[ \t]*[[{]"))

(if (file-exists-p "~/Documents/References/")
	(setenv "BIBINPUTS" "~/Documents/References/"))
; RefTeXをYaTeXで使えるようにする
(add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))
(setq reftex-default-bibliography 
	  (if (file-exists-p "~/Documents/References/")
		  (directory-files "~/Documents/References/" t ".*\.bib$")))

;; スペルチェッカとしてaspellを指定
(setq-default ispell-program-name "aspell")
;; 日本語混じりのTeX文書でスペルチェック
(eval-after-load "ispell"
'(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; YaTeX起動時に，flyspell-modeも起動する
;;(add-hook 'yatex-mode-hook 'flyspell-mode)
;;(custom-set-variables
;; '(flyspell-auto-correct-binding [(control ?\:)]))
;;
;; text-translator  
;;ocuments 
(require 'text-translator) 
;;; キーバインド設定  
;;(global-set-key "\C-xt" 'text-translator)  
(global-set-key "\C-xt" 'text-translator-translate-by-auto-selection)  
(global-set-key "\C-x\M-T" 'text-translator-translate-last-string)    
;; デフォルト翻訳サイトの設定  
(setq text-translator-default-engine "livedoor.com_enja")
;; 自動選択に使用する関数を設定  
(setq text-translator-auto-selection-func  
      'text-translator-translate-by-auto-selection-enja)    

;; queequeg
(autoload 'qq "queequeg" nil t)
