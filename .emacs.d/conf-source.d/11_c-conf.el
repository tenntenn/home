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

(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (define-key c-mode-map
	       "\M-?" 'pop-tag-mark)))
