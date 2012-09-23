(defvar my-dired-mode-map nil)
(defvar my-dired-mode nil)
(defvar my-ex-isearch-next      "\C-r")
(defvar my-ex-isearch-prev      "\C-e")
(defvar my-ex-isearch-backspace "\C-h")
(defvar my-ex-isearch-return    "\C-g")
(defvar my-ex-isearch-returnkey    "\C-m")
(defvar my-ex-isearch-word "")

(if my-dired-mode-map
    ()
  (setq my-dired-mode-map (make-sparse-keymap))
  (define-key my-dired-mode-map ":" (function my-dired-mode))
  (define-key my-dired-mode-map "\C-m" (function my-dired-find-file))
  (define-key my-dired-mode-map "^" (function my-dired-up-directory))
  (define-key my-dired-mode-map "[" 'dired-maybe-insert-subdir)
  (define-key my-dired-mode-map "$" 'dired-hide-subdir)
  (define-key my-dired-mode-map "\M-$" 'dired-hide-all)
  (define-key my-dired-mode-map [down] 'dired-next-line)
  (define-key my-dired-mode-map [up] 'dired-previous-line)
  ;; Tree Dired commands
  (define-key my-dired-mode-map "\M-\C-?" 'dired-unmark-all-files)
  (define-key my-dired-mode-map "\M-\C-d" 'dired-tree-down)
  (define-key my-dired-mode-map "\M-\C-u" 'dired-tree-up)
  (define-key my-dired-mode-map "\M-\C-n" 'dired-next-subdir)
  (define-key my-dired-mode-map "\M-\C-p" 'dired-prev-subdir)
  (define-key my-dired-mode-map "*" (function my-dired-mark))
  (define-key my-dired-mode-map "\C-_" 'dired-undo)
  (define-key my-dired-mode-map "\C-xu" 'dired-undo)
  )

(defvar dired-mode-old-major-mode)
(defvar dired-mode-old-mode-name)
(defvar dired-mode-old-local-map)
(defvar my-dired-mode-hook nil)

(defun my-dired-mode ()
  (interactive)
  (if (eq major-mode 'my-dired-mode)
      (progn
        (dired-move-to-filename)
        (use-local-map dired-mode-old-local-map)
        (setq mode-name dired-mode-old-mode-name)
        (setq major-mode dired-mode-old-major-mode)
        (force-mode-line-update)
        )
    (setq dired-mode-old-local-map (current-local-map))
    (setq dired-mode-old-mode-name mode-name)
    (setq dired-mode-old-major-mode major-mode)
    (use-local-map my-dired-mode-map)
    (setq major-mode 'my-dired-mode)
    (setq mode-name "Explorer")
    (force-mode-line-update)
    (run-hooks 'my-dired-mode-hook))
  )

(defun my-ex-isearch (REGEX1 REGEX2 FUNC1 FUNC2 RPT)
  (interactive)
  (let ((input last-command-char)
        (inhibit-quit t)
        (oldpoint (point)) regx str (n 1))
    (save-match-data
      (catch 'END
        (while t
          (funcall FUNC1)
          (cond
           ;;end
           ((and (integerp input) (= input ?:))
            (setq unread-command-events (append (list input) unread-command-events))
            (throw 'END nil))

           ;; character
           ;;_.-+~#
           ((and (integerp input)
                 (or (and (>= input ?a) (<= input ?z))
                     (and (>= input ?A) (<= input ?Z))
                     (and (>= input ?0) (<= input ?9))))
            (setq str (char-to-string input))
            (if (string= my-ex-isearch-word str)
                (setq n 2)
              (setq n 1)
              )
            ;; .meadow.el meadow.el ¤ÏÆ±°ì»ë
            (setq regx (concat REGEX1 "[\.~#+_]*" str REGEX2))
            (if (not (re-search-forward regx nil t n))
                (progn
                  (goto-char (point-min))
                  (re-search-forward regx nil t nil)
                  ))
            (setq my-ex-isearch-word str))
           ;; backspace
           ((and (integerp input)
                 (or (eq 'backspace input)
                     (= input (string-to-char my-ex-isearch-backspace))))
            (setq str (if (eq 0 (length str)) str (substring str 0 -1)))
            (setq regx (concat REGEX1 str REGEX2))
            (goto-char oldpoint)
            (re-search-forward regx nil t nil))
           ;; next
           ((and (integerp input) (= input (string-to-char my-ex-isearch-next)))
            (re-search-forward regx nil t RPT))
           ;; previous
           ((and (integerp input) (= input (string-to-char my-ex-isearch-prev)))
            (re-search-backward regx nil t nil))
           ;; return
           ((and (integerp input) (= input (string-to-char my-ex-isearch-return)))
            (goto-char oldpoint)
            (message "return")
            (throw 'END nil))
           ;; other command
           (t
            (setq unread-command-events (append (list input) unread-command-events))
            (throw 'END nil)))
          (funcall FUNC2)
          ;;(highline-highlight-current-line)
          (message str)
          (setq input (read-event)))))))

(defun my-dired-isearch()
  (interactive)
  (my-ex-isearch "[0-9] " "[^ \n]+$"
                 (lambda()
                   (if (not (= (point-min) (point)))
                       (backward-char 3)))
                 'dired-move-to-filename 2))

(defun my-dired-isearch-define-key (str)
  (let ((i 0))
    (while (< i (length str))
      (define-key my-dired-mode-map (substring str i (1+ i)) 'my-dired-isearch)
      (setq i (1+ i)))))

(add-hook 'my-dired-mode-hook
          '(lambda ()
             (my-dired-isearch-define-key "abcdefghijklmnopqrstuvwxyz0123456789_.-+~#")
             ))
(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map ":" (function my-dired-mode))
             ))

(defun my-dired-find-file ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (and
         (eq major-mode 'my-dired-mode)
         (file-directory-p file))
        (progn
          (dired-my-advertised-find-file)
          (my-dired-mode))
      (dired-my-advertised-find-file)
      )
    )
  )

(defun my-dired-up-directory ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (and
         (eq major-mode 'my-dired-mode)
         (file-directory-p file))
        (progn
          (dired-my-up-directory)
          (my-dired-mode))
      (dired-my-up-directory)
      )
    )
  )

(defun my-dired-mark-toggle ()
  (interactive)
  (save-excursion
    (let (buffer-read-only)
      (beginning-of-line)
      (if (not (eobp))
          (or (dired-between-files)
              (looking-at dired-re-dot)
              (apply 'subst-char-in-region
                     (point) (1+ (point))
                     (if (eq ?\040 (following-char)) ; SPC
                         (list ?\040 dired-marker-char)
                       (list dired-marker-char ?\040))
                     ))
        (forward-line 1)))))

(defun my-dired-mark ()
  (interactive)
  (my-dired-mark-toggle)
  (dired-next-line 1))

