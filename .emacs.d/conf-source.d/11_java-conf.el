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
