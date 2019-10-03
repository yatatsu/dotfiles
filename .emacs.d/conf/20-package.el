;; 
;; 20-package.el
;;

;; -------------------
;; package
;; -------------------

(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize))

;; auto install package
;; ;; from http://qiita.com/catatsuy/items/5f1cd86e2522fd3384a0

(defvar installing-package-list
  '(
	;; mode
	js2-mode
	markdown-mode
	yaml-mode
	rinari
	haml-mode
	haskell-mode
	ghc
	;; git
	magit
	git-commit-mode
	git-rebase-mode
	;; other
	flycheck
	multi-term
	undo-tree
	wgrep
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
