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
