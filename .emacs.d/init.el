;; パスを通す
;; こいつが必ず先頭にくる
(let ((dir (expand-file-name "~/.emacs.d/mypackages/")))
  (if (member dir load-path) nil
    (setq load-path (cons dir load-path))
    (let ((default-directory dir))
      (load (expand-file-name "subdirs.el") t t t))))

;; 設定ファイル
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf.d/")

;; .emacs.elを終了時に自動コンパイル
(add-hook 'kill-emacs-query-functions
          (lambda ()
            (if (file-newer-than-file-p "~/.emacs.d" "~/.emacs.d/init.elc")
                (if (save-window-excursion (byte-compile-file "~/.emacs.d/init.el"))
                    t ;; 自動コンパイルに成功→ emacs を終了
                  (let (errs errl errc errp)
                    (switch-to-buffer (find-file "~/.emacs.d/init.el"))
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

;; パッケージ管理
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;;;;;;;;; For Cocoa Emacs ;;;;;;;;;;;;;;;
(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8) ;sjis-mac
(set-file-name-coding-system 'utf-8)
(if window-system
    (set-keyboard-coding-system 'utf-8)
    (show-paren-mode 1)
  (progn
    (set-keyboard-coding-system 'utf-8)
    (set-terminal-coding-system 'utf-8)))

;; Font
(create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo" 'unicode (font-spec :family "Hiragino Kaku Gothic ProN" ) nil 'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
(setq face-font-rescale-alist '((".*Hiragino.*" . 1.2) (".*Menlo.*" . 1.0)))

;; for Drag and Drop
(define-key global-map [ns-drag-file] 'ns-find-file)
(setq ns-pop-up-frames nil)

(setq default-input-method "MacOSX")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; AquaSkk用
;; (setq mac-pass-control-to-system nil) 	
;; (require 'skk-autoloads)
;; (require 'skk-tutcdef)
;; (setq skk-large-jisyo "/Users/ueda/Library/AquaSKK/SKK-JISYO.L")
;; (global-set-key "\C-xj" 'skk-mode)
;; ;(global-set-key "\C-xj" 'skk-auto-fill-mode)
;; (global-set-key "\C-xt" 'skk-tutorial)

;;PDFでプレビュー
(require 'pdf-preview)
(global-set-key "\C-cp" 'pdf-preview-buffer-with-faces)


;;補完
;;(require 'completer)
;;(setq completer-words "---. <_")

;; Emacs 23で使えない
;; ;;ファイルを開くときの補完
;; (setq hc-ctrl-x-c-is-completion t)
;; (require 'highlight-completion)
;; (highlight-completion-mode 1)
;; (global-set-key "\C-\\" 'toggle-input-method)

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

;; (global-set-key "\M-n" '(universal-argument 3 'next-line))

;; (add-hook 'c-mode-common-hook
;; 	  '(lambda ()
;; 	     ;;	     (speedbar)
;; 	     (expand-add-abbrevs c-mode-abbrev-table
;; 				 expand-c-sample-expand-list)))

;;C-uの入力を省く
;;(autoarg-mode t)

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
