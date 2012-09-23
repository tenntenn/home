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
