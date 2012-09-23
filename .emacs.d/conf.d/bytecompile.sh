#!/bin/sh

emacs --batch --eval '(let ((dir (expand-file-name "~/.emacs.d/mypackages/"))) (if (member dir load-path) nil    (setq load-path (cons dir load-path))   (let ((default-directory dir))      (load (expand-file-name "subdirs.el") t t t))))' -f batch-byte-compile *.el
