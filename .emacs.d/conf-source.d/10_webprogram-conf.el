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
(setq scss-compile-at-save nil) 
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; JSON
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))

;; scala-mode
(require 'scala-mode-auto)

;; Markdown
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
	  (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)
