;; 
;; 20-package.el
;;

;; -------------------
;; package
;; -------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; auto install package
;; ;; from http://qiita.com/catatsuy/items/5f1cd86e2522fd3384a0

(defvar installing-package-list
  '(
	;; mode
	php-mode
	markdown-mode
	js2-mode
	yaml-mode
	rinari
	haml-mode
	;; git
	magit
	git-gutter-fringe+
	git-commit-mode
	git-rebase-mode
	;; other
	flycheck
	multi-term
	undo-tree
	wgrep
	anzu
	hlinum
	powerline
	))

(let ((not-installed (loop for x in installing-package-list
                           when (not (package-installed-p x))
                           collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))
