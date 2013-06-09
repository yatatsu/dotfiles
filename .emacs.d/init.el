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

;; http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf") ;point to directory which has conf file.

;; for Mac
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; except Terminal, hide toolbar and scrollbar
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))

(unless (eq window-system 'ns)
  (menu-bar-mode 0))

;; cl
(require 'cl)

