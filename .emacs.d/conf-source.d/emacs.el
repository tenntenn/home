;; パスを通す
;; こいつが必ず先頭にくる
(let ((dir (expand-file-name "~/Documents/my-site-lisp/")))
  (if (member dir load-path) nil
    (setq load-path (cons dir load-path))
    (let ((default-directory dir))
      (load (expand-file-name "subdirs.el") t t t))))

;; .emacs.elを終了時に自動コンパイル
(add-hook 'kill-emacs-query-functions
          (lambda ()
            (if (file-newer-than-file-p "~/.emacs.el" "~/.emacs.elc")
                (if (save-window-excursion (byte-compile-file "~/.emacs.el"))
                    t ;; 自動コンパイルに成功→ emacs を終了
                  (let (errs errl errc errp)
                    (switch-to-buffer (find-file "~/.emacs.el"))
                    (with-current-buffer "*Compile-Log*"
                      (goto-char (point-max))
                      (forward-line -1)
                      ;; *Compile-Log* がエラー箇所の情報を含まないときだけ
                      ;;  *Compiler Input* に基づきジャンプ
                      (cond ((re-search-forward
                              "^.+:\\(.+\\):\\(.+\\):Error: \\(.+\\)$" nil t)
                             (setq errl (string-to-number (match-string 1))
                                   errc (string-to-number (match-string 2))
                                   errs (match-string 3)))
                            ((re-search-forward "!! \\(.+\\)" nil t)
                             (setq errp (with-current-buffer " *Compiler Input*"
                                          (point))
                                   errs (match-string 1)))))
                    (cond (errp (unless (= errp (point-max)) (goto-char errp)))
                          (t (goto-line errl) (forward-char errc)))
                    (message errs)
                    nil)) ;; 自動コンパイルに失敗→ emacs を終了しない
              t))) ;; ファイルが更新されていない→ emacs を終了

