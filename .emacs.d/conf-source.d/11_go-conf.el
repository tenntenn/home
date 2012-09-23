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
