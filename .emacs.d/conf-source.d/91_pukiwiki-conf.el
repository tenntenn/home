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
;; ;; 繝励Ο繧ｭ繧ｷ
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
;;