;; 速度アップのため
;; http://sheephead.homelinux.org/2010/11/12/6288/
(require 'idle-require)
(setq idle-require-symbols '(cedet nxml-mode)) ;; <- Specify packages here.
(idle-require 'cedet) ;; <- Or like this.
(idle-require-mode 1)

;; /usr/local/binにパスを通す
(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH"
		(concat '"/usr/local/bin:" (getenv "PATH")))

;; PkgConfig
(setenv "PKG_CONFIG_PATH" (concat (getenv "PKG_CONFIG_PATH") "/usr/local/lib/pkgconfig"))

;; カーソルでフレーム間を移動
(windmove-default-keybindings)
(global-set-key "\C-c\C-b" 'windmove-left)
(global-set-key "\C-c\C-f" 'windmove-right)
(global-set-key "\C-c\C-p" 'windmove-up)
(global-set-key "\C-c\C-n" 'windmove-down)

;; \C-hで一文字消す(バックスペース)
(global-set-key "\C-h" 'delete-backward-char)

;;;;;;;;;;;; For Cocoa Emacs ;;;;;;;;;;;;;;;
;; -*- Coding: iso-2022-jp -*-
(set-language-environment 'Japanese)
(set-default-coding-systems 'sjis-dos)
(set-buffer-file-coding-system 'sjis-dos)
(set-clipboard-coding-system 'sjis-mac)
(set-file-name-coding-system 'utf-8)
(if window-system
    (set-keyboard-coding-system 'sjis)
    (show-paren-mode 1)
  (progn
    (set-keyboard-coding-system 'sjis-dos)
    (set-terminal-coding-system 'sjis-dos)))

;; translate clipboard 
  (set-selection-coding-system 'sjis-mac) 

;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))


;; Display Line Number
(global-set-key "\M-n" 'linum-mode)


;; Font
(create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo" 'unicode (font-spec :family "Hiragino Kaku Gothic ProN" ) nil 'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
(setq face-font-rescale-alist '((".*Hiragino.*" . 1.2) (".*Menlo.*" . 1.0)))

;; for Drag and Drop
(define-key global-map [ns-drag-file] 'ns-find-file)
(setq ns-pop-up-frames nil)

(setq default-input-method "MacOSX")

;; バックスラッシュ
(define-key global-map [?¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; タブ
(setq-default tab-width 4)

;; 行番号
(require 'linum)

(setq linum-format
      '(lambda (line)
        (let ((fmt
               (let ((min-w 4)
                     (w (length (number-to-string
                                 (count-lines (point-min) (point-max))))))
                 (concat "%"
                         (number-to-string (if (< min-w w) w min-w))
                         "d"))))
          (propertize (format fmt line) 'face 'linum))))
(global-linum-mode)

;; Info
(setq Info-directory-list 
    (list "/usr/info" "/usr/local/info" "~/info/"))
(require 'info-look)
(info-lookup-add-help
  :mode 'lisp-mode
  :regexp "[^][()'\" \t\n]+"
  :ignore-case t
  :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))
(add-hook 'lisp-mode-hook (lambda () (global-set-key "\C-ci" 'info-lookup-symbol)))

;色を付ける
(global-font-lock-mode t)
;;音がうざい
(setq visible-bell t)

(global-set-key "\C-c3" 'smart-compile)

(global-set-key "\C-c4" 'eval-region)


;; AquaSkk用
;; (setq mac-pass-control-to-system nil) 	
;; (require 'skk-autoloads)
;; (require 'skk-tutcdef)
;; (setq skk-large-jisyo "/Users/ueda/Library/AquaSKK/SKK-JISYO.L")
;; (global-set-key "\C-xj" 'skk-mode)
;; ;(global-set-key "\C-xj" 'skk-auto-fill-mode)
;; (global-set-key "\C-xt" 'skk-tutorial)

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
(setenv "BIBINPUTS" "/Users/ueda/Documents/References/")
; RefTeXをYaTeXで使えるようにする
(add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))
(setq reftex-default-bibliography 
      (directory-files "/Users/ueda/Documents/References/" t ".*\.bib$"))

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

;; ;;日本語
(set-default-coding-systems 'shift_jis)
(set-terminal-coding-system 'shift_jis)

;;自作コンパイルコマンド
(load "smart-compile.el")
(require 'smart-compile)
(global-set-key "\C-cc" 'smart-compile)

;;ウィンドウの大きさ
(setq initial-frame-alist '((top 0) (left 2) (width . 200) (height . 50)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; JDEE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 基本
;; (require 'jde)
;; (autoload 'jde-mode "jde" "Java Development Environment for Emacs." t)
;; (setq auto-mode-alist (cons '("\.java$" . jde-mode) auto-mode-alist))

;; ;; ユーザ名
;; (setq user-full-name "Takuya Ueda")

;; ;; インデント
;; (add-hook 'jde-mode-hook
;;           '(lambda ()
;;              (c-set-offset 'arglist-intro '+)
;;              (c-set-offset 'arglist-close 0)
;; 	     (c-set-offset 'topmost-intro-cont 0)
;;              (c-set-offset 'func-decl-cont 0)
;;              (setq indent-tabs-mode nil)
;;             ))

;; ;;モード行のEncoded-kbdを消去する
;; (let ((elem (assq 'encoded-kbd-mode minor-mode-alist)))
;;   (when elem
;;     (setcar (cdr elem) "")))

;; ;;CEDET
;; ;; (setq semantic-load-turn-useful-things-on t)
;; ;; (load "cedet")

;; ;; abbrev
;; (global-set-key "\C-xSPC" 'expand-abbrev)

;; ;; ;; EDE
;; ;; (require 'ede)
;; ;; (global-ede-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;PDFでプレビュー
(require 'pdf-preview)
(global-set-key "\C-cp" 'pdf-preview-buffer-with-faces)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  C言語  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ソースとヘッダを切り替える
(global-set-key "\C-c1" 'ff-find-other-file)

;;#の補完
(setq c-mode-common-hook
      '(lambda ()
	 (let ()
	   (c-set-offset 'statement-cont 'c-lineup-math))))
(add-hook 'c-mode-common-hook
	  (function (lambda ()
		      (set-default-coding-systems 'utf-8)
		      (set-terminal-coding-system 'utf-8)
		      (require 'cpp-complt)
		      (define-key c-mode-map [mouse-2]
			'cpp-complt-include-mouse-select)
		      (define-key c-mode-map "#"
			'cpp-complt-instruction-completing)
		      (define-key c-mode-map "\C-c#"
			'cpp-complt-ifdef-region)
		      (cpp-complt-init))))

(setq cpp-complt-standard-header-path ;;補完するヘッダファイルのパス
      (list "/usr/include/" "/usr/local/include/"))
;; タグをつくらずにジャンプ
;; (require 'imenu)
;; (defcustom imenu-modes
;;   '(emacs-lisp-mode c-mode c++-mode makefile-mode)
;;   "List of major modes for which Imenu mode should be used."
;;   :group 'imenu
;;   :type '(choice (const :tag "All modes" t)
;; 		 (repeat (symbol :tag "Major mode"))))
;; (defun my-imenu-ff-hook ()
;;   "File find hook for Imenu mode."
;;   (if (member major-mode imenu-modes)
;;       (imenu-add-to-menubar "imenu")))
;; (add-hook 'find-file-hooks 'my-imenu-ff-hook t)

;;(global-set-key "\C-cg" 'imenu)

;; (defadvice imenu--completion-buffer
;;   (around mcomplete activate preactivate)
;;   "Support for mcomplete-mode."
;;   (require 'mcomplete)
;;   (let ((imenu-always-use-completion-buffer-p 'never)
;; 	(mode mcomplete-mode)
;; 	;; the order of completion methods
;; 	(mcomplete-default-method-set '(mcomplete-substr-method
;; 					mcomplete-prefix-method))
;; 	;; when to display completion candidates in the minibuffer
;; 	(mcomplete-default-exhibit-start-chars 0)
;; 	(completion-ignore-case t))
;;     ;; display *Completions* buffer on entering the minibuffer
;;     (setq unread-command-events
;; 	  (cons (funcall (if (fboundp 'character-to-event)
;; 			     'character-to-event
;; 			   'identity)
;; 			 ?\?)
;; 		unread-command-events))
;;     (turn-on-mcomplete-mode)
;;     (unwind-protect
;; 	ad-do-it
;;       (unless mode
;; 	(turn-off-mcomplete-mode)))))

;;関数一覧
;; (autoload 'se/make-summary-buffer "summarye" nil t)
;; (add-hook 'c-mode-common-hook
;; 	  (function (lambda ()
;; 		      (define-key c-mode-map
;; 			"\C-cl" 'se/make-summary-buffer))))
;;ソースの書式をそろえる
;;(load "develock")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;補完
;;(require 'completer)
;;(setq completer-words "---. <_")

;; Emacs 23で使えない
;; ;;ファイルを開くときの補完
;; (setq hc-ctrl-x-c-is-completion t)
;; (require 'highlight-completion)
;; (highlight-completion-mode 1)
;; (global-set-key "\C-\\" 'toggle-input-method)

;;バッファの切り替えを便利に
(iswitchb-mode)
(add-hook 'iswitchb-define-mode-map-hook
	  'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match))

;;itchb に候補が なければ find-fileにする
(defun iswitchb-possible-new-buffer (buf)
  "Possibly create and visit a new buffer called BUF."
  (interactive)
  (message (format
	    "No buffer matching `%s', "
	    buf))
  (sit-for 1)
  (call-interactively 'find-file buf))
(defun iswitchb-buffer (arg)
  "Switch to another buffer.

The buffer name is selected interactively by typing a substring.  The
buffer is displayed according to `iswitchb-default-method' -- the
default is to show it in the same window, unless it is already visible
in another frame.
For details of keybindings, do `\\[describe-function] iswitchb'."
  (interactive "P")
  (if arg
      (call-interactively 'switch-to-buffer)
    (setq iswitchb-method iswitchb-default-method)
    (iswitchb)))
;;;


;;現在カーソルがある行を強調表示する
(setq hl-line-face 'underline)
(global-hl-line-mode)

;;補完の終了した補完ウィンドウを閉じる
(require 'lcomp)
(lcomp-install)

;;簡単なマクロ
(defconst *dmacro-key* "\C-^" "繰返し指定キー")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)

;;kill-ringを表示
(require 'browse-kill-ring)
(global-set-key "\M-y" 'browse-kill-ring)

;;アウトラインモード
;; (make-variable-buffer-local 'outline-level)
;; (setq-default outline-level 'outline-level)
;; (make-variable-buffer-local 'outline-heading-end-regexp)
;; (setq-default outline-heading-end-regexp "\n")
;; (make-variable-buffer-local 'outline-regexp)
;; (add-hook 'lisp-interaction-mode-hook
;; 	  '(lambda ()
;; 	     (setq outline-regexp "[;\f]+")
;; 	     (outline-minor-mode t)))
;; (add-hook 'emacs-lisp-mode-hook
;; 	  '(lambda ()
;; 	     (setq outline-regexp "[;\f]+")
;; 	     (outline-minor-mode t)))
;; (add-hook 'c-mode-common-hook
;; 	  '(lambda ()
;; 	     (setq outline-regexp "^[{}]+")
;; 	     (outline-minor-mode t)))
;; (add-hook 'text-mode-hook
;; 	  '(lambda ()
;; 	     (setq outline-regexp "^\*")
;; 	     (outline-minor-mode t)))
;; (global-set-key "\C-c^"   'outline-toggle-children)


;; (defun c-mode-return-key (arg)
;;   (interactive "P")
;;   (let (pos)
;;     (setq pos (point))
;;     (beginning-of-line)
;;     (if (re-search-forward
;; 	 "^\\({\\)"
;; 	 (line-end-position) t)
;; 	(if (= (line-end-position)
;; 	       (next-overlay-change (point)))
;; 	    (if arg
;; 		(outline-toggle-children)
;; 	      (outline-toggle-children))
;; 	  (if arg
;; 	      (outline-toggle-children)
;; 	    (outline-toggle-children))
;; 	  (beginning-of-line))
;;       (goto-char pos)
;;       (newline-and-indent))))

;; (add-hook 'c-mode-common-hook
;; 	  '(lambda ()
;; 	     (define-key c-mode-map
;; 	       "\C-m" 'c-mode-return-key)))
;; (defun c-mode-outline-toggle-children(arg)
;;   (interactive "P")
;;   (c-beginning-of-defun)
;;   (search-forward "{" )
;;   (outline-toggle-children))
;; (add-hook 'c-mode-common-hook
;; 	  '(lambda ()
;; 	     (define-key c-mode-map
;; 	       "\C-\M-j" 'c-mode-outline-toggle-children)))

(global-set-key "\C-c2" 'speedbar)
(global-set-key "\C-co" 'other-frame)
(add-hook 'speedbar-load-hook
	  '(lambda()
	     (setq initial-frame-alist
		   '((top 0) (left 0) (width . 112) (height . 45)))))
;; (global-set-key "\M-n" '(universal-argument 3 'next-line))

;; (add-hook 'c-mode-common-hook
;; 	  '(lambda ()
;; 	     ;;	     (speedbar)
;; 	     (expand-add-abbrevs c-mode-abbrev-table
;; 				 expand-c-sample-expand-list)))

;;C-uの入力を省く
;;(autoarg-mode t)

;;最近開いたファイル
(recentf-mode 1)
(global-set-key "\C-cro" 'recentf-open-files)

;;開いていたバッファを記録しておく
;;;; 保存しないファイルの正規表現
;; (setq desktop-files-not-to-save "\\(^/[^/:]*:\\|\\.diary$\\)")
;; (autoload 'desktop-save "desktop" nil t)
;; (autoload 'desktop-clear "desktop" nil t)
;; (autoload 'desktop-load-default "desktop" nil t)
;; (autoload 'desktop-remove "desktop" nil t)

;;diredの拡張"\C-x \C-j"で開くなど
(load "dired-x")
(load "my-dired-mode")

;;; sdic-mode 用の設定
;; (require 'expand)
;; (load "sdic.el")
;; (autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
;; (global-set-key "\C-cw" 'sdic-describe-word)
;; (autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
;; (global-set-key "\C-cW" 'sdic-describe-word-at-point)
;; (setq sdic-eiwa-dictionary-list '((sdicf-client "/Users/ueda/Documents/sdic/EIJIRO80.sdic"))
;;       sdic-waei-dictionary-list '((sdicf-client "/Users/ueda/Documents/sdic/WAEIJI80.sdic"
;;                                                 (add-keys-to-headword t))))

;;w3m
;;(require 'w3m-load)

;;１段落の文字数
(setq fill-column 60)


;;自動改行
(turn-on-auto-fill)

;;物理移動
;; (load "physical-line")
;; (physical-line-on)
;; ;; dired-mode では使わない
;; (setq physical-line-ignoring-mode-list '(dired-mode))
;; (global-set-key "\C-p" 'previous-window-line)
;; (global-set-key "\C-n" 'next-window-line)
(global-set-key [up] 'scroll-down)
(global-set-key [down] 'scroll-up)
(global-set-key [left] 'move-beginning-of-line)
(global-set-key [right] 'move-end-of-line)

(defun previous-window-line (n)
  (interactive "p")
  (let ((cur-col
	 (- (current-column)
	    (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion (- n))
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook))
(defun next-window-line (n)
  (interactive "p")
  (let ((cur-colprevious-window-line
	 (- (current-column)
	    (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion n)
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook))

(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (define-key c-mode-map
	       "\M-?" 'pop-tag-mark)))

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

;;dismal
;;(load "dismal-1.4/dismal-mode-defaults.el")

;;データベース
;; (setq load-path (cons (expand-file-name "edb-1.25") load-path))
;; (autoload 'db-find-file "database" "EDB database package" t)
;; (autoload 'load-database "database" "EDB database package" t)
;; (autoload 'byte-compile-database "database" "EDB database package" t)

;;スプレッドシート
;; (autoload 'ses-mode "ses/ses.el" "Spreadsheet mode" t)
;;esheet
;; (autoload 'esheet-mode "esheet/esheet.el" "makes emacs act like a spreadsheet" t)
;; (autoload 'csv-mode "esheet/esheet.el" "makes emacs act like a spreadsheet" t)
;; (setq auto-mode-alist (cons (cons "\\.esh\\'" 'esheet-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons (cons "\\.csv\\'" 'csv-mode) auto-mode-alist))
;; (load "spread.el")

;;左側に行番号
;;wb-line-number
;; (set-scroll-bar-mode nil)
;; (require 'wb-line-number)
;; (setq truncate-partial-width-windows nil)
;; (setq wb-line-number-scroll-bar nil)
;; (setq wb-line-number-text-width 6)
;; (global-set-key "\C-cl" 'wb-line-number-toggle)

;;SPICE
;; (load "spice-mode.el")

;;絵を描く
;; (autoload 'artist-mode "artist" "Enter artist-mode" t)

;;バックアップファイルを一ヶ所に
(require 'backup-dir)
(setq bkup-backup-directory-info
      '(("/home/greg/.*" "/~/.backups/" ok-create full-path prepend-name)
	("^/[^/:]+:"     ".backups/") ; handle EFS files specially: don't
	("^/[^/:]+:"     "./")        ; search-upward... its very slow
	(t               ".backups/"
			 full-path prepend-name search-upward)))

;;gtags
;; (autoload 'gtags-mode "gtags" "" t)
;; (setq gtags-mode-hook
;;      '(lambda ()
;; 	 (local-set-key "\M-t" 'gtags-find-tag)
;; 	 (local-set-key "\M-r" 'gtags-find-rtag)
;; 	 (local-set-key "\M-s" 'gtags-find-symbol)
;; 	 (local-set-key "\C-t" 'gtags-pop-stack)))
;; (setq gtags-rootdir ".")
;; (defun gtags-init()
;;   (interactive)
;;   (shell-command (concat "/usr/local/bin/gtags " gtags-place))
;;   (gtags-mode 1)
;;   (gtags-make-complete-list))
;; (add-hook 'c-mode-common-hook
;; 	  '(lambda()
;; 	     (gtags-mode t)))
;; 	     (gtags-init)
;; 	     (local-set-key "\C-cg" 'gtags-init)))

;;LookUp
;; (autoload 'lookup "lookup" nil t)
;;   (autoload 'lookup-region "lookup" nil t)
;;   (autoload 'lookup-pattern "lookup" nil t)
;;   (setq lookup-search-agents '(
;; 			       (eblook "~/Documents/dict/daijirin")
;; 			       ))

;;magicpoint
;; (setq auto-mode-alist
;;       (cons (cons "\\.mgp$" 'mgp-mode) auto-mode-alist))
;; (autoload 'mgp-mode "mgp-mode.el" nil t)

;;goby
;; (autoload 'goby "goby" nil t)

;;elscreen
;; (load "elscreen.el" "ElScreen" t)
;; (load "elscreen-dired.el" "ElScreen" t)
;; (load "elscreen-goby.el" "ElScreen" t)
;; (load "elscreen-howm.el" "ElScreen" t)
;; (load "elscreen-server.el" "ElScreen" t)
;; (load "elscreen-w3m.el" "ElScreen" t)
;; (load "elscreen-wl.el" "ElScreen" t)
;; (load "elscreen-gf" "ElScreen" t)

;;howm
;; (setq howm-menu-lang 'ja)
;; (global-set-key "\C-c,," 'howm-menu)
;; (autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/howm/")

;;hownmoney
;; (load "howmoney.el")

;; mmm-mode
;; (require 'mmm-mode)
;; (setq mmm-global-mode 'maybe)
;; 色設定．これは，好みで．色をつけたくないなら nil にします．
;; (set-face-background 'mmm-default-submode-face "navy")
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(jde-built-class-path (quote ("/System/Library/Frameworks/JavaVM.framework/Classes/")))
;;  '(jde-compiler (quote ("javac" "/usr/bin/javac")))
;;  '(jde-jdk-registry (quote (("1.4.2" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.4.2/Home"))))
;;  '(speedbar-frame-parameters (quote ((minibuffer) (width . 20) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (top . 0) (left . 860)))))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )

;; (put 'narrow-to-page 'disabled nil)
;; (put 'narrow-to-region 'disabled nil)
;; (defun narrow-to-next-defun()
;;   (interactive)
;;   (narrow-to-defun)
;;   (end-of-buffer)
;;   (narrow-to-defun))
;; (global-set-key "\C-x n n" 'narrow-to-next-defun)

;gnuplot-mode
(setq auto-mode-alist
      (cons (cons "\\.plt$" 'gnuplot-mode) auto-mode-alist))

;ECB
;;(require 'ecb)

;文字数カウント
(autoload 'word-count-mode "word-count"
          "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)

;;重複した行を消す
;;連続した行 M-x uniq-region
;;重複した行 M-x uniq-remove-dup-lines
(load "uniq")

;;ある辞典まで戻す
(require 'undo-group)
;; グループアンドゥ
(global-set-key "\M-]" 'undo-group)
;; グループアンドゥの記録
(global-set-key "\M-}" 'undo-group-boundary)
(defadvice save-buffer
  (after advice-by-undo-group activate)
  (if buffer-undo-list
      ()
    (undo-group-boundary)))

;;しおり
(require 'bm)
(global-set-key "\C-c;" 'bm-previous)
(global-set-key "\C-c:" 'bm-next)
(global-set-key "\M-?" 'bm-toggle)
;; ;;移動前に現在行をしおりに追加
;; (defun bm-set-bookmark-befor-goto ()
;;   (if (or (bm-bookmark-at (point))
;;           (string= last-command 'bm-next)
;;           (string= last-command 'bm-previous))
;;       ()
;;     (bm-toggle))
;;   )
;; (defadvice bm-goto  (before set-bookmark-before-next activate)
;;   "advice"
;;   (bm-set-bookmark-befor-goto)
;;   )

;;;;;;;;;;;;;;;;;;;;;;;;;;;; SLIME ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; SLIME
;; (require 'slime)
;; (setq slime-net-coding-system 'utf-8-unix)
;; (add-hook 'lisp-mode-hook (lambda ()
;;                             (slime-mode t)
;;                             (show-paren-mode)))
;; (add-hook 'slime-mode-hook
;;           (lambda ()
;;             (setq lisp-indent-function 'common-lisp-indent-function)))
;; (add-hook 'inferior-lisp-mode-hook
;;           (lambda ()
;;             (slime-mode t)
;;             (show-paren-mode)))
;; (setq inferior-lisp-program "/usr/local/bin/sbcl")

;; ;; Additional definitions by Pierpaolo Bernardi.
;; (defun cl-indent (sym indent)
;;   (put sym 'common-lisp-indent-function
;;        (if (symbolp indent)
;;            (get indent 'common-lisp-indent-function)
;;          indent)))

;; (cl-indent 'if '1)
;; (cl-indent 'generic-flet 'flet)
;; (cl-indent 'generic-labels 'labels)
;; (cl-indent 'with-accessors 'multiple-value-bind)
;; (cl-indent 'with-added-methods '((1 4 ((&whole 1))) (2 &body)))
;; (cl-indent 'with-condition-restarts '((1 4 ((&whole 1))) (2 &body)))
;; (cl-indent 'with-simple-restart '((1 4 ((&whole 1))) (2 &body)))

;; (setq slme-lisp-implementations
;;       '((sbcl ("sbcl") :coding-system utf-8-unix)
;;         (cmucl ("cmucl") :coding-system iso-latin-1-unix)))

;; ;; CMUCL
;; ;(defun cmucl-start ()
;; ;  (interactive)
;; ;  (shell-command ""))

;; ;; SBCL
;; (defun sbcl-start ()
;;   (interactive)
;;   (shell-command "sbcl --core ~/Documents/sbcl/mylisp.core --load ~/.slime.lisp &"))

;; ;; GNU CLISP
;; (defun clisp-start ()
;;   (interactive)
;;   (shell-command (format "clisp -K full -q -ansi -i %s/.slime.l &" (getenv "HOME"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Muse
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'muse-mode)                    ; load authoring mode
;; (require 'muse-html)
;; (require 'muse-blosxom)
;; ;;(require 'muse-latex)
;; ;;(require 'muse-texinfo)
;; ;;(require 'muse-docbook)
;; (require 'muse-wiki)
;; (require 'muse-project)
;; ;; HTMLのエンコード
;; (setq muse-html-encoding-default 'shift_jis)
;; ;; hook
;; (setq
;;  muse-mode-hook
;;  '(lambda ()
;;     (setq outline-regexp "*+")
;;     (setq outline-minor-mode t)
;;     (setq coding-system-for-write 'shift_jis)
;;     (if (string-equal (car muse-current-project) "Report")
;;         (setq
;;          muse-current-project
;;          `("Report"
;;            (,(eval default-directory) :default "index")
;;            (:base "latex" :path ,(concat (eval default-directory) "../tex")))))))

;; (add-to-list 'muse-project-alist
;;              '("Default"
;;                ("~/muse/default" :default "index")
;;                (:base "blosxom" :path "~/WebMuse")))

;; (add-to-list 'muse-project-alist
;;              '("Emacs"
;;                ("~/muse/emacs" :default "index")
;;                (:base "blosxom" :path "~/WebMuse/emacs")))

;; (add-to-list 'muse-project-alist
;;              '("Lab"
;;                ("~/muse/lab" :default "index")
;;                (:base "blosxom" :path "~/WebMuse/lab")))

;; (add-to-list 'muse-project-alist
;;              '("Life"
;;                ("~/muse/life" :default "index")
;;                (:base "blosxom" :path "~/WebMuse/life")))

;; (add-to-list 'muse-project-alist
;;              '("Software"
;;                ("~/muse/software" :default "index")
;;                (:base "blosxom" :path "~/WebMuse/software")))

;; (add-to-list 'muse-project-alist
;;              '("Report"
;;                ("../muse" :default "index")
;;                (:base "latex" :path "../tex")))

;; (setq muse-file-extension nil muse-mode-auto-p t)

;; ;; .DS_storeファイルを編集から除外
;; (add-to-list 'muse-ignored-extensions "DS_store")
;; ;; スタイルシート
;; (setq muse-html-style-sheet
;;       "<link rel=\"stylesheet\" type=\"text/css\" charset=\"shift-jis\" media=\"all\" href=\"rubyStyle.css\">")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pukiwiki Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'pukiwiki-mode)
;; (setq pukiwiki-auto-insert t)
;; (autoload 'pukiwiki-edit
;;   "pukiwiki-mode" "pukwiki-mode." t)
;; (autoload 'pukiwiki-index
;;   "pukiwiki-mode" "pukwiki-mode." t)
;; (autoload 'pukiwiki-edit-url
;;   "pukiwiki-mode" "pukwiki-mode." t)
;; (setq
;;  pukiwiki-site-list
;;  '(("Junkyard"
;;     "http://junkyard-taku.sytes.net/~taku/cgi-bin/"
;;     nil euc-jp-dos)
;;    ("Personal Junkyard"
;;     "http://localhost:8888/pukiwiki/"
;;     nil euc-jp-dos)
;;    ))
;; ;; プロキシ
;; (setq http-proxy-server "133.15.120.1")
;; (setq http-proxy-port 3128)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;ChangeLog
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(bsh-vm-args (quote ("-Duser.language=en")))
 '(ecb-options-version "2.32")
 '(emacs-wiki-meta-content-coding "shift_jis")
 '(jde-ant-enable-find t)
 '(jde-ant-program "/usr/bin/ant")
 '(jde-ant-read-target t)
 '(jde-bug-debug t)
 '(jde-bug-jre-home "/System/Library/Frameworks/JavaVM.framework/Home")
 '(jde-bug-local-variables t)
 '(jde-build-function (quote (jde-ant-build)))
 '(jde-compile-finish-hook (quote (jde-compile-finish-refresh-speedbar jde-compile-finish-update-class-info)))
 '(jde-compiler (quote ("javac" "/usr/bin/javac")))
 '(jde-debugger (quote ("JDEbug")))
 '(jde-help-docsets (quote (("JDK API" "/Users/ueda/Documents/JavaLibrary/docs/ja/api" nil) ("User (javadoc)" "/Users/ueda/Documents/program/java/Projects/Cat/doc" nil))))
 '(jde-jdk-doc-url "http://java.sun.com/javase/ja/6/docs/ja/api/")
 '(jde-jdk-registry (quote (("1.5.0" . "/System/Library/Frameworks/JavaVM.framework/"))))
 '(jde-sourcepath (quote ("/Users/ueda/Documents/program/java/Projects/Cat/src")))
 '(jde-wiz-get-set-variable-convention (quote ("m_[ndcb(obj)]" . "Prefix")))
 '(jde-wiz-get-set-variable-prefix "")
 '(url-proxy-services (quote (("3128" . "133.15.120.1")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(emacs-wiki-bad-link-face ((t (:foreground "red" :box (:line-width 2 :color "grey75" :style released-button) :underline "red" :weight bold)))))

;; Scheme
(require 'gauche-mode)
(setq scheme-program-name "gosh -i")
(setq auto-mode-alist
     (cons (cons "\\.scm$" 'gauche-mode) auto-mode-alist))
(autoload 'gauche-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun scheme-other-window()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*gauche*"))
  (run-scheme scheme-program-name))

(define-key global-map
    "\C-cs" 'scheme-other-window)
;;

(autoload 'ispell-word "ispell" "Check the spelling of word in buffer." t)
(autoload 'ispell-region "ispell" "Check the spelling of region." t)
(autoload 'ispell-buffer "ispell" "Check the spelling of buffer." t)
(autoload 'ispell-complete-word "ispell" "Look up current word in dictionary and try to complete it." t)
(autoload 'ispell-change-dictionary "ispell" "Change ispell dictionary." t)
(autoload 'ispell-message "ispell" "Check spelling of mail message or newsx post.")
(defun ispell-tex-buffer-p ()
 (memq major-mode '(plain-tex-mode latex-mode slitex-mode yatex-mode)))
(setq ispell-enable-tex-parser t)
;; 日本語交じりの文書を扱う
(eval-after-load "ispell"
 '(add-to-list 'ispell-skip-region-alist '("[^¥000-¥377]+")))
;; latex 文書を扱う
(setq ispell-filter-hook-args '("-w"))
(setq TeX-mode-hook
     (function
      (lambda ()
        (setq ispell-filter-hook "detex"))))
;; ispell の代わりに aspell を使う
(setq-default ispell-program-name "aspell")
;;; その他
;;; /etc/aspell.conf てファイルを作って、中身は、
;;; lang en_US で書いておく。


;; 分割情報を保存 — windows 
;; キーバインドを変更．
;; デフォルトは C-c C-w
;; 変更しない場合」は，以下の 3 行を削除する
;; (setq win:switch-prefix "\C-z")
;; (define-key global-map win:switch-prefix nil)
;; (define-key global-map "\C-z1" 'win-switch-to-window)
;; (require 'windows)
;; ;; 新規にフレームを作らない
;; (setq win:use-frame nil)
;; (win:startup-with-window)
;; (define-key ctl-x-map "C" 'see-you-again)
;; (setq win:quick-selection nil)

;; Vala
(require 'vala-mode)
(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))

;; Graphviz
(load "graphviz-dot-mode.el")

;; auto-complete-mode
(require 'auto-complete-config)
(ac-config-default)
(eval-after-load 'auto-complete-config
  '(add-to-list 'ac-dictionary-directories "~/Documents/my-site-lisp/dict"))

;; Go mode
(require 'go-mode-load)
(setq exec-path (cons "/usr/local/go/bin" exec-path))
(setenv "PATH"
		(concat '"/usr/local/go/bin:" (getenv "PATH")))
(require 'go-autocomplete)
(add-hook 'go-mode-hook
	  '(lambda ()		 
	     (setq tab-width 4)
		 (set-default-coding-systems 'utf-8)
	     ))

;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/Documents/my-site-lisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)             ; 互換性確保

;; 高速化のため
;; http://d.hatena.ne.jp/tettsyun/20100403/1270323183
(modify-frame-parameters nil '((wait-for-wm . nil)))

;; SVN
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(add-hook 'dired-mode-hook
          '(lambda ()
             (require 'dired-x)
             ;;(define-key dired-mode-map "V" 'cvs-examine)
             (define-key dired-mode-map "V" 'svn-status)
             (turn-on-font-lock)
             ))

;; Coffe Script
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-hook 'coffee-mode-hook
		  '(lambda ()
			 (set-default-coding-systems 'utf-8)
			 ))

;;haml-mode
(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

;;sass-mode
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;; scss-mode
(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; JSON
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))

;; scala-mode
(add-to-list 'load-path "~/Documents/my-site-lisp/scala-mode")
(require 'scala-mode-auto)

;; Markdown
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
	  (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)
