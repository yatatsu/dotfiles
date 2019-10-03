;;; -*- coding: utf-8; mode: emacs-lisp; -*-
;;; init.el
;;; yatatsukitagawa <yatatsukitagwa@gmail.com>

;; ~/.emacs.d/elisp ディレクトリ
(add-to-list 'load-path "~/.emacs.d/elisp")

;; for under-23 version
(when (> emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d"))

;; add-load-path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	    (add-to-list 'load-path default-directory)
	    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
		(normal-top-level-add-subdirs-to-load-path))))))

;; add directory with add-load-path
(add-to-load-path "elisp" "conf" "public_repos")

;; ------------------
;; common Lisp
;; ------------------

(require 'cl)

;; ------------------
;; elisp
;; ------------------

;; auto install
(when (require 'auto-install nil t)
    (setq auto-install-directory "~/.emacs.d/elisp/")
      ;; EmacsWikiに登録されているelisp名を取得
      (auto-install-update-emacswiki-package-name t)
	  ;; install-elisp の関数を利用可能に
	  (auto-install-compatibility-setup))

;; ------------------
;; init-loader
;; ------------------

;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf") ;point to directory which has conf file.

;; ------------------
;; auto-save
;; ------------------
;; バックアップファイルの作成場所をauto-save-listに
(add-to-list 'backup-directory-alist
	     (cons "." "~/.emacs.d/auto-save-list/"))
(setq auto-save-file-name-transforms
      `((".*" , (expand-file-name "~/.emacs.d/auto-save-list/") t)))

;; ------------------
;; save option
;; ------------------
;; ファイルが#!から始まる場合, +xをつけて保存
(add-hook 'after-save-hook
	    'executable-make-buffer-file-executable-if-script-p)

;; ----------------------------
;; for doc
;; ----------------------------
;; キャッシュを作成
(setq woman-manpath '("/usr/bin/man"
					  "/usr/share/man"
					  "/usr/local/share/man"
					  "/sur/local/share/man/ja"))
