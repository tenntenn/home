;; タブ
(setq-default tab-width 4)

;; 行番号
(require 'linum)

(setq linum-format
      '(lambda (line)
        (let ((fmt
               (let ((min-w 4)
                     (w (length (number-to-string
                                 (count-lines (point-min) (point-max))))))
                 (concat "%"
                         (number-to-string (if (< min-w w) w min-w))
                         "d"))))
          (propertize (format fmt line) 'face 'linum))))
(global-linum-mode)


;;現在カーソルがある行を強調表示する
(setq hl-line-face 'underline)
(global-hl-line-mode)

;;補完の終了した補完ウィンドウを閉じる
(require 'lcomp)
(lcomp-install)

;;簡単なマクロ
(defconst *dmacro-key* "\C-^" "繰返し指定キー")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)

;;kill-ringを表示
(require 'browse-kill-ring)
(global-set-key "\M-y" 'browse-kill-ring)

;;１段落の文字数
(setq fill-column 60)

;;自動改行
(turn-on-auto-fill)

;;物理移動
;; (load "physical-line")
;; (physical-line-on)
;; ;; dired-mode では使わない
;; (setq physical-line-ignoring-mode-list '(dired-mode))
;; (global-set-key "\C-p" 'previous-window-line)
;; (global-set-key "\C-n" 'next-window-line)
(global-set-key [up] 'scroll-down)
(global-set-key [down] 'scroll-up)
(global-set-key [left] 'move-beginning-of-line)
(global-set-key [right] 'move-end-of-line)

(defun previous-window-line (n)
  (interactive "p")
  (let ((cur-col
	 (- (current-column)
	    (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion (- n))
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook))
(defun next-window-line (n)
  (interactive "p")
  (let ((cur-col
	 (- (current-column)
	    (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion n)
    (move-to-column (+ (current-column) cur-col)))
  (run-hooks 'auto-line-hook))

;文字数カウント
(autoload 'word-count-mode "word-count"
          "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)

;;重複した行を消す
;;連続した行 M-x uniq-region
;;重複した行 M-x uniq-remove-dup-lines
(load "uniq")

;;ある時点まで戻す
(require 'undo-group)
;; グループアンドゥ
(global-set-key "\M-]" 'undo-group)
;; グループアンドゥの記録
(global-set-key "\M-}" 'undo-group-boundary)
(defadvice save-buffer
  (after advice-by-undo-group activate)
  (if buffer-undo-list
      ()
    (undo-group-boundary)))

;;しおり
(require 'bm)
(global-set-key "\C-c;" 'bm-previous)
(global-set-key "\C-c:" 'bm-next)
(global-set-key "\M-?" 'bm-toggle)
;; ;;移動前に現在行をしおりに追加
;; (defun bm-set-bookmark-befor-goto ()
;;   (if (or (bm-bookmark-at (point))
;;           (string= last-command 'bm-next)
;;           (string= last-command 'bm-previous))
;;       ()
;;     (bm-toggle))
;;   )
;; (defadvice bm-goto  (before set-bookmark-before-next activate)
;;   "advice"
;;   (bm-set-bookmark-befor-goto)
;;   )

;; Display Line Number
(global-set-key "\M-n" 'linum-mode)
