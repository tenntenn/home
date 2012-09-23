(global-set-key "\C-c3" 'smart-compile)

(global-set-key "\C-c4" 'eval-region)

;; \C-hで一文字消す(バックスペース)
(global-set-key "\C-h" 'delete-backward-char)

;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; バックスラッシュ
(define-key global-map [?¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])
