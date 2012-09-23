(iswitchb-mode)
(add-hook 'iswitchb-define-mode-map-hook
	  'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match))

(defun iswitchb-possible-new-buffer (buf)
  "Possibly create and visit a new buffer called BUF."
  (interactive)
  (message (format
	    "No buffer matching `%s', "
	    buf))
  (sit-for 1)
  (call-interactively 'find-file buf))
(defun iswitchb-buffer (arg)
  "Switch to another buffer.
The buffer name is selected interactively by typing a substring.  The
buffer is displayed according to `iswitchb-default-method' -- the
default is to show it in the same window, unless it is already visible
in another frame.
For details of keybindings, do `\\[describe-function] iswitchb'."
  (interactive "P")
  (if arg
      (call-interactively 'switch-to-buffer)
    (setq iswitchb-method iswitchb-default-method)
    (iswitchb)))
;;;

(global-set-key "\C-c2" 'speedbar)
(global-set-key "\C-co" 'other-frame)
(add-hook 'speedbar-load-hook
	  '(lambda()
	     (setq initial-frame-alist
		   '((top 0) (left 0) (width . 112) (height . 45)))))

;;最近開いたファイル
(recentf-mode 1)
(global-set-key "\C-cro" 'recentf-open-files)

;;開いていたバッファを記録しておく
;;;; 保存しないファイルの正規表現
;; (setq desktop-files-not-to-save "\\(^/[^/:]*:\\|\\.diary$\\)")
;; (autoload 'desktop-save "desktop" nil t)
;; (autoload 'desktop-clear "desktop" nil t)
;; (autoload 'desktop-load-default "desktop" nil t)
;; (autoload 'desktop-remove "desktop" nil t)

;;diredの拡張"\C-x \C-j"で開くなど
(load "dired-x")
(load "my-dired-mode")

;; カーソルでフレーム間を移動
(windmove-default-keybindings)
(global-set-key "\C-c\C-b" 'windmove-left)
(global-set-key "\C-c\C-f" 'windmove-right)
(global-set-key "\C-c\C-p" 'windmove-up)
(global-set-key "\C-c\C-n" 'windmove-down)

;; ツールバーを消す
(tool-bar-mode 0)

;; 最大化
(setq initial-frame-alist '((top 0) (left 2) (width . 175) (height . 50)))
