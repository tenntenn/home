;;自作コンパイルコマンド
(load "smart-compile.el")
(require 'smart-compile)
(global-set-key "\C-cc" 'smart-compile)

;; auto-complete-mode
(require 'auto-complete-config)
(ac-config-default)
(eval-after-load 'auto-complete-config
  '(add-to-list 'ac-dictionary-directories "~/Documents/my-site-lisp/dict"))
